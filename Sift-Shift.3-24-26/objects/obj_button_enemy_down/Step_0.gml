// If this object should be transitioning out the enemy
if(transitioning) 
{
	// If the transition is within the first 0.1 seconds, the original enemy should be transitioning out
	if(transition_timer < 0.1) 
	{
		// Increase the time into the transition
		transition_timer += delta_time / 1000000;
		
		// Move the enemy off-screen and fade them out according to the animation curve
		with(obj_enemy) 
		{
			x = xstart + animcurve_channel_evaluate(animcurve_get_channel(other.ac, "xPosition"), other.transition_timer * 10);
			image_alpha = 1 - other.transition_timer * 10;
		}
		
		// If the time element is at 0.1 seconds, move to the second phase of the transition
		if(transition_timer >= 0.1) 
		{
			// Destroy the current enemy
			instance_destroy(obj_enemy);
			global.save.enemy_diff--;
			
			// Create a new enemy on the other side of the screen and hide it
			var e = instance_create_layer(room_width / 2, 446, "Enemy", obj_enemy);
			e.image_alpha = 0;
		}
	} 
	else 
	{
		// Increase the time into the transition
		transition_timer += delta_time / 1000000;
		
		// Move the enemy on-screen and fade them in according to the animation curve
		with(obj_enemy) 
		{
			x = xstart - animcurve_channel_evaluate(animcurve_get_channel(other.ac, "xPosition"), 1 - (other.transition_timer - 0.1) * 10);
			image_alpha = (other.transition_timer - 0.1) * 10;
		}
		
		// If the time element is over 0.2 seconds, mark it as complete
		if(transition_timer > 0.2) {
			transitioning = false;
			transition_timer = 0;
		}
	}
}