dialog = new Dialogue();
key_next = vk_space;
showing_dialog = false;
current_dialog = {};
alpha = 0;

showing_choices = false;
choices = [];
choice_selected = -1;
choice_hover = -1;

choice_padding = 15;
choice_height = 50;
choice_spacing = 10;

global.game_state = GAME_STATE.PAUSED;

depth = DIALOG_DEPTH;
dialogue_sound = snd_npc_talking;
dialogue_volume = 0.7;
current_sound_instance = noone;