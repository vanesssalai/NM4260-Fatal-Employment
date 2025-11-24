// Inherit the parent event
event_inherited();

randomize();
password_length = 5;
password = generate_password();

next_room = r_after_tut_WIN;

show_debug_message("Door password: " + password);