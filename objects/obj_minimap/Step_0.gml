if (keyboard_check_pressed(toggle_key)) {
    is_visible = !is_visible;
    
    if (is_visible) {
        show_debug_message("--- OPENING MINIMAP ---");
        show_debug_message("npc_list length: " + string(array_length(npc_list)));
        show_debug_message("Workers in room: " + string(instance_number(obj_office_worker_parent)));
        
        if (array_length(npc_list) != instance_number(obj_office_worker_parent)) {
            show_debug_message("MISMATCH DETECTED - Refreshing...");
            setup_npc_tracking();
        }
        
        global.game_state = GAME_STATE.PAUSED;
    } else {
        global.game_state = GAME_STATE.RUNNING;
    }
}

if (is_visible && array_length(npc_list) > 0) {
    for (var i = 0; i < array_length(npc_list); i++) {
        var npc = npc_list[i];
        
        if (instance_exists(npc.instance)) {
            var map_pos = world_to_minimap(npc.instance.x, npc.instance.y);
            npc.minimap_x = map_pos.x;
            npc.minimap_y = map_pos.y;
            
            var room_area = instance_position(npc.instance.x, npc.instance.y, obj_room_area_parent);
            if (room_area != noone) {
                npc.room_name = room_area.room_name;
            } else {
                npc.room_name = "Unknown";
            }
        }
    }
}