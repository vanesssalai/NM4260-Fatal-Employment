event_inherited();

if (current_input == password) {
    is_locked = false;
    is_interface_open = false;
    show_debug_message("Correct password!");
    global.game_state = GAME_STATE.RUNNING;
    
    if (instance_exists(obj_tut) && obj_tut.tutorial_stage == TUTORIAL_STAGE.USE_DOOR) {
        obj_tut.door_unlocked = true;
        obj_tut.tutorial_stage = TUTORIAL_STAGE.WALK_TO_DOOR;
        obj_tut.tutorial_text = "Walk into the staircase to continue";
    }
	
	    if (keyboard_check_pressed(vk_enter)) {
        if (string_length(current_input) == password_length) {
	        if (current_input == password) {
		        is_locked = false;
				audio_play_sound(snd_door_open, 0, false);
		        is_interface_open = false;
		        show_debug_message("Correct password!");
				global.game_state = GAME_STATE.RUNNING;
		        return true;
		    } else {
		        show_debug_message("Wrong password!");
				audio_play_sound(snd_keypad_wrong, 0, false);
				show_debug_message(current_input)
		        current_input = "";
		        return false;
		    }
        } else {
            show_debug_message("Password incomplete!");
			audio_play_sound(snd_keypad_wrong, 0, false);
        }
    }
    
    return true;
}