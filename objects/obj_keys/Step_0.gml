event_inherited();

if (instance_exists(obj_tut) && instance_exists(obj_player)) {
    if (obj_tut.tutorial_stage == TUTORIAL_STAGE.PICKUP_ITEM) {
        var dist = point_distance(x, y, obj_player.x, obj_player.y);
        
        // Update tutorial text when player is near the keys
        if (dist <= 100) {
            obj_tut.tutorial_text = "Press SPACE to pick up the Keys";
            
            // Check if Keys were picked up (item_find returns index, -1 if not found)
            if (obj_inventory.inv.item_find("Keys") != -1) {
                show_debug_message("Keys picked up! Progressing tutorial...");
                obj_tut.item_picked_up = true;
                obj_tut.alarm[2] = 60; // Trigger return to NPC stage
            }
        } else if (dist > 100 && obj_tut.tutorial_text == "Press SPACE to pick up the Keys") {
            // Player moved away, revert to walk instruction
            obj_tut.tutorial_text = "Walk over to the Keys";
        }
    }
}
