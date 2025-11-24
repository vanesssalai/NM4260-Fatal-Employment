quests = new quest_tracker();

if (!variable_instance_exists(id, "quests") || is_undefined(quests)) {
    show_debug_message("ERROR: quests is not initialized before override!");
    return;
}

depth = -110;

is_visible = false;
toggle_key = ord("Q");

ui_width = 350;
ui_padding = 20;
ui_title_height = 40;
ui_quest_height = 80;
ui_alpha = 0.8;

show_notification = false;
notification_text = "";
notification_timer = 0;
notification_duration = 120;

original_add_quest = quests.add_quest;
quests.add_quest = method(self, function(_quest_id, _quest_title, _subquests, _worker_instance) {
    original_add_quest(_quest_id, _quest_title, _subquests, _worker_instance);
	
    show_notification = true;
    notification_text = "New Quest: " + _quest_title;
    notification_timer = notification_duration;
});

original_advance_subquest = quests.advance_subquest;
quests.advance_subquest = method(self, function(_quest_id) {
    var result = original_advance_subquest(_quest_id);
    
    if (result) {
        show_notification = true;
        notification_text = "Quest Complete!";
        notification_timer = notification_duration;
    } else {
        show_notification = true;
        notification_text = "Subquest Complete!";
        notification_timer = notification_duration;
    }
    
    return result;
});