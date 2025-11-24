depth = LOCK_DEPTH;
if (is_interface_open) {
    var gui_width = display_get_gui_width();
    var gui_height = display_get_gui_height();
    
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_width, gui_height, false);
    draw_set_alpha(1);
    
    var box_width = 600;
    var box_height = 350;
    var box_x = (gui_width - box_width) / 2;
    var box_y = (gui_height - box_height) / 2;
    
    draw_set_color(c_dkgray);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
	
    draw_set_color(c_white);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, true);
    draw_rectangle(box_x + 1, box_y + 1, box_x + box_width - 1, box_y + box_height - 1, true);
    draw_rectangle(box_x + 2, box_y + 2, box_x + box_width - 2, box_y + box_height - 2, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(box_x + box_width / 2, box_y + 20, "ENTER PASSWORD");
    
    var input_box_size = 50;
    var spacing = 10;
    var total_width = (password_length * input_box_size) + ((password_length - 1) * spacing);
    var start_x = box_x + (box_width - total_width) / 2;
    var start_y = box_y + 100;
    
    for (var i = 0; i < password_length; i++) {
        var pos_x = start_x + (i * (input_box_size + spacing));
        
        // Draw input box
        draw_set_color(c_white);
        draw_rectangle(pos_x, start_y, pos_x + input_box_size, start_y + input_box_size, true);
        
        // Draw entered digit
        if (i < string_length(current_input)) {
            var digit = string_char_at(current_input, i + 1);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text(pos_x + input_box_size / 2, start_y + input_box_size / 2, digit);
        }
    }
    
	// Instructions
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(box_x + box_width / 2, box_y + box_height - 120, "Type numbers to enter password");
	draw_text(box_x + box_width / 2, box_y + box_height - 100, "ENTER to submit | BACKSPACE to delete");
	
	close_button_x = box_x + (box_width - close_button_width) / 2;
	close_button_y = box_y + box_height - 50;
	
	if (close_button_hover) {
		draw_set_color(c_red);
	} else {
		draw_set_color(c_maroon);
	}
	draw_rectangle(close_button_x, close_button_y, 
				   close_button_x + close_button_width, 
				   close_button_y + close_button_height, false);
	
	draw_set_color(c_white);
	draw_rectangle(close_button_x, close_button_y, 
				   close_button_x + close_button_width, 
				   close_button_y + close_button_height, true);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(close_button_x + close_button_width / 2, 
			  close_button_y + close_button_height / 2, "CLOSE");
	
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}