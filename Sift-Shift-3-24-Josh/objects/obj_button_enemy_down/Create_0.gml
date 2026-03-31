// Inherit the parent event
event_inherited();

// Set up variables to use with transitioning in/out enemies
transitioning = false;
transition_timer = 0;
ac = animcurve_get(ac_enemy_transition);

// Override the press function
// Function to decrease the difficulty of the enemy
press_function = function() 
{
	// If there is already a transition happening, don't replay the sound effect
	if(!transitioning)
	{
		// Only trigger if the enemy is not already transitioning
		if(!obj_button_enemy_up.transitioning) 
		{
			// If there is a lower difficulty to go to
			if(global.save.enemy_diff > 0) 
			{
				// Play a scrolling sound effect
				audio_play_sound(snd_enemy_scroll, 0, 0);
			
				// Set that this object should transition out the enemy
				transitioning = true;
			}
		}
	}
}