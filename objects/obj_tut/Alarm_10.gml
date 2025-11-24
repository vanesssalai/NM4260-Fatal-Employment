// Bind quest to Rina after all objects are created
if (instance_exists(obj_rina)) {
    var rina = instance_find(obj_rina, 0);
    
    if (rina != noone) {
        var item_data = worker_items[0];
        
        rina.item_data = item_data;
        
        if (array_length(item_data.subquests) > 0) {
            rina.item_name = item_data.subquests[0].item_name;
            rina.item_qty = item_data.subquests[0].item_qty;
            show_debug_message("Rina bound with quest: " + item_data.quest_title);
            show_debug_message("Item to fetch: " + rina.item_name);
        }
    } else {
        show_debug_message("ERROR: Could not find obj_rina instance!");
    }
} else {
    show_debug_message("ERROR: obj_rina does not exist in room!");
}