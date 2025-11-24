function zombie_search() {
    var dist_to_last_seen = point_distance(x, y, last_seen_x, last_seen_y);
    
    if (dist_to_last_seen > 5) { 
        var move_dir = point_direction(x, y, last_seen_x, last_seen_y);
        x_speed = lengthdir_x(move_speed, move_dir);
        y_speed = lengthdir_y(move_speed, move_dir);
    } else {
        x_speed = 0;
        y_speed = 0;
    }
    
    memory_timer--;
}