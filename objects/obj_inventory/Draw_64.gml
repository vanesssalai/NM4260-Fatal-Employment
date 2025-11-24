var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

var inv_width = inv_cols * inv_box;
var inv_height = inv_rows * inv_box;
var start_x = (gui_width - inv_width) / 2;
var start_y = gui_height - inv_height - 20; 

draw_set_color(c_gray);
draw_rectangle(start_x, start_y, start_x + inv_width, start_y + inv_height, false);
draw_set_color(c_white);

var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);
var hovered_item = noone;

for (var row = 0; row < inv_rows; row++) {
	var pos_y = start_y + (row * inv_box);
	for (var col = 0; col < inv_cols; col++) {
		var pos_x = start_x + (col * inv_box);
		
		draw_rectangle(pos_x, pos_y, pos_x + inv_box, pos_y + inv_box, true);
		draw_rectangle(pos_x + 1, pos_y + 1, pos_x + inv_box - 1, pos_y + inv_box - 1, true);
		draw_rectangle(pos_x + 2, pos_y + 2, pos_x + inv_box - 2, pos_y + inv_box - 2, true);
		
		var item_index = row * inv_cols + col;
		
		if (item_index < array_length(inv.inventory_items)) {
			var item = inv.inventory_items[item_index];
			
			draw_sprite(item.sprite, 0, pos_x + inv_box/2, pos_y + inv_box/2);
			
			draw_set_color(c_white);
			
			if (mouse_x_gui >= pos_x && mouse_x_gui <= pos_x + inv_box &&
			    mouse_y_gui >= pos_y && mouse_y_gui <= pos_y + inv_box) {
				hovered_item = item;
			}
		}
	}
}

if (hovered_item != noone) {
	draw_set_font(pixel_operator_8)
	var text_width = string_width(hovered_item.name);
	var text_height = string_height(hovered_item.name);
	var tooltip_x = mouse_x_gui - text_width / 2;
	var tooltip_y = start_y - 32;
	var padding = 8;
	
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(tooltip_x - padding, tooltip_y - padding, 
	               tooltip_x + text_width + padding, tooltip_y + text_height + padding, false);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_text(tooltip_x, tooltip_y, hovered_item.name);
}
draw_set_alpha(1);
draw_set_color(c_white);