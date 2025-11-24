if (!is_visible) {
	draw_set_font(pixel_operator_8);
    var _gui_width = display_get_gui_width();
    var _gui_height = display_get_gui_height();
    
    var _ui_x = _gui_width - ui_width - ui_padding;
    var _ui_y = ui_padding;
    
    var _total_height = ui_title_height + (quests.get_quest_count() * ui_quest_height);
    
    draw_set_alpha(ui_alpha);

    draw_set_color(c_dkgray);
    draw_rectangle(_ui_x, _ui_y, _ui_x + ui_width, _ui_y + ui_title_height, false);
    draw_set_color(c_white);
    draw_rectangle(_ui_x, _ui_y, _ui_x + ui_width, _ui_y + ui_title_height, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_ui_x + ui_width / 2, _ui_y + ui_title_height / 2, "QUESTS (" + string(quests.get_active_quest_count()) + ")");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
}

if (is_visible && quests.get_quest_count() > 0) {
	draw_set_font(pixel_operator_8);
    var _gui_width = display_get_gui_width();
    var _gui_height = display_get_gui_height();
    
    var _ui_x = _gui_width - ui_width - ui_padding;
    var _ui_y = ui_padding;
    
    var _total_height = ui_title_height + (quests.get_quest_count() * ui_quest_height);
    
    draw_set_alpha(ui_alpha);
    draw_set_color(c_black);
    draw_rectangle(_ui_x, _ui_y, _ui_x + ui_width, _ui_y + _total_height, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(_ui_x, _ui_y, _ui_x + ui_width, _ui_y + _total_height, true);
    
    draw_set_color(c_dkgray);
    draw_rectangle(_ui_x, _ui_y, _ui_x + ui_width, _ui_y + ui_title_height, false);
    draw_set_color(c_white);
    draw_rectangle(_ui_x, _ui_y, _ui_x + ui_width, _ui_y + ui_title_height, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_ui_x + ui_width / 2, _ui_y + ui_title_height / 2, "QUESTS (" + string(quests.get_active_quest_count()) + ")");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var _quest_y = _ui_y + ui_title_height;
    
    for (var i = 0; i < array_length(quests.quest_list); i++) {
        var _quest = quests.quest_list[i];
        
        if (i % 2 == 0) {
            draw_set_alpha(0.3);
            draw_set_color(c_gray);
            draw_rectangle(_ui_x, _quest_y, _ui_x + ui_width, _quest_y + ui_quest_height, false);
            draw_set_alpha(1);
        }
        
        var _icon_x = _ui_x + 15;
        var _icon_y = _quest_y + ui_quest_height / 2;
        
        if (_quest.is_complete) {
            draw_set_color(c_lime);
            draw_circle(_icon_x, _icon_y, 8, false);
        } else {
            draw_set_color(c_yellow);
            draw_circle(_icon_x, _icon_y, 8, true);
        }
        
        var _text_x = _ui_x + 40;
        var _text_y = _quest_y + 10;
        
        draw_set_color(_quest.is_complete ? c_gray : c_white);
        
        draw_text_transformed(_text_x, _text_y, _quest.quest_title, 0.9, 0.9, 0);
        
        if (_quest.is_complete) {
            draw_set_color(c_lime);
            
            if (instance_exists(obj_tut)) {
                draw_text_transformed(_text_x, _text_y + 18, "Complete!", 0.8, 0.8, 0);
                
                if (instance_exists(obj_tut) && obj_tut.password != "") {
                    draw_set_color(c_yellow);
                    draw_text_transformed(_text_x, _text_y + 36, "Passcode: " + obj_tut.password, 0.8, 0.8, 0);
                }
            } else {
                if (_quest.passcode_digit != "" && _quest.passcode_position > 0) {
                    var position_text = "";
                    switch(_quest.passcode_position) {
                        case 1: position_text = "1st"; break;
                        case 2: position_text = "2nd"; break;
                        case 3: position_text = "3rd"; break;
                        default: position_text = string(_quest.passcode_position) + "th"; break;
                    }
                    
                    draw_text_transformed(_text_x, _text_y + 18, "Complete!", 0.8, 0.8, 0);
                    draw_set_color(c_yellow);
                    draw_text_transformed(_text_x, _text_y + 36, position_text + " digit: " + _quest.passcode_digit, 0.8, 0.8, 0);
                } else {
                    draw_text_transformed(_text_x, _text_y + 18, "Complete!", 0.8, 0.8, 0);
                }
            }
        } else {
            var current_subquest = quests.get_current_subquest(_quest.quest_id);
            if (current_subquest != undefined) {
                draw_set_color(c_ltgray);
                draw_text_ext_transformed(_text_x, _text_y + 22, current_subquest.description, 20, ui_width - 50, 0.8, 0.8, 0);
            }
        }
        
        var progress = quests.get_quest_progress(_quest.quest_id);
        if (progress != undefined) {
            draw_set_color(_quest.is_complete ? c_gray : c_yellow);
            draw_text_transformed(_ui_x + ui_width - 60, _text_y, string(progress.current) + "/" + string(progress.total), 0.8, 0.8, 0);
        }
        
        _quest_y += ui_quest_height;
    }
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);