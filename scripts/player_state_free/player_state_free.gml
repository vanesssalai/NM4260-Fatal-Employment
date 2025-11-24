function player_state_free() {
    var prev_x = x;
    var prev_y = y;
    var has_input = (x_axis != 0 || y_axis != 0);
    
    if (magnitude != 0) {
        x_axis /= magnitude;
        y_axis /= magnitude;
        x_speed = x_axis * move_speed;
        y_speed = y_axis * move_speed;
    } else {
        x_speed = 0;
        y_speed = 0;
    }
    
    if (x_speed != 0) {
        var x_dir = sign(x_speed);
        var x_move = abs(x_speed);
        
        repeat(x_move) {
            if (!place_meeting(x + x_dir, y, obj_collider)) {
                x += x_dir;
            } else {
                break;
            }
        }
    }
    
    if (y_speed != 0) {
        var y_dir = sign(y_speed);
        var y_move = abs(y_speed);
        
        repeat(y_move) {
            if (!place_meeting(x, y + y_dir, obj_collider)) {
                y += y_dir;
            } else {
                break;
            }
        }
    }
    
	// anti-stuck
    if (has_input && x == prev_x && y == prev_y) {
        stuck_counter++;
        
        if (stuck_counter >= 3) {
            var nudge_distance = 2;
            var move_dir_x = sign(x_axis);
            var move_dir_y = sign(y_axis);
            
            var check_distance = 16;
            var target_x = x + (move_dir_x * check_distance);
            var target_y = y + (move_dir_y * check_distance);
            
            var blocked = collision_line(x, y, target_x, target_y, obj_collider, false, true);
            
            if (!blocked) {
                x += move_dir_x * nudge_distance;
                y += move_dir_y * nudge_distance;
                show_debug_message("Player unstuck - nudged forward");
                stuck_counter = 0;
            }
        }
    } else {
        stuck_counter = 0;
    }
    
    if (place_meeting(x, y, obj_collider)) {
        var push_distance = 1;
        var max_attempts = 50;
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
            push_distance++;
        }
        
        if (!freed) {
            x = spawn_x;
            y = spawn_y;
            show_debug_message("Player teleported to spawn - couldn't escape collision");
        }
    }
    
    // Zombie collision
    if (place_meeting(x, y, obj_zombie)) {
		audio_play_sound(snd_lose_a_life, 0, false)
        life -= 1;
        x = spawn_x;
        y = spawn_y;
        x_speed = 0;
        y_speed = 0;
    }
    
    if (x_speed > 0) {face = right};
    if (x_speed < 0) {face = left};
    if (y_speed > 0) {face = down};
    if (y_speed < 0) {face = up};
    
    var current_life = clamp(life, 1, max_life);

var current_sprite_set = is_speed_boosted ? sprite_coffee[current_life] : sprite[current_life];

if (x_speed == 0 && y_speed == 0) {
    sprite_index = current_sprite_set[still];
} else {
    sprite_index = current_sprite_set[face];
}
    
    last_x = x;
    last_y = y;
}