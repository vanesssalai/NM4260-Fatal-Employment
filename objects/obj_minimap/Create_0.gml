is_visible = false;
toggle_key = ord("M");

minimap_sprite = noone;
minimap_scale = 1;

level_width = 0;
level_height = 0;

room_origin_x = 0;
room_origin_y = 0;

minimap_sprite_width = 600;
minimap_sprite_height = 400;

current_room = "Unknown";
current_room_area = noone;

player_color = c_red;
player_marker_size = 8;

npc_list = [];
npc_marker_size = 6;
npc_tracking_ready = false;

overlay_alpha = 0.8;
background_color = c_black;

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

depth = -1000;

setup_npc_tracking = function() {
    npc_list = [];
	
    var total_workers = instance_number(obj_office_worker_parent);
	
    if (total_workers == 0) {
        show_debug_message("ERROR: No workers found!");
        npc_tracking_ready = false;
        return false;
    }
    
    var colors = [c_red, c_blue, c_yellow, c_purple, c_orange, c_aqua];
    
    for (var i = 0; i < total_workers; i++) {
        var worker = instance_find(obj_office_worker_parent, i);
        
        if (worker != noone && instance_exists(worker)) { 
            var worker_data = {
                instance: worker,
                name: worker.worker_name,
                color: colors[i mod array_length(colors)],
                minimap_x: 0,
                minimap_y: 0,
                room_name: "Unknown"
            };
            
            array_push(npc_list, worker_data);
        } else {
            show_debug_message("  ERROR: Worker " + string(i) + " not found or doesn't exist!");
        }
    }
    
    if (array_length(npc_list) > 0) {
        npc_tracking_ready = true;
        return true;
    } else {
        npc_tracking_ready = false;
        return false;
    }
}

world_to_minimap = function(_world_x, _world_y) {
    var adjusted_x = _world_x - room_origin_x;
    var adjusted_y = _world_y - room_origin_y;
    
    var scale_x = minimap_sprite_width / level_width;
    var scale_y = minimap_sprite_height / level_height;
    
    var map_x = adjusted_x * scale_x;
    var map_y = adjusted_y * scale_y;
    
    map_x = clamp(map_x, 0, minimap_sprite_width);
    map_y = clamp(map_y, 0, minimap_sprite_height);
    
    return {x: map_x, y: map_y};
}

set_level_dimensions = function(_width, _height, _offset_x = 0, _offset_y = 0) {
    level_width = _width;
    level_height = _height;
    room_origin_x = _offset_x;
    room_origin_y = _offset_y;
    
    show_debug_message("Minimap dimensions set: " + string(_width) + "x" + string(_height));
    show_debug_message("Room offset: (" + string(_offset_x) + ", " + string(_offset_y) + ")");
}

alarm[0] = 15;