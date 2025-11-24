if (!intro_active) {
    return;
}

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Draw black background
draw_set_alpha(fade_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_width, gui_height, false);

// Draw level text
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(pixel_operator_8); // Use your font

// Large text size
var text_scale = 3;
draw_text_transformed(gui_width / 2, gui_height / 2, level_text, text_scale, text_scale, 0);

// Reset
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);