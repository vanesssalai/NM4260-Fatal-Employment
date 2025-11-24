if (keyboard_check_pressed(vk_escape)) {  
    global.game_state = GAME_STATE.PAUSED;
        
    if (pause_dialogue != undefined && !instance_exists(obj_dialogue_parent)) {
        var dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);
            
        for (var i = 0; i < array_length(pause_dialogue); i++) {
            if (variable_struct_exists(pause_dialogue[i], "type") && pause_dialogue[i].type == "choice") {
                dialogue_instance.dialog.add_choice(
                    pause_dialogue[i].prompt,
                    pause_dialogue[i].choices
                );
            } else {
                dialogue_instance.dialog.add(
                    pause_dialogue[i].name,
                    pause_dialogue[i].message
                );
            }
        }
    }
} 