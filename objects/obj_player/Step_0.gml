if (global.game_state == GAME_STATE.PAUSED) {
	return;
}

right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
up_key = keyboard_check(vk_up) || keyboard_check(ord("W"));
left_key = keyboard_check(vk_left) || keyboard_check(ord("A"));
down_key = keyboard_check(vk_down) || keyboard_check(ord("S"));


x_axis = (right_key - left_key);
y_axis = (down_key - up_key);

magnitude = sqrt(sqr(x_axis) + sqr(y_axis));

script_execute(state);


if (life <= 0) {
	for (var i = 10; i > 0; i--) {
		i--
	}
    room_goto(r_after_tut_LOSE);
}

if (keyboard_check_pressed(ord("E"))) {
	if (life < max_life) {
		if (obj_inventory.inv.item_has("Heal", 1)) {
	        obj_inventory.inv.item_use("Heal");
	    } else {
	        show_debug_message("No healing items in inventory");
	    }
	}
}

if (is_speed_boosted) {
    speed_boost_timer--;
    
    if (speed_boost_timer <= 0) {
        is_speed_boosted = false;
        move_speed = base_move_speed;
        show_debug_message("Speed boost ended");
    }
}

if (keyboard_check_pressed(vk_shift)) {
    if (instance_number(obj_player) != 1) {
        show_debug_message("ERROR: Multiple players detected! Count: " + string(instance_number(obj_player)));
        with (obj_player) {
            if (id != other.id) {
                show_debug_message("Destroying duplicate player: " + string(id));
                instance_destroy();
            }
        }
    }
    
    if (obj_inventory.inv.item_has("Coffee", 1)) {
        show_debug_message("Coffee found in inventory");
        show_debug_message("This player id: " + string(id));
        obj_inventory.inv.item_use("Coffee");
    } else {
        show_debug_message("No coffee in inventory");
    }
}
