if (!is_active) {
    return;
}

for (var i = array_length(spawned_zombies) - 1; i >= 0; i--) {
    if (!instance_exists(spawned_zombies[i])) {
        array_delete(spawned_zombies, i, 1);
    }
}

var current_zombie_count = array_length(spawned_zombies);

if (current_zombie_count < max_zombies) {
    spawn_timer--;
    
    if (spawn_timer <= 0) {
        spawn_timer = spawn_interval;
        
        var max_attempts = 50;
        var spawned = false;
        
        for (var attempt = 0; attempt < max_attempts; attempt++) {
            var random_x = irandom_range(bbox_left, bbox_right);
            var random_y = irandom_range(bbox_top, bbox_bottom);
            
            var has_collision = (collision_point(random_x, random_y, obj_collider, false, true) || collision_point(random_x, random_y, obj_no_spawn_zone, false, true));
            
            if (!has_collision) {
                var dist_from_player = 999999;
                if (instance_exists(obj_player)) {
                    dist_from_player = point_distance(random_x, random_y, obj_player.x, obj_player.y);
                }
                
                if (dist_from_player >= min_distance_from_player) {
                    var new_zombie = instance_create_layer(random_x, random_y, "Interactable", object_to_spawn);
                    array_push(spawned_zombies, new_zombie);
                    
                    show_debug_message("Zombie spawned at (" + string(random_x) + ", " + string(random_y) + ")");
                    show_debug_message("Active zombies: " + string(array_length(spawned_zombies)) + "/" + string(max_zombies));
                    
                    spawned = true;
                    break;
                }
            }
        }
        
        if (!spawned) {
            show_debug_message("WARNING: Could not spawn zombie after " + string(max_attempts) + " attempts");
        }
    }
}