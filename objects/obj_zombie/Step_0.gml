if (global.game_state = GAME_STATE.PAUSED) {
    return;
}

if (spawn_alert_active) {
    spawn_alert_timer--;
    
    image_speed = 0;
    
    if (spawn_alert_timer <= 0) {
        spawn_alert_active = false;
        image_speed = normal_image_speed;
        state = states.pursue;
    }
	
    x_speed = 0;
    y_speed = 0;
    return;
}

var ox = x - sprite_xoffset + sprite_width / 2;
var oy = y - sprite_yoffset + sprite_height / 2;

zombie_vision(ox, oy);
zombie_state_transitions();

var old_x = x;
var old_y = y;

switch (state) {
    case states.pursue:
        zombie_pursue();
        break;
        
    case states.search:
        zombie_search();
        break;
        
    case states.idle:
        zombie_idle();
        break;
}

if (x_speed != 0 || y_speed != 0) {
    if (abs(x_speed) > abs(y_speed)) {
        face = (x_speed > 0) ? right : left;
    } else {
        face = (y_speed > 0) ? down : up;
    }
}

sprite_index = sprite[face];

zombie_collision();
zombie_unstuck(old_x, old_y);

if (instance_exists(obj_player)) {
    var dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (dist_to_player <= audio_range_far) {
        if (dist_to_player <= audio_range_near) {
            target_volume = volume_near;
        } else {
            var dist_ratio = (dist_to_player - audio_range_near) / (audio_range_far - audio_range_near);
            target_volume = lerp(volume_near, volume_far, dist_ratio);
        }
        
        current_volume = lerp(current_volume, target_volume, volume_transition_speed);
        
        if (audio_is_playing(zombie_sound_instance)) {
            audio_sound_gain(zombie_sound_instance, current_volume, 0);
        } else {
            zombie_sound_instance = audio_play_sound(zombie_sound, 1, true, current_volume);
            is_sound_playing = true;
        }
    } else {
        target_volume = 0;
        current_volume = lerp(current_volume, target_volume, volume_transition_speed);
        
        if (current_volume < 0.01) {
            if (audio_is_playing(zombie_sound_instance)) {
                audio_stop_sound(zombie_sound_instance);
                is_sound_playing = false;
            }
        } else {
            if (audio_is_playing(zombie_sound_instance)) {
                audio_sound_gain(zombie_sound_instance, current_volume, 0);
            }
        }
    }
} else {
    if (audio_is_playing(zombie_sound_instance)) {
        audio_stop_sound(zombie_sound_instance);
        is_sound_playing = false;
    }
}

ox = x - sprite_xoffset + sprite_width / 2;
oy = y - sprite_yoffset + sprite_height / 2;