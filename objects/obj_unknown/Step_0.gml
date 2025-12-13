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

if (!is_revealed && instance_exists(obj_player)) {
    
    if (dist <= interact_range && keyboard_check_pressed(vk_space)) {
        var spawn_data = obj_level_parent.get_unknown_type();
        
        is_revealed = true;
        
        show_debug_message("Spawning object: " + object_get_name(spawn_data.object));
        show_debug_message("Has item data: " + string(spawn_data.item_data != undefined));
        if (spawn_data != noone && spawn_data != undefined) {
            var spawn_object = spawn_data.object;
            var item_data = spawn_data.item_data;
            
            var spawned_instance = instance_create_depth(x, y, depth, spawn_object);
            
            if (object_is_ancestor(spawn_object, obj_office_worker_parent) || spawn_object == obj_office_worker_parent) {
                if (item_data != undefined) {
                    if (spawned_instance.bound_quest_id != "" && spawned_instance.bound_quest_id != item_data.quest_id) {
                        show_debug_message("WARNING: Bound worker " + object_get_name(spawn_object) + " received wrong quest!");
                    }
                    
                    spawned_instance.item_data = item_data;
                    
                    if (array_length(item_data.subquests) > 0) {
                        spawned_instance.item_name = item_data.subquests[0].item_name;
                        spawned_instance.item_qty = item_data.subquests[0].item_qty;
                        show_debug_message("Worker " + object_get_name(spawn_object) + " spawned with quest: " + item_data.quest_title);
                    } else {
                        show_debug_message("Worker " + object_get_name(spawn_object) + " spawned with: " + item_data.quest_title);
                    }
                } else {
                    show_debug_message("No items left for workers!");
                }
            }
            
            if (object_is_ancestor(spawn_object, obj_zombie) || spawn_object == obj_zombie) {
                spawned_instance.normal_image_speed = spawned_instance.image_speed;
                
                spawned_instance.spawn_alert_active = true;
                spawned_instance.spawn_alert_timer = spawned_instance.spawn_alert_duration;
                spawned_instance.image_speed = 0;
                
                spawned_instance.state = states.idle;
                spawned_instance.last_seen_x = obj_player.x;
                spawned_instance.last_seen_y = obj_player.y;
                spawned_instance.see_player = true;
                
                show_debug_message("Zombie spawned with spawn alert active");
            }
			
			instance_destroy();
        }
    }
}