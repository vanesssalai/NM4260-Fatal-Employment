function Dialogue() constructor {
	dialog = [];
	
	add = function(_name, _message) {
		array_push(dialog, {
			type: "message",
			name: _name,
			message: _message,
		});
	}
	
	add_choice = function(_prompt, _choices) {
		array_push(dialog, {
			type: "choice",
			prompt: _prompt,
			choices: _choices
		});
	}
	
	add_response = function(_response_array) {
		for (var i = 0; i < array_length(_response_array); i++) {
			add(_response_array[i].name, _response_array[i].message);
		}
	}
	
	pop = function() {
		var _t = array_first(dialog);
		array_delete(dialog, 0, 1);
		
		return _t;
	}
	
	count = function() {
		return array_length(dialog);
	}
}