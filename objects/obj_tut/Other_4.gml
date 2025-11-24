audio_play_sound(snd_room_bgm, 0, true);

if (!instance_exists(obj_minimap)) {
    var minimap = instance_create_depth(0, 0, -1000, obj_minimap);
    minimap.set_level_dimensions(4200, 2125, 352, 940);
	
    minimap.setup_npc_tracking();
}