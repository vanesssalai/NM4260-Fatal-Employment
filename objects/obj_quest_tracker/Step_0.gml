// Toggle quest UI
if (keyboard_check_pressed(toggle_key)) {
    is_visible = !is_visible;
}

if (notification_timer > 0) {
    notification_timer--;
    if (notification_timer <= 0) {
        show_notification = false;
    }
}