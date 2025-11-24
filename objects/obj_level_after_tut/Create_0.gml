// Inherit the parent event
event_inherited();

intro_active = true;
intro_phase = 0;

black_screen_duration = 0;
fade_duration = 0;
black_timer = 0;
fade_alpha = 1;

level_text = "";
level_number = 0;

intro_dialogue = [
	{name: "", message: "I hope I make a good impression ><"},
	{name: "", message: "Hmm? Why does it smell like blood??"},
	{name: "", message: "Huh??"},
	{name: "", message: "WAIT WHATS THAT???"}
];

global.game_state = GAME_STATE.PAUSED;


