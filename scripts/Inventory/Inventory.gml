function Inventory() constructor {
	
	inventory_items = [];
	max_items = 10;
	
	item_add = function(_name, _qty, _sprite, _consumable = false){
		for (var i = 0; i < _qty; i++) {
			if (array_length(inventory_items) >= max_items) {
				show_debug_message("Inventory full! Cannot add " + _name);
				return false;
			}
			
			array_push(inventory_items, {
				name: _name,
				sprite: _sprite,
				consumable: _consumable
			});
		}
		
		show_debug_message("Added " + string(_qty) + "x " + _name + " to inventory");
		return true;
	}
	
	item_find = function(_name){
		for (var i = 0; i < array_length(inventory_items); i++) {
			if (_name == inventory_items[i].name) {
				return i;
			}	
		}
		return -1;
	}
	
	item_count = function(_name) {
		var count = 0;
		for (var i = 0; i < array_length(inventory_items); i++) {
			if (inventory_items[i].name == _name) {
				count++;
			}
		}
		return count;
	}
	
	item_has = function(_name, _qty) {
		return item_count(_name) >= _qty;
	}
	
	item_subtract = function(_name, _qty) {
		var removed = 0;
		
		for (var i = array_length(inventory_items) - 1; i >= 0 && removed < _qty; i--) {
			if (inventory_items[i].name == _name) {
				array_delete(inventory_items, i, 1);
				removed++;
			}
		}
		
		show_debug_message("Removed " + string(removed) + "x " + _name);
		return removed == _qty;
	}
	
	// Remove item at specific index
	item_remove = function(_index) {
		if (_index >= 0 && _index < array_length(inventory_items)) {
			array_delete(inventory_items, _index, 1);
		}
	}
	
	// Check if inventory is full
	is_full = function() {
		return array_length(inventory_items) >= max_items;
	}
	
	// Get free slots
	get_free_slots = function() {
		return max_items - array_length(inventory_items);
	}
	
	item_effect = function(_name) {
		show_debug_message(">>> item_effect called for: " + _name);
		show_debug_message(">>> Players exist before effect: " + string(instance_number(obj_player)));
    
		switch(_name) {
			case "Coffee":
				
			    if (instance_exists(obj_player)) {
			        if (obj_player.speed_boost_timer > 0) {
			            return false;
			        }
					
			        obj_player.activate_speed_boost(1.8, 300);
					
			        return true;
			    }
			    break;
        
			case "Heal":
			    if (instance_exists(obj_player)) {
			        if (obj_player.life < obj_player.max_life) {
			            var healed = obj_player.heal_player(1);
			            if (healed) {
			                return true;
			            } else {
			                return false;
			            }
			        } else {
			            return false;
			        }
			    }
			    break;
        
			default:
			    show_debug_message("No effect defined for: " + _name);
			    return false;
		}
    
		return false;
	}
	
	// Use consumable item
	item_use = function(_name) {
		show_debug_message("Attempting to use: " + _name);
		
		var index = item_find(_name);
		
		if (index < 0) {
			show_debug_message("Item not found in inventory: " + _name);
			return false;
		}
		
		show_debug_message("Item found at index: " + string(index));
		
		// Check if item is consumable
		var is_consumable = false;
		if (variable_struct_exists(inventory_items[index], "consumable")) {
			is_consumable = inventory_items[index].consumable;
			show_debug_message("Item consumable: " + string(is_consumable));
		} else {
			show_debug_message("WARNING: Item has no consumable property!");
			return false;
		}
		
		if (is_consumable) {
			show_debug_message("Item is consumable - triggering effect");
			
			var effect_applied = item_effect(_name);
			
			if (effect_applied) {
				item_subtract(_name, 1);
				show_debug_message("Item consumed successfully");
				return true;
			} else {
				show_debug_message("Item not consumed - effect condition not met");
				return false;
			}
		} else {
			show_debug_message("Item is not consumable");
		}
		
		return false;
	}
}