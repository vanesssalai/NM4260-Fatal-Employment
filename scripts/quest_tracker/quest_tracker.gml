function quest_tracker() constructor {
    quest_list = [];
    
    add_quest = function(_quest_id, _quest_title, _subquests, _worker_instance) {
        // Check if quest already exists
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                return;
            }
        }
        
        array_push(quest_list, {
            quest_id: _quest_id,
            quest_title: _quest_title,
            subquests: _subquests,
            current_subquest_index: 0,
            is_complete: false,
            worker_instance: _worker_instance,
            passcode_digit: "",
            passcode_position: 0
        });
        
        show_debug_message("Quest added: " + _quest_title);
    }
    
    get_current_subquest = function(_quest_id) {
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                var quest = quest_list[i];
                if (quest.current_subquest_index < array_length(quest.subquests)) {
                    return quest.subquests[quest.current_subquest_index];
                }
                return undefined;
            }
        }
        return undefined;
    }
    
    advance_subquest = function(_quest_id) {
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                quest_list[i].current_subquest_index++;
				
                if (quest_list[i].current_subquest_index >= array_length(quest_list[i].subquests)) {
                    quest_list[i].is_complete = true;
                    show_debug_message("Quest completed: " + _quest_id);
                    return true;
                }
                
                show_debug_message("Advanced to next subquest in: " + _quest_id);
                return false;
            }
        }
        return false;
    }
    
    set_passcode = function(_quest_id, _position, _digit) {
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                quest_list[i].passcode_position = _position;
                quest_list[i].passcode_digit = _digit;
                show_debug_message("Passcode set for " + _quest_id + ": Position " + string(_position) + " = " + _digit);
                return true;
            }
        }
        return false;
    }
    
    get_quest_progress = function(_quest_id) {
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                return {
                    current: quest_list[i].current_subquest_index,
                    total: array_length(quest_list[i].subquests)
                };
            }
        }
        return undefined;
    }
    
    is_quest_complete = function(_quest_id) {
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                return quest_list[i].is_complete;
            }
        }
        return false;
    }
    
    remove_quest = function(_quest_id) {
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                array_delete(quest_list, i, 1);
                show_debug_message("Quest removed: " + _quest_id);
                return true;
            }
        }
        return false;
    }
	
    
    // Get quest count
    get_quest_count = function() {
        return array_length(quest_list);
    }
    
    // Get active (incomplete) quest count
    get_active_quest_count = function() {
        var count = 0;
        for (var i = 0; i < array_length(quest_list); i++) {
            if (!quest_list[i].is_complete) {
                count++;
            }
        }
        return count;
    }
    
    // Check if a specific quest exists
    has_quest = function(_quest_id) {
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].quest_id == _quest_id) {
                return true;
            }
        }
        return false;
    }
	
	get_obtained_password_count = function() {
        var count = 0;
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].is_complete && quest_list[i].passcode_digit != "") {
                count++;
            }
        }
        return count;
    }
    
    // Get all password digits in order
    get_password_digits = function() {
        var digits = [];
        
        for (var i = 0; i < array_length(quest_list); i++) {
            if (quest_list[i].is_complete && quest_list[i].passcode_digit != "") {
                array_push(digits, {
                    position: quest_list[i].passcode_position,
                    digit: quest_list[i].passcode_digit
                });
            }
        }
        
        array_sort(digits, function(a, b) {
            return a.position - b.position;
        });
        
        return digits;
    }
    
    all_quests_complete = function() {
        if (array_length(quest_list) == 0) return false;
        
        for (var i = 0; i < array_length(quest_list); i++) {
            if (!quest_list[i].is_complete) {
                return false;
            }
        }
        return true;
    }
}