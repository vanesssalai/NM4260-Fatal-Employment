// Draw tutorial instructions at top middle of screen
if (tutorial_text != "" && tutorial_stage != TUTORIAL_STAGE.NONE) {
    var _gui_width = display_get_gui_width();
    var _gui_height = display_get_gui_height();
    
    draw_set_font(pixel_operator_8);
    
    // Calculate text dimensions
    var text_width = string_width(tutorial_text);
    var text_height = string_height(tutorial_text);
    var padding = 15;
    
    // Box dimensions
    var box_width = text_width + (padding * 2);
    var box_height = text_height + (padding * 2);
    var box_x = (_gui_width - box_width) / 2;
    var box_y = 50; // Top of screen with some margin
    
    // Draw semi-transparent background
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
    
    // Draw border
    draw_set_alpha(1);
    draw_set_color(c_yellow);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, true);
    draw_rectangle(box_x + 1, box_y + 1, box_x + box_width - 1, box_y + box_height - 1, true);
    
    // Draw text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(box_x + box_width / 2, box_y + box_height / 2, tutorial_text);
    
    // Reset draw settings
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}