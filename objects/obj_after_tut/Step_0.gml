if (!intro_dialogue_complete) {
    var intro_done = !instance_exists(obj_level_intro_tut);
    var dialogue_done = !instance_exists(obj_dialogue_parent);
    
    if (intro_done && dialogue_done && global.game_state == GAME_STATE.RUNNING) {
        room_goto(r_level_1);
    }
}