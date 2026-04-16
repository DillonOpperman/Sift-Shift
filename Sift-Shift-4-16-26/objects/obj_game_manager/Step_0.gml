// Don't perform this event if the game is paused because it's moment-to-moment game logic
if(global.paused)
{
	exit;
}

// Reset the dps amount
global.dps = 0;

// Build up a baseline dps from the cards
with(obj_card)
{
	// Only add the cards' dps if they're unlocked
	if(flipped)
	{
		global.dps += dps; 
	}
}

// Multiply the dps by the amount provided by the cards
with(obj_card)
{	
	// Only use the card if it's unlocked
	if(flipped)
	{
		// Only use the multiplier if it has a stat buff and the correct stat
		if(stat_buff && stat_type == "dps_mult")
		{
			global.dps *= stat_value;
		}
	}
}

// If double dps is active, multiply the total by 2
if(double_dps)
{
	global.dps *= 2;
}

// Round the amount so that it's easier to manage
global.dps = round(global.dps);

// Manage double dps
if(double_dps)
{
	// Add to the double dps timer
	double_timer += delta_time / 1000000;
	
	// If double dps has been active for over 5 seconds reset it
	if(double_timer >= 5)
	{
		double_dps = false;
		double_timer = 0;
	}
}

// Log the amount of time since the last frame
damage_timer += delta_time / 1000000;

// If the cards would deal any damage
if(global.dps > 0)
{
	// Check whether the amount of time logged over the amount needed to deal 1 damage to the enemy
	if (damage_timer >= 1 / global.dps) 
	{
		// If the amount of time between frames is over that amount of time then multiple ticks of damage need to happen between frames
		// If multiple ticks need to happen then find how many ticks should happen so that it doesn't lag the game
		if(delta_time > 1 / global.dps)
		{
			var ticks = floor(damage_timer / (1 / global.dps));
			obj_enemy.hp -= ticks;
			damage_timer -= ticks / global.dps;
		} 
		else // Otherwise just deal 1 damage
		{
			obj_enemy.hp--;
			damage_timer -= 1 / global.dps;
		}
	}
}

// If the player has over 5 billion gold, the game is won
// Only do it once and only if there's no other popup on screen
if(global.save.bank >= 5000000000 && !instance_exists(obj_win_box) && !instance_exists(obj_away_popup))
{
	// Set that the game is won and paused
	global.won = true;
	global.paused = true;
		
	// Draw the game to a surface to display while paused
	global.paused_surf = surface_create(room_width, room_height);
	surface_set_target(global.paused_surf);
	gpu_set_blendenable(false);
	draw_surface(application_surface, 0, 0);
	gpu_set_blendenable(true);
	surface_reset_target();
	
	// Pause the game layers
	pause_everything();
	
	// Create an instance of the win interface
	instance_create_layer(room_width / 2, room_height / 2, "Popups", obj_win_box);
}