if (item_data != undefined && instance_exists(obj_tut) && instance_exists(obj_player)) {
    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (first_interaction == false && 
        obj_tut.tutorial_stage == TUTORIAL_STAGE.TALK_TO_NPC && 
        !obj_tut.first_npc_interaction_done) {
        
        obj_tut.first_npc_interaction_done = true;
        obj_tut.tutorial_text = "";
        
        if (array_length(item_data.subquests) > 0) {
            obj_tut.item_name_to_pickup = item_data.subquests[0].item_name;
        }
        obj_tut.alarm[1] = 60;
    }
    
    if (!first_interaction && 
        current_subquest_index == 1 && 
        obj_tut.tutorial_stage == TUTORIAL_STAGE.RETURN_ITEM && 
        !obj_tut.item_returned) {
        
        obj_tut.item_returned = true;
        obj_tut.alarm[3] = 90;
        show_debug_message("Tutorial: Item returned, triggering alarm[3]");
    }
    
    if (obj_tut.tutorial_stage == TUTORIAL_STAGE.TOGGLE_MINIMAP && 
        !tutorial_second_interaction && 
        obj_tut.quest_toggled &&
        dist <= interact_range && 
        keyboard_check_pressed(vk_space) && 
        !instance_exists(obj_dialogue_parent)) {
        
        tutorial_second_interaction = true;
        obj_tut.second_npc_talk_done = true;
        
        var dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);
        
        for (var i = 0; i < array_length(item_data.final_dialog); i++) {
            dialogue_instance.dialog.add(
                item_data.final_dialog[i].name,
                item_data.final_dialog[i].message
            );
        }
        
        return;
    }
    
    if (obj_tut.tutorial_stage == TUTORIAL_STAGE.GET_PASSCODE && 
        !tutorial_third_interaction && 
        obj_tut.minimap_toggled &&
        dist <= interact_range && 
        keyboard_check_pressed(vk_space) && 
        !instance_exists(obj_dialogue_parent)) {
        
        tutorial_third_interaction = true;
        obj_tut.third_npc_talk_done = true;
        
        var dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);
        
        for (var i = 0; i < array_length(item_data.repeat_dialog); i++) {
            dialogue_instance.dialog.add(
                item_data.repeat_dialog[i].name,
                item_data.repeat_dialog[i].message
            );
        }
        
        obj_tut.alarm[6] = 90;
        
        return;
    }
    
    if (tutorial_third_interaction && 
        quest_complete &&
        dist <= interact_range && 
        keyboard_check_pressed(vk_space) && 
        !instance_exists(obj_dialogue_parent)) {
        
        var dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);
        dialogue_instance.dialog.add("Rina", "Head to the door at the end. Passcode: [" + obj_tut.password + "]");
        
        return;
    }
}

event_inherited();