// If there is another tutorial to spawn after this one, spawn it
if(next_spawn_method) {
	method_call(next_spawn_method, []);
} 
else // Otherwise resume the game
{ 
	// Activate the objects
	resume_everything();
	
	instance_activate_object(obj_button_options);
	
	// Set that the game is not paused
	global.paused = false;
	
	// Free the pause surface
	surface_free(global.paused_surf);
	
    // Loop through the card docks
    with (obj_card_dock)
    {
    	// Spawn the cards
    	spawn_cards();
    }
	
	// Destroy the manager
	instance_destroy(obj_tutorial_manager);
}