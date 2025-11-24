var worker_count = 0;
with (obj_office_worker_parent) {
    worker_count++;
    show_debug_message("  Found worker: " + worker_name + " (ID: " + string(id) + ")");
}
show_debug_message("Manual count: " + string(worker_count));

var success = setup_npc_tracking();
show_debug_message("Setup result: " + string(success));