// Inherit the parent event
event_inherited();

randomize();
password_length = 3;
password = generate_password();

next_room = r_level_2;

show_debug_message("Door password: " + password);