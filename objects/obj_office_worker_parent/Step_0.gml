var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist <= player_detect_snd_range) {
	if (nearby_sound && sound_delay = 0) {
		audio_play_sound(snd_nearby, 0, false);
		sound_delay = 200;
	}
	
	if (sound_delay > 0) {
		sound_delay--;
	}
}

if (instance_exists(obj_player)) {
    if (dist <= interact_range && keyboard_check_pressed(vk_space) && !instance_exists(obj_dialogue_parent)) {
        
        var dialogue_instance = instance_create_depth(0, 0, -9999, obj_dialogue_parent);
        
		if (quest_complete) {
		    if (instance_exists(obj_tut) && bound_quest_id == "help_tut") {
		        if (instance_exists(obj_rina) && obj_rina.tutorial_fourth_interaction) {
		            dialogue_instance.dialog.add("Rina", "The door is at the end of the corridor. Passcode: [" + obj_tut.password + "]");
		            return;
		        }
		    }
			
		    if (item_data != undefined && variable_struct_exists(item_data, "repeat_dialog")) {
		        for (var i = 0; i < array_length(item_data.repeat_dialog); i++) {
		            dialogue_instance.dialog.add(
		                item_data.repeat_dialog[i].name,
		                item_data.repeat_dialog[i].message
		            );
		        }
		    } else if (item_data != undefined && variable_struct_exists(item_data, "intro_dialog") && array_length(item_data.intro_dialog) > 0) {
		        dialogue_instance.dialog.add(item_data.intro_dialog[0].name, "Thanks again for all your help!");
		    } else {
		        dialogue_instance.dialog.add("Office Worker", "Thanks again for all your help!");
		    }
		}
		
        if (quest_complete) {
            if (item_data != undefined && variable_struct_exists(item_data, "repeat_dialog")) {
                for (var i = 0; i < array_length(item_data.repeat_dialog); i++) {
                    dialogue_instance.dialog.add(
                        item_data.repeat_dialog[i].name,
                        item_data.repeat_dialog[i].message
                    );
                }
            } else if (item_data != undefined && variable_struct_exists(item_data, "intro_dialog") && array_length(item_data.intro_dialog) > 0) {
                dialogue_instance.dialog.add(item_data.intro_dialog[0].name, "Thanks again for all your help!");
            } else {
                dialogue_instance.dialog.add("Office Worker", "Thanks again for all your help!");
            }
            
        } else if (item_data != undefined) {
            
            var is_simple_gift = (variable_struct_exists(item_data, "subquests") && array_length(item_data.subquests) == 0);
            var has_branching = variable_struct_exists(item_data, "branching_dialog") && item_data.branching_dialog;
            
            if (first_interaction) {
                for (var i = 0; i < array_length(item_data.intro_dialog); i++) {
                    dialogue_instance.dialog.add(
                        item_data.intro_dialog[i].name,
                        item_data.intro_dialog[i].message
                    );
                }
                
                if (has_branching) {
                    if (variable_instance_exists(id, "setup_branching_dialogue")) {
                        setup_branching_dialogue(dialogue_instance);
                    } else {
                        show_debug_message("WARNING: Worker has branching_dialog but no setup_branching_dialogue method!");
                    }
                    
                    first_interaction = false;
                    
                } else if (is_simple_gift) {
                    if (variable_struct_exists(item_data, "item_to_give")) {
                        var gift = item_data.item_to_give;
                        var is_consumable = false;
                        
                        if (variable_struct_exists(gift, "consumable")) {
                            is_consumable = gift.consumable;
                        }
                        
                        if (gift.item_name == "Coffee") {
                            is_consumable = true;
                        }
                        
                        obj_inventory.inv.item_add(gift.item_name, gift.item_qty, gift.sprite, is_consumable);
                        show_debug_message("Gave player: " + string(gift.item_qty) + "x " + gift.item_name);
                    }
                    
                    first_interaction = false;
                    quest_complete = true;
                    
                } else {
                    first_interaction = false;
                    
                    if (instance_exists(obj_quest_tracker)) {
                        obj_quest_tracker.quests.add_quest(
                            item_data.quest_id,
                            item_data.quest_title,
                            item_data.subquests,
                            id
                        );
                    }
                    
                    if (array_length(item_data.subquests) > 0) {
                        activate_item_spawner(item_data.subquests[0].item_name);
                    }
                }
                
            } else {
                if (current_subquest_index < array_length(item_data.subquests)) {
                    var current_subquest = item_data.subquests[current_subquest_index];
                    var has_item = obj_inventory.inv.item_has(current_subquest.item_name, current_subquest.item_qty);
                    
                    if (has_item) {
					    obj_inventory.inv.item_subtract(current_subquest.item_name, current_subquest.item_qty);
    
					    for (var i = 0; i < array_length(current_subquest.progress_dialog); i++) {
					        dialogue_instance.dialog.add(
					            current_subquest.progress_dialog[i].name,
					            current_subquest.progress_dialog[i].message
					        );
					    }
						
					    if (variable_struct_exists(current_subquest, "callback")) {
					        current_subquest.callback();
					        show_debug_message("Executed subquest callback");
					    }
    
					    current_subquest_index++;
                        
                        if (instance_exists(obj_quest_tracker)) {
                            var is_complete = obj_quest_tracker.quests.advance_subquest(item_data.quest_id);
                            
                            if (is_complete) {
                                show_debug_message("=== QUEST COMPLETE ===");
                                show_debug_message("Quest ID: " + item_data.quest_id);
								
								if (variable_struct_exists(item_data, "passcode_position")) {
									var digit_value = string_char_at(obj_level_parent.password, item_data.passcode_position);
									obj_quest_tracker.quests.set_passcode(item_data.quest_id, item_data.passcode_position, digit_value);
								}
                                
                                var has_completion_branching = variable_struct_exists(item_data, "branching_on_completion") && item_data.branching_on_completion;
                                show_debug_message("Has completion branching flag: " + string(has_completion_branching));
                                
                                var has_function = variable_instance_exists(id, "setup_completion_branching_dialogue");
                                show_debug_message("Has setup_completion_branching_dialogue function: " + string(has_function));
                                
                                if (has_completion_branching && has_function) {
                                    show_debug_message("Calling setup_completion_branching_dialogue");
                                    setup_completion_branching_dialogue(dialogue_instance);
                                    show_debug_message("Branching dialogue added");
                                } else {
                                    show_debug_message("Using normal final dialogue");
                                    var has_final_dialog = false;
                                    try {
                                        if (item_data.final_dialog != undefined && is_array(item_data.final_dialog) && array_length(item_data.final_dialog) > 0) {
                                            has_final_dialog = true;
                                        }
                                    } catch(e) {
                                        has_final_dialog = false;
                                    }
                                    
                                    if (has_final_dialog) {
                                        for (var i = 0; i < array_length(item_data.final_dialog); i++) {
                                            dialogue_instance.dialog.add(
                                                item_data.final_dialog[i].name,
                                                item_data.final_dialog[i].message
                                            );
                                        }
                                    } else {
                                        dialogue_instance.dialog.add("Office Worker", "Thank you for all your help!");
                                    }
                                }
                                quest_complete = true;
                                show_debug_message("Quest marked as complete");
                            } else {
                                if (current_subquest_index < array_length(item_data.subquests)) {
                                    activate_item_spawner(item_data.subquests[current_subquest_index].item_name);
                                }
                            }
                        }
                        
                        show_debug_message("Subquest " + string(current_subquest_index) + " complete");
                        
                    } else {
                        for (var i = 0; i < array_length(item_data.no_item_dialog); i++) {
                            dialogue_instance.dialog.add(
                                item_data.no_item_dialog[i].name,
                                item_data.no_item_dialog[i].message
                            );
                        }
                        show_debug_message("Still need: " + current_subquest.item_name);
                    }
                }
            }
            
        } else {
            dialogue_instance.dialog.add("Office Worker", "I need help, but I'm not sure what...");
        }
    }
}