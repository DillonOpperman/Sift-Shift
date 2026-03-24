// Only animate if the card should be unlocking
if(unlocked && !flipped)
{
	// If the card still has the card back sprite, it should become thinner and taller
	if(sprite_index != spr_card_front) 
	{
		// Run the animation curve forwards
		ac_timer += delta_time / 200000;
		
		// If the animation timer is complete, it should be effectively "unlocked"
		if(ac_timer >= 1)
		{
			// Reflect the timer about 1
			ac_timer = 2 - ac_timer;
			
			// Set the sprite to the actual card sprite
			sprite_index = spr_card_front;
			
			// Add the card's ability to the game manager
			if(onclick) { array_push(obj_game_manager.onclick_methods, func); }
			else if (onappear) { array_push(obj_game_manager.onappear_methods, func); }
			else if (onkill) { array_push(obj_game_manager.onkill_methods, func); }
		}
	} else 
	{ 
		// Otherwise, it should be running backwards so it returns to normal dimensions
		ac_timer -= delta_time / 200000;
		
		// If the animation is complete backwards, mark it as complete
		if(ac_timer <= 0)
		{
			flipped = true;
			ac_timer = 0;
		}
	}
	
	// Set the x scale and y scale according to the animation curve
	image_xscale = animcurve_channel_evaluate(animcurve_get_channel(ac, "xScale"), ac_timer);
	image_yscale = animcurve_channel_evaluate(animcurve_get_channel(ac, "yScale"), ac_timer);
}