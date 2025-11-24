password = "";
num_zombies = 0;
num_workers = 0;
zombie_type = [];
worker_types = [];
worker_items = [];
password_length = 0;
obtained_length = 0;
lock_instance = noone;
dialogue_instance = noone;
completion_dialogue_shown = false;

get_worker_item = function() {
    if (array_length(worker_items) > 0) {
        var index = irandom(array_length(worker_items) - 1);
        var item = worker_items[index];
        array_delete(worker_items, index, 1);
        return item;
    }
    return undefined;
}

get_worker_type_for_quest = function(quest_id) {
    if (array_length(worker_types) == 0) {
        return obj_office_worker_parent;
    }
    
    for (var i = 0; i < array_length(worker_types); i++) {
        var worker_obj = worker_types[i];
        
        var temp = instance_create_depth(0, 0, 0, worker_obj);
        var bound_quest = temp.bound_quest_id;
        instance_destroy(temp);
        
        if (bound_quest == quest_id) {
            show_debug_message("Found bound worker " + object_get_name(worker_obj) + " for quest: " + quest_id);
            return worker_obj;
        }
    }
    
    var generic_workers = [];
    for (var i = 0; i < array_length(worker_types); i++) {
        var worker_obj = worker_types[i];
        var temp = instance_create_depth(0, 0, 0, worker_obj);
        var bound_quest = temp.bound_quest_id;
        instance_destroy(temp);
        
        if (bound_quest == "") {
            array_push(generic_workers, worker_obj);
        }
    }
    
    if (array_length(generic_workers) > 0) {
        show_debug_message("Using generic worker for quest: " + quest_id);
        return generic_workers[irandom(array_length(generic_workers) - 1)];
    }
    
    show_debug_message("Fallback: using any worker for quest: " + quest_id);
    return worker_types[irandom(array_length(worker_types) - 1)];
}

randomize();

get_unknown_type = function() {
    var remaining_total = num_zombies + num_workers;
    
    if (remaining_total <= 0) {
        return noone;
    }
    
    if (num_workers <= 0) {
        num_zombies -= 1;
        if (array_length(zombie_type) > 0) {
            return {
                object: zombie_type[irandom(array_length(zombie_type) - 1)],
                item_data: undefined
            };
        }
        return noone;
    }
    
    if (num_zombies <= 0) {
        num_workers -= 1;
        var item = get_worker_item();
        var worker_obj = get_worker_type_for_quest(item.quest_id); // FIXED: Pass quest_id
        return {
            object: worker_obj,
            item_data: item
        };
    }
    
    var chance = num_workers / remaining_total;
    var roll = random(1);
    
    if (roll < chance) {
        num_workers -= 1;
        var item = get_worker_item();
        var worker_obj = get_worker_type_for_quest(item.quest_id); // FIXED: Pass quest_id
        return {
            object: worker_obj,
            item_data: item
        };
    } else {
        num_zombies -= 1;
        if (array_length(zombie_type) > 0) {
            return {
                object: zombie_type[irandom(array_length(zombie_type) - 1)],
                item_data: undefined
            };
        }
        return noone;
    }
}