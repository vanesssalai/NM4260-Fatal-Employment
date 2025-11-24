if (showing_dialog == false && showing_choices == false) {
	if (dialog.count() <= 0) {
		global.game_state = GAME_STATE.RUNNING;
		
		if (audio_is_playing(current_sound_instance)) {
			audio_stop_sound(current_sound_instance);
		}
		
		instance_destroy();
		return;
	}
	
	current_dialog = dialog.pop();
	
	var should_play_sound = false;
	if (variable_struct_exists(current_dialog, "name")) {
		if (current_dialog.name != "" && current_dialog.name != undefined) {
			should_play_sound = true;
		}
	}
	
	if (should_play_sound) {
		if (audio_is_playing(current_sound_instance)) {
			audio_stop_sound(current_sound_instance);
		}
		current_sound_instance = audio_play_sound(dialogue_sound, 1, false, dialogue_volume);
	}
	
	if (current_dialog.type == "choice") {
		showing_choices = true;
		choices = current_dialog.choices;
		choice_hover = -1;
		alpha = 0;
		global.game_state = GAME_STATE.PAUSED;
	} else {
		showing_dialog = true;
		alpha = 0;
		global.game_state = GAME_STATE.PAUSED;
	}
} else if (showing_choices) {
	alpha = min(alpha + 0.1, 1);
	
	var _mouse_gui_x = device_mouse_x_to_gui(0);
	var _mouse_gui_y = device_mouse_y_to_gui(0);
	
	var _gui_width = display_get_gui_width();
	var _gui_height = display_get_gui_height();
	var _box_height = 200;
	var _box_y = _gui_height - _box_height;
	
	var _total_choices_height = (array_length(choices) * choice_height) + ((array_length(choices) - 1) * choice_spacing);
	var _start_y = _box_y + (_box_height - _total_choices_height) / 2;
	
	choice_hover = -1;
	for (var i = 0; i < array_length(choices); i++) {
		var _choice_y = _start_y + (i * (choice_height + choice_spacing));
		var _choice_width = _gui_width - (choice_padding * 4);
		var _choice_x = choice_padding * 2;
		
		if (_mouse_gui_x >= _choice_x && _mouse_gui_x <= _choice_x + _choice_width &&
		    _mouse_gui_y >= _choice_y && _mouse_gui_y <= _choice_y + choice_height) {
			choice_hover = i;
			
			if (mouse_check_button_pressed(mb_left)) {
				choice_selected = i;
				
				
				if (audio_is_playing(current_sound_instance)) {
					audio_stop_sound(current_sound_instance);
				}
				
				var will_have_name = false;
				if (variable_struct_exists(choices[i], "response") && array_length(choices[i].response) > 0) {
					if (variable_struct_exists(choices[i].response[0], "name")) {
						if (choices[i].response[0].name != "" && choices[i].response[0].name != undefined) {
							will_have_name = true;
						}
					}
				}
				
				if (will_have_name) {
					current_sound_instance = audio_play_sound(dialogue_sound, 1, false, dialogue_volume);
				}
				
				if (variable_struct_exists(choices[i], "response")) {
					dialog.add_response(choices[i].response);
				}
				
				if (variable_struct_exists(choices[i], "callback")) {
					choices[i].callback();
				}
				
				showing_choices = false;
				alpha = 0;
				break;
			}
		}
	}
	
} else {
	alpha = min(alpha + 0.1, 1);
	
	if (mouse_check_button_pressed(mb_left)) {
		if (audio_is_playing(current_sound_instance)) {
			audio_stop_sound(current_sound_instance);
		}
		
		showing_dialog = false;
		alpha = 0;
	}
}