if (!variable_global_exists("player_inventory")) {
    global.player_inventory = new Inventory();
    show_debug_message("Created new global inventory");
}

inv = global.player_inventory;

inv_cols = 10;
inv_rows = 1;

inv_box = 80;
inv_padding = 0;

display_set_gui_size(1200, 800);
depth = INVENTORY_DEPTH;