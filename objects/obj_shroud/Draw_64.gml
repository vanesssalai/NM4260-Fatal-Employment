if (fog_on) {
    var cam_w = camera_get_view_width(view_camera[0]);
    var cam_h = camera_get_view_height(view_camera[0]);
    var view_w = view_wport[0];
    var view_h = view_hport[0];
    
    if (!surface_exists(fog_surface)) {
        fog_surface = surface_create(view_w, view_h);
    }
    
    surface_set_target(fog_surface);
    draw_clear_alpha(c_black, 1); 
    surface_reset_target();
    
    // Player vision
    with (obj_player) {
        var fade_radius = obj_player.sight_radius;
        shroud_clear(x, y, 100, fade_radius, 0.1, true, -1, 90); 
    }
    
    // Zombie security vision
    with (obj_zombie_security) {
        var zombie_direction = 270;
        
        switch(face) {
            case right: zombie_direction = 0; break;
            case up: zombie_direction = 90; break;
            case left: zombie_direction = 180; break;
            case down: zombie_direction = 270; break;
        }
        
        shroud_clear(x, y, 20, 280, 0.5, false, zombie_direction, 20);
    }
    
    draw_set_alpha(1);
    draw_surface(fog_surface, 0, 0);
    draw_set_alpha(1);
}