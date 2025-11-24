function zombie_pursue() {
    if (alert_timer <= 0) {
        just_found_player = false;
    }
    
    var move_dir = point_direction(x, y, obj_player.x, obj_player.y);
    
    var check_distance = 48;
    var check_x = x + lengthdir_x(check_distance, move_dir);
    var check_y = y + lengthdir_y(check_distance, move_dir);
    var wall_ahead = collision_line(x, y, check_x, check_y, obj_collider, true, true);
    
    var final_move_dir = move_dir;
    
    if (wall_ahead == noone) {
        x_speed = lengthdir_x(move_speed, move_dir);
        y_speed = lengthdir_y(move_speed, move_dir);
        final_move_dir = move_dir;
    } else {
		// wall in the way
        var perp_dir1 = move_dir + 45;
        var perp_dir2 = move_dir - 45;
        
        var check1_x = x + lengthdir_x(check_distance, perp_dir1);
        var check1_y = y + lengthdir_y(check_distance, perp_dir1);
        var wall1 = collision_line(x, y, check1_x, check1_y, obj_collider, true, true);
        
        var check2_x = x + lengthdir_x(check_distance, perp_dir2);
        var check2_y = y + lengthdir_y(check_distance, perp_dir2);
        var wall2 = collision_line(x, y, check2_x, check2_y, obj_collider, true, true);
        
        if (wall1 == noone) {
            x_speed = lengthdir_x(move_speed, perp_dir1);
            y_speed = lengthdir_y(move_speed, perp_dir1);
            final_move_dir = perp_dir1;
        } else if (wall2 == noone) {
            x_speed = lengthdir_x(move_speed, perp_dir2);
            y_speed = lengthdir_y(move_speed, perp_dir2);
            final_move_dir = perp_dir2;
        } else {
            x_speed = lengthdir_x(move_speed * 0.5, move_dir);
            y_speed = lengthdir_y(move_speed * 0.5, move_dir);
            final_move_dir = move_dir;
        }
    }
    
    if (abs(x_speed) > abs(y_speed)) {
        face = (x_speed > 0) ? right : left;
    } else {
        face = (y_speed > 0) ? down : up;
    }
    
    cone_angle = 360;
    cone_half = cone_angle / 2;
    flip_count = 0;
}