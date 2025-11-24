function zombie_unstuck(old_x, old_y) {
    var has_movement = (x_speed != 0 || y_speed != 0);
    
    if (has_movement && x == old_x && y == old_y) {
        stuck_counter++;
        
        if (stuck_counter >= 5) {
            image_xscale *= -1;
            
            state = states.idle;
            idle_state = 0;
            x_speed = 0;
            y_speed = 0;
            stuck_counter = 0;
        }
    } else {
        stuck_counter = 0;
    }
    
	// if zombie is stuckk in a collider
    if (place_meeting(x, y, obj_collider)) {
        var push_distance = 2;
        var max_attempts = 25;
        var freed = false;
        
        for (var i = 0; i < max_attempts; i++) {
            if (!place_meeting(x, y - push_distance, obj_collider)) {
                y -= push_distance;
                freed = true;
                break;
            }
            if (!place_meeting(x, y + push_distance, obj_collider)) {
                y += push_distance;
                freed = true;
                break;
            }
            if (!place_meeting(x - push_distance, y, obj_collider)) {
                x -= push_distance;
                freed = true;
                break;
            }
            if (!place_meeting(x + push_distance, y, obj_collider)) {
                x += push_distance;
                freed = true;
                break;
            }
            push_distance += 2;
        }
        
        if (!freed) {
            state = states.idle;
            idle_state = 0;
            x_speed = 0;
            y_speed = 0;
            stuck_counter = 0;
        }
    }
}