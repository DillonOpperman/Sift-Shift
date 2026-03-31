// If the game isn't won, resume the game
if(!global.won) {
	// Reactivate objects
	resume_everything();

	instance_activate_object(obj_button_options)

	// Set that the game is not paused any more
	global.paused = false;
	
	// Free the pause surface
	surface_free(global.paused_surf);
	
	// Sound cue for the popup;
	audio_play_sound(snd_popup, 0, false, 1, 0, 0.6);
}
else // Otherwise, create the win interface object
{
	// Create the object
	instance_create_layer(room_width / 2, room_height / 2, "Popups", obj_win_box);	
}