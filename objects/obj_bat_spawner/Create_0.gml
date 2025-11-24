object_to_spawn = obj_bat;
item_name = "Baseball Bat"; 
count = 1;
is_active = false;

if (object_to_spawn == noone) {
    show_debug_message("ERROR: object_to_spawn is noone!");
    instance_destroy();
    exit;
}


spawn_items = function() {
    repeat(count) {
        var max_attempts = 100;
        var spawned = false;
        
        for (var attempt = 0; attempt < max_attempts; attempt++) {
            var random_x = irandom_range(bbox_left, bbox_right);
            var random_y = irandom_range(bbox_top, bbox_bottom);
            
            var has_collision = (collision_point(random_x, random_y, obj_collider, false, true) || collision_point(random_x, random_y, obj_no_spawn_zone, false, true));
            
            if (!has_collision) {
                instance_create_layer(random_x, random_y, "Interactable", object_to_spawn);
                show_debug_message("mk Spawned " + item_name + " at X: " + string(random_x) + ", Y: " + string(random_y));
                spawned = true;
                break;
            }
        }
        
        if (!spawned) {
            show_debug_message("WARNING: Could not find valid spawn position for " + item_name);
        }
    }
    instance_destroy();
}