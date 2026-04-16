// Trigger the parent event
event_inherited();

// Set the button's text
text = "Resume";
has_text = true;

// Create a function to trigger when the button is pressed
press_function = function() {
	// Resume the game
	global.paused = false;
		
	surface_free(global.paused_surf);
		
	resume_everything();
	
	// Destroy the pause menu
	with(obj_button_options) {
		layer_sequence_destroy(pause_seq);
	}
}