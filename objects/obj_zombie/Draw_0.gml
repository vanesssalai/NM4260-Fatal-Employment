draw_self();

draw_set_alpha(1);

// Draw SPAWN ALERT (red exclamation) - takes priority
if (spawn_alert_active && spawn_alert_timer > 0) {
    var ex_x = x;
    var ex_y = y - sprite_height;
    
    // Rise up animation at the start
    if (spawn_alert_timer > spawn_alert_duration - 15) {
        ex_y -= (spawn_alert_duration - spawn_alert_timer) * 0.5;
    }
    
    // Fade out at the end
    var alpha = 1;
    if (spawn_alert_timer < 15) {
        alpha = spawn_alert_timer / 15;
    }
    
    draw_set_alpha(alpha);
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(-1);
    draw_text_transformed(ex_x, ex_y, "!", 2.5, 2.5, 0); 
    draw_set_alpha(1);
    draw_set_color(c_white);
    
} else if (alert_timer > 0) {
    // Normal alert (white exclamation)
    var ex_x = x;
    var ex_y = y - sprite_height;  
	
    if (alert_timer > alert_duration - 15) {
        ex_y -= (alert_duration - alert_timer) * 0.5;
    }
    
    var alpha = 1;
    if (alert_timer < 15) {
        alpha = alert_timer / 15;
    }
    
    draw_set_alpha(alpha);
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(-1); 
    draw_text_transformed(ex_x, ex_y, "!", 2, 2, 0); 
    draw_set_alpha(1);
    draw_set_color(c_white);
    
} else if (question_timer > 0) {
    // Question mark (yellow)
	var ex_x = x;
    var ex_y = y - sprite_height;
	
	var alpha = 1;
    if (question_timer < 15) {
        alpha = question_timer / 15;
    }
    
    draw_set_alpha(alpha);
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(-1);
    draw_text_transformed(ex_x, ex_y, "?", 2, 2, 0);
    draw_set_alpha(1);
    draw_set_color(c_white);
}