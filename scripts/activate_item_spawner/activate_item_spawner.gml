function activate_item_spawner(item_name) {
    with (obj_diar_wallet_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
    
    with (obj_keycard_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
	
	with (obj_medkit_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
	
	with (obj_keys_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
	
	with (obj_water_bottle_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }

	with (obj_pretzel_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
	
	with (obj_folder_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
	
	with (obj_tablet_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
	
	with (obj_cd_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
	
	with (obj_bat_spawner) {
        if (self.item_name == item_name && !is_active) {
            is_active = true;
            spawn_items();
            show_debug_message("Activated spawner for: " + item_name);
        }
    }
}