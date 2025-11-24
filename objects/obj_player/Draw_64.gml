depth = PLAYER_DEPTH;

var heart_x = 40;
var heart_y = 40;
var heart_spacing = 55;
var max_hearts = max_life;
var heart_scale = 1.4;

var current_life = clamp(life, 0, max_hearts);

for (var i = 0; i < max_hearts; i++) {
    var draw_x = heart_x + (i * heart_spacing);
    
    if (i < current_life) {
		draw_sprite_ext(spr_heart_filled, 0, draw_x, heart_y, heart_scale, heart_scale, 0, c_white, 1);
    } else {
        draw_sprite_ext(spr_heart_empty, 0, draw_x, heart_y, heart_scale, heart_scale, 0, c_white, 1);
    }
}