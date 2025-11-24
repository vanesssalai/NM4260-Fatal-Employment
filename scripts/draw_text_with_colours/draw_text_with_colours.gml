function draw_text_with_colours(_x, _y, _text, _line_height, _max_width, _default_color = c_white) {
    var _current_x = _x;
    var _current_y = _y;
    var _current_color = _default_color;
    var _in_colored_section = false;
    var _current_word = "";
    var _colored_text = "";
    
    var _len = string_length(_text);
    
    for (var i = 1; i <= _len; i++) {
        var _char = string_char_at(_text, i);
        
        if (_char == "[") {
            if (_current_word != "") {
                draw_set_color(_current_color);
                
                if (_current_x + string_width(_current_word) > _x + _max_width) {
                    _current_x = _x;
                    _current_y += _line_height;
                }
                
                draw_text(_current_x, _current_y, _current_word);
                _current_x += string_width(_current_word);
                _current_word = "";
            }
            
            _in_colored_section = true;
            _colored_text = "";
            
        } else if (_char == "]" && _in_colored_section) {
            if (_colored_text != "") {
                draw_set_color(c_yellow);
                
                if (_current_x + string_width(_colored_text) > _x + _max_width) {
                    _current_x = _x;
                    _current_y += _line_height;
                }
                
                draw_text(_current_x, _current_y, _colored_text);
                _current_x += string_width(_colored_text);
                _colored_text = "";
            }
            
            _in_colored_section = false;
            _current_color = _default_color;
            
        } else if (_char == " " || _char == "\n") {
            if (_in_colored_section) {
                _colored_text += _char;
            } else {
                if (_current_word != "") {
                    draw_set_color(_current_color);
                    
                    if (_current_x + string_width(_current_word) > _x + _max_width) {
                        _current_x = _x;
                        _current_y += _line_height;
                    }
                    
                    draw_text(_current_x, _current_y, _current_word);
                    _current_x += string_width(_current_word);
                    _current_word = "";
                }
                
                if (_char == "\n") {
                    _current_x = _x;
                    _current_y += _line_height;
                } else {
                    // Add space
                    _current_x += string_width(" ");
                }
            }
            
        } else {
            if (_in_colored_section) {
                _colored_text += _char;
            } else {
                _current_word += _char;
            }
        }
    }
    
    if (_current_word != "") {
        draw_set_color(_current_color);
        if (_current_x + string_width(_current_word) > _x + _max_width) {
            _current_x = _x;
            _current_y += _line_height;
        }
        draw_text(_current_x, _current_y, _current_word);
    }
    
    if (_colored_text != "") {
        draw_set_color(c_yellow);
        if (_current_x + string_width(_colored_text) > _x + _max_width) {
            _current_x = _x;
            _current_y += _line_height;
        }
        draw_text(_current_x, _current_y, _colored_text);
    }
    
    draw_set_color(_default_color);
}