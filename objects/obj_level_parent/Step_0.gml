if (!completion_dialogue_shown && instance_exists(obj_quest_tracker)) {
    obtained_length = obj_quest_tracker.quests.get_obtained_password_count();
    
    if (obtained_length >= password_length && password_length > 0) {
        completion_dialogue_shown = true;
        
        if (!instance_exists(obj_dialogue_parent) && array_length(complete_dialogue) > 0) {
            var dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);
            
            for (var i = 0; i < array_length(complete_dialogue); i++) {
                dialogue_instance.dialog.add(
                    complete_dialogue[i].name,
                    complete_dialogue[i].message
                );
            }
            
            show_debug_message("=== ALL QUESTS COMPLETE ===");
            show_debug_message("Password collected: " + string(obtained_length) + "/" + string(password_length));
        }
    }
}