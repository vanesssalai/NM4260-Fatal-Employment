var player_in_range = false;
var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (instance_exists(obj_player)) {
    if (dist <= player_detect_range) {
        player_in_range = true;
    }
}

if (player_in_range) {
    sprite_index = glow_sprite;
    
	if (can_inventory && keyboard_check_pressed(vk_space)) {
	    if (instance_exists(obj_inventory)) {
			audio_play_sound(snd_pickup_item, 0, false)
	        obj_inventory.inv.item_add(name, 1, normal_sprite);
	        instance_destroy();
	    } else {
	        show_debug_message("ERROR: obj_inventory does NOT exist!");
	    }
	}
} else {
    sprite_index = normal_sprite;
}

if (dist <= player_detect_snd_range) {
	if (nearby_sound && sound_delay = 0) {
		audio_play_sound(snd_nearby, 0, false);
		sound_delay = 200;
	}
	
	if (sound_delay > 0) {
		sound_delay--;
	}
}