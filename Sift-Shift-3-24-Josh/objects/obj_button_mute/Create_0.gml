// Inherit the parent event
event_inherited();

// Create a function to trigger when the button is pressed
press_function = function() {
	
	// Set the master gain to the opposite of its current state (muted => unmuted and vice versa)
	audio_master_gain(!audio_get_master_gain(0));
	
	// Set the sprite depending on the current master gain mute state
	if(audio_get_master_gain(0)) 
	{
		icon = spr_button_mute;
	} 
	else 
	{
		icon = spr_button_unmute;
	}
}