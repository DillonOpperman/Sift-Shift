// Block click processing in game objects for 5 frames
global._input_guard = 5;
 
instance_activate_all();
load_game(_pending_load_slot);
 
game_active = true;
menu_state  = "none";
menu_index  = 0;
 
if (surface_exists(pause_surface)) {
    surface_free(pause_surface);
    pause_surface = -1;
}
 
show_debug_message("obj_pause: LOAD applied (alarm 1, slot " + string(_pending_load_slot) + ") — input guard ON");
 