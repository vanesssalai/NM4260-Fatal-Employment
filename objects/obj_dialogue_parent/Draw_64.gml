if (showing_choices) {
	// Fade in effect
	
	draw_set_font(pixel_operator_8);
	alpha = min(alpha + 0.1, 1);
	
	// Get GUI dimensions
	var _gui_width = display_get_gui_width();
	var _gui_height = display_get_gui_height();
	
	// Dialogue box dimensions and position
	var _box_height = 200;
	var _box_y = _gui_height - _box_height;
	
	// Draw semi-transparent overlay on entire screen
	draw_set_alpha(alpha * 0.5);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _gui_width, _gui_height, false);
	
	// Draw dialogue box background
	draw_set_alpha(alpha);
	draw_set_color(c_black);
	draw_rectangle(0, _box_y, _gui_width, _gui_height, false);
	
	// Draw dialogue box border
	draw_set_color(c_white);
	draw_rectangle(0, _box_y, _gui_width, _gui_height, true);
	
	// Draw prompt if exists - WITH COLOR SUPPORT
	if (variable_struct_exists(current_dialog, "prompt") && current_dialog.prompt != "") {
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_with_colours(_gui_width / 4, _box_y + 20, current_dialog.prompt, 20, _gui_width / 2, c_white);
	}
	
	// Draw choices
	var _total_choices_height = (array_length(choices) * choice_height) + ((array_length(choices) - 1) * choice_spacing);
	var _start_y = _box_y + (_box_height - _total_choices_height) / 2;
	
	for (var i = 0; i < array_length(choices); i++) {
		var _choice_y = _start_y + (i * (choice_height + choice_spacing));
		var _choice_width = _gui_width - (choice_padding * 4);
		var _choice_x = choice_padding * 2;
		
		// Draw choice background
		if (i == choice_hover) {
			draw_set_alpha(alpha * 0.8);
			draw_set_color(c_yellow);
			draw_rectangle(_choice_x, _choice_y, _choice_x + _choice_width, _choice_y + choice_height, false);
		} else {
			draw_set_alpha(alpha * 0.5);
			draw_set_color(c_dkgray);
			draw_rectangle(_choice_x, _choice_y, _choice_x + _choice_width, _choice_y + choice_height, false);
		}
		
		// Draw choice border
		draw_set_alpha(alpha);
		draw_set_color(i == choice_hover ? c_yellow : c_white);
		draw_rectangle(_choice_x, _choice_y, _choice_x + _choice_width, _choice_y + choice_height, true);
		
		// Draw choice text - WITH COLOR SUPPORT
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_with_colours(_choice_x + 10, _choice_y + 10, choices[i].text, 16, _choice_width - 20, c_white);
	}
	
	// Reset draw settings
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
} else if (showing_dialog) {
	// Original dialogue drawing code
	alpha = min(alpha + 0.1, 1);
	
	var _gui_width = display_get_gui_width();
	var _gui_height = display_get_gui_height();
	
	var _box_height = 150;
	var _box_y = _gui_height - _box_height;
	var _padding = 20;
	
	draw_set_alpha(alpha * 0.5);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _gui_width, _gui_height, false);
	
	draw_set_alpha(alpha);
	draw_set_color(c_black);
	draw_rectangle(0, _box_y, _gui_width, _gui_height, false);
	
	draw_set_color(c_white);
	draw_rectangle(0, _box_y, _gui_width, _gui_height, true);
	
	if (current_dialog.name != "") {
		var _name_box_width = string_width(current_dialog.name) + _padding * 2;
		var _name_box_height = 30;
		var _name_box_y = _box_y - _name_box_height;
	
		draw_set_color(c_dkgray);
		draw_rectangle(_padding, _name_box_y, _padding + _name_box_width, _box_y, false);
		draw_set_color(c_white);
		draw_rectangle(_padding, _name_box_y, _padding + _name_box_width, _box_y, true);
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(_padding * 2, _name_box_y + _name_box_height / 2, current_dialog.name);
	}
	
	// Draw message text - WITH COLOR SUPPORT
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_text_with_colours(_padding, _box_y + _padding, current_dialog.message, 20, _gui_width - _padding * 2, c_white);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_text_transformed(_gui_width - _padding, _gui_height - _padding, "Click to continue", 0.7, 0.7, 0);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}