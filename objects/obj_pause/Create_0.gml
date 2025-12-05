pause_active = 0;
previous_pause = 0;
pause_phase = 0;

dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);

level_text = "";
level_number = 0;

pause_dialogue = undefined;

global.game_state = GAME_STATE.PAUSED;


pause_dialogue = [
	{name: "ANNOUNCEMENT", message: "[Pause] has been called by one of our employees, how may we help you? How may we help you?"},
	{
        type: "choice",
		prompt: "",
        choices: [
            {
                text: "Instructions",
                response: [
                    {name: "ANNOUNCEMENT", message: "Ok so, its [AWSD] or [Arrowkeys] to move,"},
					{name: "ANNOUNCEMENT", message: "[Space] to talk to others or pick up objects,"},
					{name: "ANNOUNCEMENT", message: "[Q] to toggle quests and [M] to toggle minimap,"},
					{name: "ANNOUNCEMENT", message: "[Shift] to use coffee,"},
					{name: "ANNOUNCEMENT", message: "[E] to use heal,"},
					{name: "ANNOUNCEMENT", message: "Hope this helps!"}
                ]
            },
            {
                text: "Quit Game",
                callback: method(self, function() {
					with obj_player	instance_destroy(obj_player);
					with obj_inventory	instance_destroy(obj_inventory);
					audio_stop_all();
					game_restart();
                    room_goto(r_splash);
                })
            },
			{
                text: "Close Pause",
                response: [
                    {name: "ANNOUNCEMENT", message: "Oh.. ok"}
                ]
            }
		]
	}
]
/*
black_screen_duration = 30;
fade_duration = 120;
black_timer = 0;
fade_alpha = 1;