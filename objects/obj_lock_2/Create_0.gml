// Inherit the parent event
event_inherited();

randomize();
password_length = 4;
password = generate_password();

next_room = r_level_3;

show_debug_message("Door password: " + password);