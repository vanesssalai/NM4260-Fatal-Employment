function zombie_collision() {
    // Horizontal movement
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
    
    // Vertical movement
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
}