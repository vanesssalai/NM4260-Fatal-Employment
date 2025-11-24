locked_sprite = spr_locked_door;
unlocked_sprite = spr_unlocked_door;
next_room = noone;
interact_range = obj_player.detect_range + 180;
is_locked = true;
linked_lock = noone;
password_length = 0;
password = "";
is_interface_open = false;
current_input = "";

close_button_x = 0;
close_button_y = 0;
close_button_width = 80;
close_button_height = 40;
close_button_hover = false;

generate_password = function() {
    var max_value = power(10, password_length) - 1;
    var n = irandom(max_value);
    var pass = string(n);

    while (string_length(pass) < password_length) {
        pass = "0" + pass;
    }

    return pass;
}

check_password = function() {
    if (current_input == password) {
        unlock_door();
        is_interface_open = false;
        show_debug_message("Door unlocked!");
        return true;
    } else {
        show_debug_message("Wrong password!");
        current_input = "";
        return false;
    }
}

unlock_door = function() {
    is_locked = false;
    sprite_index = unlocked_sprite;
}

handle_number_input = function(number) {
    if (string_length(current_input) < password_length) {
        current_input += string(number);
    }
}
delete_last_digit = function() {
    if (string_length(current_input) > 0) {
        current_input = string_delete(current_input, string_length(current_input), 1);
    }
}
sprite_index = locked_sprite;