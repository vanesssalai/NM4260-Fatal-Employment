function zombie_idle() {
    just_found_player = false;
    
    if (just_lost_player && !look_around_complete) {
        x_speed = 0;
        y_speed = 0;
        
        if (flip_count < max_flips) {
            if (flip_delay < room_speed * 0.5) {
                flip_delay++;
            } else {
                switch (face) {
                    case right: face = down; break;
                    case down:  face = left; break;
                    case left:  face = up;   break;
                    case up:    face = right; break;
                    default:    face = down; break;
                }
                
                cone_angle = 80;
                cone_half = cone_angle / 2;
                flip_count++;
                flip_delay = 0;
            }
        } else {
            look_around_complete = true;
            just_lost_player = false;
            idle_state = 0;
            flip_count = 0;
            flip_delay = 0;
        }
        return;
    }
    
    switch (idle_state) {
        case 0:
            var action = choose(0, 1, 1);
            
            if (action == 0 && flip_count < max_flips) {
                var possible_faces = [right, down, left, up];
                var new_face = possible_faces[irandom(3)];
                
                var attempts = 0;
                while (new_face == face && attempts < 10) {
                    new_face = possible_faces[irandom(3)];
                    attempts++;
                }
                
                face = new_face;
                cone_angle = 80;
                cone_half = cone_angle / 2;
                flip_count++;
                idle_timer = room_speed * random_range(0.5, 1.0);
                idle_state = 2;
                x_speed = 0;
                y_speed = 0;
            } else {
                var attempts = 0;
                var found_target = false;
                
                while (attempts < 16 && !found_target) {
                    var cardinal_angles = [0, 90, 180, 270];
                    var roam_dir = cardinal_angles[irandom(3)];
                    var roam_dist = irandom_range(32, 2000);
                    
                    var target_x = x + lengthdir_x(roam_dist, roam_dir);
                    var target_y = y + lengthdir_y(roam_dist, roam_dir);
                    
                    var wall_in_path = collision_line(x, y, target_x, target_y, obj_collider, true, true);
                    var target_in_wall = place_meeting(target_x, target_y, obj_collider);
                    
                    if (wall_in_path == noone && !target_in_wall) {
                        idle_target_x = target_x;
                        idle_target_y = target_y;
                        found_target = true;
                        idle_state = 1;
                        idle_stuck_counter = 0;
                    }
                    attempts++;
                }
                
                if (!found_target) {
                    var possible_faces = [right, down, left, up];
                    face = possible_faces[irandom(3)];
                    idle_timer = room_speed * 1.0;
                    idle_state = 2;
                    x_speed = 0;
                    y_speed = 0;
                }
            }
            break;
			
        case 1:
            var dist_to_target = point_distance(x, y, idle_target_x, idle_target_y);
            
            if (dist_to_target > 2) {
                var move_dir = point_direction(x, y, idle_target_x, idle_target_y);
                var check_x = x + lengthdir_x(16, move_dir);
                var check_y = y + lengthdir_y(16, move_dir);
                var wall_ahead = collision_line(x, y, check_x, check_y, obj_collider, true, true);
                
                if (wall_ahead == noone) {
                    x_speed = lengthdir_x(idle_move_speed, move_dir);
                    y_speed = lengthdir_y(idle_move_speed, move_dir);
                    
                    if (abs(x_speed) > abs(y_speed)) {
                        face = (x_speed > 0) ? right : left;
                    } else {
                        face = (y_speed > 0) ? down : up;
                    }
                } else {
                    x_speed = 0;
                    y_speed = 0;
                    idle_state = 0;
                }
            } else {
                x_speed = 0;
                y_speed = 0;
                idle_timer = room_speed * random_range(0.5, 2.0);
                idle_state = 2;
            }
            break;
			
        case 2:
            x_speed = 0;
            y_speed = 0;
            idle_timer--;
            
            if (idle_timer <= 0) {
                idle_state = 0;
            }
            break;
    }
}