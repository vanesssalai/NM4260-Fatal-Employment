if (!intro_active) {
    return;
}

switch (intro_phase) {
    case 0:
        black_timer++;
        
        if (black_timer >= black_screen_duration) {
            intro_phase = 1;
        }
        break;
        
    case 1:
    fade_alpha -= 1 / fade_duration;
    
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        intro_phase = 2;
        intro_active = false;
        
        global.game_state = GAME_STATE.RUNNING;
        
        if (intro_dialogue != undefined && !instance_exists(obj_dialogue_parent)) {
            var dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);
            
            for (var i = 0; i < array_length(intro_dialogue); i++) {
                if (variable_struct_exists(intro_dialogue[i], "type") && intro_dialogue[i].type == "choice") {
                    dialogue_instance.dialog.add_choice(
                        intro_dialogue[i].prompt,
                        intro_dialogue[i].choices
                    );
                } else {
                    dialogue_instance.dialog.add(
                        intro_dialogue[i].name,
                        intro_dialogue[i].message
                    );
                }
            }
        }
        
        instance_destroy();
    }
    break;
}