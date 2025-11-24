function shroud_clear(world_x, world_y, sight_radius, fade_radius, clear_strength, is_circle, facing_direction, cone_angle) {
    if (!instance_exists(obj_shroud)) return;
    if (!surface_exists(obj_shroud.fog_surface)) return;
	
    var cam_x = camera_get_view_x(view_camera[0]);
    var cam_y = camera_get_view_y(view_camera[0]);
    var cam_w = camera_get_view_width(view_camera[0]);
    var cam_h = camera_get_view_height(view_camera[0]);
    var view_w = view_wport[0];
    var view_h = view_hport[0];
    
    var screen_x = ((world_x - cam_x) / cam_w) * view_w;
    var screen_y = ((world_y - cam_y) / cam_h) * view_h;
    var screen_sight = (sight_radius / cam_w) * view_w;
    var screen_fade = (fade_radius / cam_w) * view_w;
    
    surface_set_target(obj_shroud.fog_surface);
    gpu_set_colorwriteenable(false, false, false, true);
    gpu_set_blendmode_ext_sepalpha(bm_one, bm_one, bm_zero, bm_inv_src_alpha);
    draw_set_color(c_white);
    
    var center_darkness = 1 - clear_strength;
    
    if (is_circle) {
        draw_set_alpha(clear_strength);
        draw_circle(screen_x, screen_y, screen_sight, false);
        var steps = 100;
        var k = 0;
        repeat(steps) {
            var t = k / steps;
            var smooth_t = t * t * (3 - 2 * t);
            var current_radius = screen_sight + ((screen_fade - screen_sight) * t);
            
            var alpha = clear_strength * (1 - smooth_t);
            
            if (alpha > 0.001) {
                draw_set_alpha(alpha);
                draw_circle(screen_x, screen_y, current_radius, false);
            }
            k++;
        }
    } else {
        var cone_length = screen_fade;
        var cone_half = cone_angle / 2;
        
        // Draw core
        draw_set_alpha(clear_strength);
        draw_circle(screen_x, screen_y, screen_sight, false);
        
        var layers = 60;
        var k = 0;
        repeat(layers) {
            var t = k / layers;
            var smooth_t = t * t * (3 - 2 * t);
            var current_length = screen_sight + ((cone_length - screen_sight) * t);
            
            var alpha = clear_strength * (1 - smooth_t);
            
            if (alpha > 0.001) {
                draw_set_alpha(alpha);
                
                draw_primitive_begin(pr_trianglefan);
                draw_vertex(screen_x, screen_y);
                
                var segs = 30;
                var j = 0;
                repeat(segs + 1) {
                    var angle = (facing_direction - cone_half) + ((cone_half * 2) * j / segs);
                    var cx = screen_x + lengthdir_x(current_length, angle);
                    var cy = screen_y + lengthdir_y(current_length, angle);
                    draw_vertex(cx, cy);
                    j++;
                }
                
                draw_primitive_end();
            }
            k++;
        }
    }
    
    gpu_set_colorwriteenable(true, true, true, true);
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
    surface_reset_target();
}