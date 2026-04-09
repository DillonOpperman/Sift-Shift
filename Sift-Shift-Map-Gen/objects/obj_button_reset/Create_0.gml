// Inherit the parent event
event_inherited();

// Create the function to trigger when the button is pressed
press_function = function() {
	// Restart the game
	with(obj_save_manager) 
	{
		reset(); // Reset the save file
		load(); // Load the new save file
		
		// Destroy the enemy object and create a new one
		instance_destroy(obj_enemy);
		instance_create_layer(room_width / 2, 446, "Enemy", obj_enemy);
		
		// Mark that the game is not won
		global.won = false;
	}
	
	// Resume the game and destroy the pause menu
	with(obj_button_options) 
	{
		global.paused = false;
		
		surface_free(global.paused_surf);
		
		resume_everything();
		
		layer_sequence_destroy(pause_seq);
	}
	
	// Destroy the win UI
	with(obj_win_box) {
		instance_destroy();
	}
	
	// Reset the game manager's abilities
	with(obj_game_manager) {
		onclick_methods = [];
		onkill_methods = [];
		onappear_methods = [];
	}
	
	// Clear the particle effects
	with(obj_particle_manager) {
		reset();
	}
}