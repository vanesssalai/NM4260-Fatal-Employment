event_inherited();

ntro_active = true;
intro_phase = 0;

black_screen_duration = 30;
fade_duration = 120;
black_timer = 0;
fade_alpha = 1;

level_text = "You got Zombified :(";
level_number = 0;

intro_dialogue = [
	{name: "", message: "Oh no... no no no... that definitely wasnt supposed to happen."},
	{name: "", message: "I thought I had it all under control. Checklist? Completed. Safety vest? On. And yet… here we are. Apparently, one zombie bite = instant career termination."},
	{name: "", message: "Why on my first day of work..."}
];

global.game_state = GAME_STATE.PAUSED;


