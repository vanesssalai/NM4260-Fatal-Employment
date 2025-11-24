if (!consumed && instance_exists(obj_player)) {
    if (place_meeting(x, y, obj_player)) {
        if (!variable_instance_exists(obj_player, "original_speed")) {
            obj_player.original_speed = obj_player.move_speed;
        }
        
        obj_player.move_speed = obj_player.original_speed * 2;
        obj_player.speed_boost_timer = 30; 
        obj_player.has_speed_boost = true;
        
        show_debug_message("Temporary speed boost! Duration: 5 seconds");
        
        consumed = true;
        instance_destroy();
    }
}