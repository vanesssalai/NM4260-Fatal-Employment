move_speed = 5.2;
base_move_speed = 5.2; 
is_speed_boosted = false;
speed_boost_timer = 0;
speed_boost_multiplier = 1.5;
max_life = 5;
detect_range = 80;

// Do not touch!
spawn_x = x;
spawn_y = y;
x_speed = 0;
y_speed = 0;
x_axis = 0;
y_axis = 0;
life = 5;
sight_radius = 300;
right_key = 0;
up_key = 0;
left_key = 0;
down_key = 0;
state = player_state_free;
last_x = x;
last_y = y;
stuck_counter = 0;

// NORMAL SPRITES
sprite[6] = [];
sprite[6][right] = spr_player_right_3;
sprite[6][up] = spr_player_up_3;  
sprite[6][left] = spr_player_left_3;
sprite[6][down] = spr_player_down_3;
sprite[6][still] = spr_player_still_3;

sprite[5] = [];
sprite[5][right] = spr_player_right_3;
sprite[5][up] = spr_player_up_3;  
sprite[5][left] = spr_player_left_3;
sprite[5][down] = spr_player_down_3;
sprite[5][still] = spr_player_still_3;

sprite[4] = [];
sprite[4][right] = spr_player_right_2;
sprite[4][up] = spr_player_up_2;  
sprite[4][left] = spr_player_left_2;
sprite[4][down] = spr_player_down_2;
sprite[4][still] = spr_player_still_2;

sprite[3] = [];
sprite[3][right] = spr_player_right_2;
sprite[3][up] = spr_player_up_2;  
sprite[3][left] = spr_player_left_2;
sprite[3][down] = spr_player_down_2;
sprite[3][still] = spr_player_still_2;

sprite[2] = [];
sprite[2][right] = spr_player_right_1;
sprite[2][up] = spr_player_up_1;  
sprite[2][left] = spr_player_left_1;
sprite[2][down] = spr_player_down_1;
sprite[2][still] = spr_player_still_1;

sprite[1] = [];
sprite[1][right] = spr_player_right_1;
sprite[1][up] = spr_player_up_1;  
sprite[1][left] = spr_player_left_1;
sprite[1][down] = spr_player_down_1;
sprite[1][still] = spr_player_still_1;

// COFFEE SPRITES (holding coffee)
sprite_coffee = [];
sprite_coffee[6] = [];
sprite_coffee[6][right] = spr_player_right_coffee_3;
sprite_coffee[6][up] = spr_player_up_coffee_3;  
sprite_coffee[6][left] = spr_player_left_coffee_3;
sprite_coffee[6][down] = spr_player_down_coffee_3;
sprite_coffee[6][still] = spr_player_still_coffee_3;

sprite_coffee[5] = [];
sprite_coffee[5][right] = spr_player_right_coffee_3;
sprite_coffee[5][up] = spr_player_up_coffee_3;  
sprite_coffee[5][left] = spr_player_left_coffee_3;
sprite_coffee[5][down] = spr_player_down_coffee_3;
sprite_coffee[5][still] = spr_player_still_coffee_3;

sprite_coffee[4] = [];
sprite_coffee[4][right] = spr_player_right_coffee_2;
sprite_coffee[4][up] = spr_player_up_coffee_2;  
sprite_coffee[4][left] = spr_player_left_coffee_2;
sprite_coffee[4][down] = spr_player_down_coffee_2;
sprite_coffee[4][still] = spr_player_still_coffee_2;

sprite_coffee[3] = [];
sprite_coffee[3][right] = spr_player_right_coffee_2;
sprite_coffee[3][up] = spr_player_up_coffee_2;  
sprite_coffee[3][left] = spr_player_left_coffee_2;
sprite_coffee[3][down] = spr_player_down_coffee_2;
sprite_coffee[3][still] = spr_player_still_coffee_2;

sprite_coffee[2] = [];
sprite_coffee[2][right] = spr_player_right_coffee_1;
sprite_coffee[2][up] = spr_player_up_coffee_1;  
sprite_coffee[2][left] = spr_player_left_coffee_1;
sprite_coffee[2][down] = spr_player_down_coffee_1;
sprite_coffee[2][still] = spr_player_still_coffee_1;

sprite_coffee[1] = [];
sprite_coffee[1][right] = spr_player_right_coffee_1;
sprite_coffee[1][up] = spr_player_up_coffee_1;  
sprite_coffee[1][left] = spr_player_left_coffee_1;
sprite_coffee[1][down] = spr_player_down_coffee_1;
sprite_coffee[1][still] = spr_player_still_coffee_1;


activate_speed_boost = function(_multiplier, _duration = 300) {
    show_debug_message("=== SPEED BOOST ACTIVATION START ===");
    show_debug_message("Player instances: " + string(instance_number(obj_player)));
    
    if (speed_boost_timer <= 0) {
        speed_boost_multiplier = _multiplier;
        speed_boost_timer = _duration;
        is_speed_boosted = true;
        move_speed = base_move_speed * _multiplier;
        
        show_debug_message("Speed boost activated: " + string(_multiplier) + "x for " + string(_duration / 60) + " seconds");
        show_debug_message("New move_speed: " + string(move_speed));
        show_debug_message("Player instances after: " + string(instance_number(obj_player)));
        show_debug_message("=== SPEED BOOST ACTIVATION END ===");
        return true;
    } else {
        show_debug_message("Speed boost already active!");
        return false;
    }
}

heal_player = function(_amount) {
	if (life < max_life) {
		life = min(life + _amount, max_life);
		show_debug_message("Healed for " + string(_amount) + " HP");
		return true;
	}
	return false;
}

complete_dialog = [
	{name: "", message: "Alright! I've got the full passcode, let's get out of this floor! :D"}
]