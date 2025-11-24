if (!consumed && instance_exists(obj_player)) {
	if (obj_player.life < obj_player.max_life) {
		obj_player.life += 1
		
		consumed = true;
        instance_destroy();
	}
}