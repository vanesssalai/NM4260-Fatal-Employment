event_inherited();

// Check if intro dialogue has completed
event_inherited();

// Check if intro dialogue has completed
if (!intro_dialogue_complete) {
    var intro_done = !instance_exists(obj_level_intro_tut);
    var dialogue_done = !instance_exists(obj_dialogue_parent);
    
    if (intro_done && dialogue_done && global.game_state == GAME_STATE.RUNNING) {
        intro_dialogue_complete = true;
        alarm[0] = 30;
    }
}

switch (tutorial_stage) {
    case TUTORIAL_STAGE.MOVEMENT:
        // Check if player has moved
        if (instance_exists(obj_player)) {
            if (obj_player.x != obj_player.spawn_x || obj_player.y != obj_player.spawn_y) {
                if (!player_has_moved) {
                    player_has_moved = true;
                    tutorial_text = "";
                    tutorial_stage = TUTORIAL_STAGE.APPROACH_NPC;
                }
            }
        }
        break;
        
    case TUTORIAL_STAGE.APPROACH_NPC:
        // Check distance to NPC
        if (instance_exists(obj_player) && instance_exists(obj_rina)) {
            var dist = point_distance(obj_player.x, obj_player.y, obj_rina.x, obj_rina.y);
            
            if (dist <= npc_talk_distance && !npc_proximity_reached) {
                npc_proximity_reached = true;
                tutorial_stage = TUTORIAL_STAGE.TALK_TO_NPC;
                tutorial_text = "Press SPACE to talk to Rina";
            }
        }
        break;
        
    case TUTORIAL_STAGE.TALK_TO_NPC:
        // Wait for player to talk to NPC (triggered externally)
        break;
        
    case TUTORIAL_STAGE.PICKUP_ITEM:
        // Wait for player to pick up item (triggered externally in obj_keys)
        break;
        
    case TUTORIAL_STAGE.RETURN_ITEM:
        // Wait for player to return item to NPC (triggered externally)
        break;
        
    case TUTORIAL_STAGE.TOGGLE_QUESTS:
        // Check if player pressed Q
        if (keyboard_check_pressed(ord("Q"))) {
            if (!quest_toggled) {
                quest_toggled = true;
                tutorial_text = "Press Q again to close it";
            } else {
                // Toggled twice, progress
                alarm[4] = 10;
            }
        }
        break;
        
	case TUTORIAL_STAGE.TOGGLE_MINIMAP:
	    // After second interaction, show minimap instruction
	    if (tutorial_text == "") {
	        tutorial_text = "Press M to toggle Minimap";
	    }
    
	    // Check if player pressed M
	    if (keyboard_check_pressed(ord("M"))) {
	        if (!minimap_toggled) {
	            minimap_toggled = true;
	            tutorial_text = "Press M again to close it";
	        } else {
	            // Toggled twice, progress
	            alarm[5] = 10;
	        }
	    }
    break;
        
    case TUTORIAL_STAGE.GET_PASSCODE:
        // Wait for player to talk to NPC again (triggered externally)
        break;
        
    case TUTORIAL_STAGE.USE_DOOR:
        // Check distance to door
        if (instance_exists(obj_player) && instance_exists(obj_lock_tut)) {
            var door_dist = point_distance(obj_player.x, obj_player.y, obj_lock_tut.x, obj_lock_tut.y);
            
            if (door_dist <= obj_lock_tut.interact_range) {
                tutorial_text = "Press SPACE to access the keypad";
            } else {
                tutorial_text = "Head to the door at the end of the corridor";
            }
        }
        break;
        
    case TUTORIAL_STAGE.WALK_TO_DOOR:
        // Player needs to walk into the unlocked door
        tutorial_text = "Walk into the unlocked door to continue";
        break;
        
    case TUTORIAL_STAGE.COMPLETE:
        tutorial_text = "";
        break;
}