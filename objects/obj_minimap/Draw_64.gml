if (!is_visible) return;

var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();

draw_set_alpha(overlay_alpha);
draw_set_color(background_color);
draw_rectangle(0, 0, _gui_width, _gui_height, false);
draw_set_alpha(1);

var map_width = sprite_get_width(minimap_sprite) * minimap_scale;
var map_height = sprite_get_height(minimap_sprite) * minimap_scale;

var map_x = (_gui_width - map_width) / 2;
var map_y = (_gui_height - map_height) / 2;

draw_sprite_ext(minimap_sprite, 0, map_x, map_y, minimap_scale, minimap_scale, 0, c_white, 1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(map_x + map_width / 2, map_y - 40, "CURRENT LOCATION: " + current_room);

for (var i = 0; i < array_length(npc_list); i++) {
    var npc = npc_list[i];
    
    if (instance_exists(npc.instance)) {
        var npc_x = map_x + npc.minimap_x * minimap_scale;
        var npc_y = map_y + npc.minimap_y * minimap_scale;
        
        draw_set_color(npc.color);
        draw_circle(npc_x, npc_y, npc_marker_size, false);
        
        draw_set_color(c_white);
        draw_circle(npc_x, npc_y, npc_marker_size, true);
    }
}

if (instance_exists(obj_player)) {
    var player_map_pos = world_to_minimap(obj_player.x, obj_player.y);
    var player_x = map_x + player_map_pos.x * minimap_scale;
    var player_y = map_y + player_map_pos.y * minimap_scale;
    
    draw_set_color(player_color);
    var cross_size = player_marker_size;
    
    draw_line_width(player_x, player_y - cross_size, player_x, player_y + cross_size, 3);
    draw_line_width(player_x - cross_size, player_y, player_x + cross_size, player_y, 3);
    
    draw_set_color(c_black);
    draw_line_width(player_x, player_y - cross_size, player_x, player_y + cross_size, 5);
    draw_line_width(player_x - cross_size, player_y, player_x + cross_size, player_y, 5);
    
    draw_set_color(player_color);
    draw_line_width(player_x, player_y - cross_size, player_x, player_y + cross_size, 3);
    draw_line_width(player_x - cross_size, player_y, player_x + cross_size, player_y, 3);
}

var legend_x = map_x + map_width + 20;
var legend_y = map_y + 20;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(legend_x, legend_y, "LEGEND:");

draw_set_color(player_color);
var legend_offset = 30;
draw_line_width(legend_x + 10, legend_y + legend_offset - 5, legend_x + 10, legend_y + legend_offset + 5, 2);
draw_line_width(legend_x + 5, legend_y + legend_offset, legend_x + 15, legend_y + legend_offset, 2);
draw_set_color(c_white);
draw_text(legend_x + 25, legend_y + legend_offset - 8, "You");

legend_offset += 25;
for (var i = 0; i < array_length(npc_list); i++) {
    var npc = npc_list[i];
    
    if (instance_exists(npc.instance)) {
        draw_set_color(npc.color);
        draw_circle(legend_x + 10, legend_y + legend_offset, npc_marker_size, false);
        draw_set_color(c_white);
        draw_circle(legend_x + 10, legend_y + legend_offset, npc_marker_size, true);
        draw_text(legend_x + 25, legend_y + legend_offset - 8, npc.instance.worker_name);
		
        legend_offset += 25;
    }
}

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_gui_width / 2, _gui_height - 20, "Press M to close");

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);