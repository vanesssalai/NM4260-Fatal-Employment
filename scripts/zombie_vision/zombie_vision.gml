function zombie_vision(ox, oy) {
    if (instance_exists(obj_player)) {
        var dist = point_distance(ox, oy, obj_player.x, obj_player.y);
        var angle_to_player = point_direction(ox, oy, obj_player.x, obj_player.y);
        var facing_dir = (face == right) ? 0 : 180;
        var ang_diff = angle_difference(facing_dir, angle_to_player);
    
        var wall_hit = noone;
        if (cone_angle != 360) {
            wall_hit = collision_line(ox, oy, obj_player.x, obj_player.y, obj_collider, true, true);
        }
    
        if (cone_angle != 360) {
            if (dist <= sight_range && abs(ang_diff) <= cone_half && wall_hit == noone) {
                see_player = true;
                memory_timer = memory_duration;
                flip_count = 0;
                flip_delay = 0;
            } else {
                see_player = false;
            }
        } else {
            if (dist <= sight_range) {
                see_player = true;
            } else {
                see_player = false;
            }
        }
    }
    
    if (see_player) {
        last_seen_x = obj_player.x;
        last_seen_y = obj_player.y;
        memory_timer = memory_duration;
    }
}