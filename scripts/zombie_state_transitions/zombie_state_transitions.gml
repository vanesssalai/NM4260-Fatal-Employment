function zombie_state_transitions() {
    if (alert_timer > 0) {
        alert_timer--;
    }
    if (question_timer > 0) {
        question_timer--;
    }
    
    var previous_state = state;
    
    if (see_player) {
        if (!just_found_player) {
            just_found_player = true;
            alert_timer = alert_duration;
        }
    
        state = states.pursue;
        just_lost_player = false; 
        look_around_complete = false;
        idle_state = 0;
        question_timer = 0;
    } else if (memory_timer > 0) {
        if (previous_state != states.search) {
            question_timer = question_duration;
        }
        alert_timer = 0;
        state = states.search;
        idle_state = 0;
    } else {
        if (previous_state == states.search) {
            just_lost_player = true;
            look_around_complete = false;
            flip_count = 0;
            flip_delay = 0;
        }
        state = states.idle;
    }
}