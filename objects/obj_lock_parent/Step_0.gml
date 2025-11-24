if (is_locked && instance_exists(obj_player)) {
    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (dist <= interact_range && keyboard_check_pressed(vk_space) && !is_interface_open) {
        is_interface_open = true;
        current_input = "";
    }
}

if (is_interface_open) {
	global.game_state = GAME_STATE.PAUSED;
	
	var _mouse_gui_x = device_mouse_x_to_gui(0);
	var _mouse_gui_y = device_mouse_y_to_gui(0);
	
	close_button_hover = point_in_rectangle(
		_mouse_gui_x, 
		_mouse_gui_y,
		close_button_x,
		close_button_y,
		close_button_x + close_button_width,
		close_button_y + close_button_height
	);
	
	if (close_button_hover && mouse_check_button_pressed(mb_left)) {
		is_interface_open = false;
		current_input = "";
		global.game_state = GAME_STATE.RUNNING;
		audio_play_sound(snd_keypad_beep_1, 0, false);
	}
	
    if (keyboard_check_pressed(ord("0"))) {handle_number_input(0); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("1"))) {handle_number_input(1); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("2"))) {handle_number_input(2); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("3"))) {handle_number_input(3); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("4"))) {handle_number_input(4); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("5"))) {handle_number_input(5); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("6"))) {handle_number_input(6); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("7"))) {handle_number_input(7); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("8"))) {handle_number_input(8); audio_play_sound(snd_keypad_beep_1, 0, false);}
    if (keyboard_check_pressed(ord("9"))) {handle_number_input(9); audio_play_sound(snd_keypad_beep_1, 0, false);}
    
    if (keyboard_check_pressed(vk_backspace)) {
        delete_last_digit();
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
}

if (is_locked == false && instance_exists(obj_player)) {
    if (unlocked_sprite != noone) {
        sprite_index = unlocked_sprite;
    }
    
    if (place_meeting(x, y, obj_player) || distance_to_object(obj_player) = 0) {
        show_debug_message("Player entering door");
        if (next_room != noone && next_room != -1) {
            room_goto(next_room);
        }
    }
}