var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();

// Calculate button positions
var center_x = _gui_width / 2;
var start_y = _gui_height / 2 - 100;

resume_button_y = start_y;
restart_button_y = start_y + button_height + button_spacing;
quit_button_y = start_y + (button_height + button_spacing) * 2;

// Check mouse position
var _mouse_gui_x = device_mouse_x_to_gui(0);
var _mouse_gui_y = device_mouse_y_to_gui(0);

button_hover = -1;

// Check resume button
if (point_in_rectangle(
    _mouse_gui_x, _mouse_gui_y,
    center_x - button_width / 2, resume_button_y,
    center_x + button_width / 2, resume_button_y + button_height
)) {
    button_hover = 0;
    if (mouse_check_button_pressed(mb_left)) {
        // Resume game
        global.game_state = global.paused_game_state; // Restore previous state
        global.game_paused = false;
        
        // Restore lock interface if it was open
        if (global.was_lock_open && instance_exists(global.lock_id)) {
            with (global.lock_id) {
                is_interface_open = true;
                current_input = global.lock_input;
            }
        }
        
        room_goto(global.paused_room);
    }
}

// Check restart button
if (point_in_rectangle(
    _mouse_gui_x, _mouse_gui_y,
    center_x - button_width / 2, restart_button_y,
    center_x + button_width / 2, restart_button_y + button_height
)) {
    button_hover = 1;
    if (mouse_check_button_pressed(mb_left)) {
        // Restart level - reset everything
        global.game_state = GAME_STATE.RUNNING;
        global.game_paused = false;
        global.was_dialogue_open = false;
        global.was_lock_open = false;
        
        room_goto(global.paused_room); // Go back to the room first
        room_restart(); // Then restart it
    }
}

// Check quit button
if (point_in_rectangle(
    _mouse_gui_x, _mouse_gui_y,
    center_x - button_width / 2, quit_button_y,
    center_x + button_width / 2, quit_button_y + button_height
)) {
    button_hover = 2;
    if (mouse_check_button_pressed(mb_left)) {
        // Quit to main menu - reset everything
        global.game_state = GAME_STATE.RUNNING;
        global.game_paused = false;
        global.was_dialogue_open = false;
        global.was_lock_open = false;
        
        room_goto(r_menu); // Change to your main menu room
    }
}

// ESC to resume
if (keyboard_check_pressed(vk_escape)) {
    global.game_state = global.paused_game_state; // Restore previous state
    global.game_paused = false;
    
    // Restore lock interface if it was open
    if (global.was_lock_open && instance_exists(global.lock_id)) {
        with (global.lock_id) {
            is_interface_open = true;
            current_input = global.lock_input;
        }
    }
    
    room_goto(global.paused_room);
}