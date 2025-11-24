event_inherited();

object_to_spawn = obj_zombie_security;
spawn_interval = 120 * room_speed;
spawn_timer = spawn_interval;
max_zombies = 2;
min_distance_from_player = 500;
spawned_zombies = [];
is_active = true;

show_spawn_area = false; 