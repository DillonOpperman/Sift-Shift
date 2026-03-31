// Save the application surface so it serves as a background for the away popup/tutorials
if(first_run) {
	// Mark that this is no longer the first frame
	first_run = false;
	
	// Pause the game
	global.paused = true;
	global.paused_surf = surface_create(room_width, room_height);
	
	// Save the application surface
	surface_set_target(global.paused_surf);
	gpu_set_blendenable(false);
	draw_surface(application_surface, 0, 0);
	gpu_set_blendenable(true);
	surface_reset_target();
	
	// Pause all the objects
	pause_everything();
	instance_deactivate_object(obj_button_options);

	// Spawn the first tutorial or activate the away popup
	if(!tutorialed) {
		spawn_tut_enemy();
	} else {
		instance_activate_object(obj_away_popup);
	}
}