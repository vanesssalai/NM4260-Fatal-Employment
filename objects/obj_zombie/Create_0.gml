DEPTH = ZOMBIE_DEPTH;

move_speed = 4.5;
sight_range = 250;
x_point = 0;
cone_angle = 60;
cone_half = cone_angle / 2;
memory_duration = 120;
memory_timer = 0;
max_flips = 3;
idle_state = 0; 
idle_timer = 0;
idle_target_x = x;
idle_target_y = y;
idle_move_speed = move_speed * 0.75; 
idle_stuck_counter = 0;
idle_max_stuck = 10; 
stuck_counter = 0;
stuck_threshold = 5;
spawn_alert_active = false;
spawn_alert_timer = 0;
spawn_alert_duration = 30;
normal_image_speed = image_speed;

enum states {
    idle,
    pursue,
    search
};

state = states.idle;
face = right;
x_speed = 0;
y_speed = 0;
x_axis = 0;
y_axis = 0;
magnitude = 0;
flip_count = 0;
flip_delay = 0;
ox = x - sprite_xoffset + sprite_width / 2;
oy = y - sprite_yoffset + sprite_height / 2;
see_player = false;
last_seen_x = 0;
last_seen_y = 0;
just_lost_player = false;
look_around_complete = false; 
just_found_player = false;
alert_timer = 0;
alert_duration = 60; 
question_timer = 0;
question_duration = 60;

sprite[right] = spr_basic_right;
sprite[up] = spr_basic_up;
sprite[left] = spr_basic_left;
sprite[down] = spr_basic_down;
sprite[still] = spr_basic_still;

zombie_sound = snd_zombie_sound;
zombie_sound_instance = noone;
audio_range_far = sight_range + 300;
audio_range_near = sight_range;
volume_far = 0.4; 
volume_near = 0.8;
current_volume = 0;
target_volume = 0;
volume_transition_speed = 0.1;
is_sound_playing = false;