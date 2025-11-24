object_to_spawn = obj_unknown;
count = 3;
min_distance_between_unknowns = 400;

if (object_to_spawn == noone) {
    instance_destroy();
    exit;
}

repeat(count) {
    var max_attempts = 100;
    var spawned = false;
    
    for (var attempt = 0; attempt < max_attempts; attempt++) {
        var random_x = irandom_range(bbox_left, bbox_right);
        var random_y = irandom_range(bbox_top, bbox_bottom);
        
        var has_collision = (collision_point(random_x, random_y, obj_collider, false, true) || collision_point(random_x, random_y, obj_no_spawn_zone, false, true));
        
        if (!has_collision) {
            var too_close = false;
            
            with (obj_unknown) {
                var dist = point_distance(x, y, random_x, random_y);
                if (dist < other.min_distance_between_unknowns) {
                    too_close = true;
                    break;
                }
            }
            
            if (!too_close) {
                instance_create_layer(random_x, random_y, "Interactable", object_to_spawn);
                spawned = true;
                break;
            }
        }
    }
    
    if (!spawned) {
    }
}

instance_destroy();