// Store button positions
button_width = 200;
button_height = 50;
button_spacing = 20;

resume_button_y = 0;
restart_button_y = 0;
quit_button_y = 0;

button_hover = -1; // -1 = none, 0 = resume, 1 = restart, 2 = quit

// Make sure game stays paused
global.game_state = GAME_STATE.PAUSED;