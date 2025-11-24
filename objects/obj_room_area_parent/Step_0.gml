if (instance_exists(obj_player)) {
    if (place_meeting(x, y, obj_player)) {
        if (instance_exists(obj_minimap)) {
            obj_minimap.current_room = room_name;
            obj_minimap.current_room_area = id;
        }
    }
}