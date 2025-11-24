if (instance_exists(obj_player)) {
    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (dist <= interact_range) {
        // Get camera position and dimensions
        var cam_x = camera_get_view_x(view_camera[0]);
        var cam_y = camera_get_view_y(view_camera[0]);
        var cam_w = camera_get_view_width(view_camera[0]);
        var cam_h = camera_get_view_height(view_camera[0]);
        
        var gui_w = display_get_gui_width();
        var gui_h = display_get_gui_height();
        
        var screen_x = ((x - cam_x) / cam_w) * gui_w;
        var screen_y = ((y - cam_y - 44) / cam_h) * gui_h; // Changed from sprite_height to fixed 40 pixels
        
        draw_set_font(pixel_operator_8);
        var name_width = string_width("???");
        var name_height = string_height("???");
        var padding = 8;
        
        var box_x1 = screen_x - (name_width / 2) - padding;
        var box_y1 = screen_y - name_height - padding;
        var box_x2 = screen_x + (name_width / 2) + padding;
        var box_y2 = screen_y;
        
        draw_set_alpha(0.7);
        draw_set_color(c_black);
        draw_rectangle(box_x1, box_y1, box_x2, box_y2, false);
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text(screen_x, screen_y - (name_height / 2) - (padding / 2), "???");
		
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}