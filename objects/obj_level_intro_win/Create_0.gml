// Inherit the parent event
event_inherited();

ntro_active = true;
intro_phase = 0;

black_screen_duration = 30;
fade_duration = 120;
black_timer = 0;
fade_alpha = 1;

level_text = "You made it out!";

level_number = 0;

intro_dialogue = [
	{name: "", message: "I cant believe it. I actually made it. Alive. Somehow... still human. And not even a single zombie-themed HR complaint yet."},
	{name: "", message: "Well, that was fun. Just kidding. That was terrifying. Absolutely terrifying."}
];

global.game_state = GAME_STATE.PAUSED;


