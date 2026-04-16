// Inherit the parent event
event_inherited();

// Create a variable to store the pause sequence
pause_seq = 0;

// Create a function to trigger when the button is pressed
press_function = function() {
	// Only trigger the function if the game is not paused
	if(!global.paused) {
		// Pause the game
		global.paused = true;
		
		// Save the current game frame
		global.paused_surf = surface_create(room_width, room_height);
		surface_set_target(global.paused_surf);
		gpu_set_blendenable(false);
		draw_surface(application_surface, 0, 0);
		gpu_set_blendenable(true);
		surface_reset_target();
		
		// Pause
		pause_everything();
		
		// Create and spawn the spawn sequence
		pause_seq = layer_sequence_create("Popups", room_width / 2, room_height / 2, seq_pause);
		
		// Sound effect for the menu
		audio_play_sound(snd_popup, 0, 0)
	}
}