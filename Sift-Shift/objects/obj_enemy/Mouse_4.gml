// The player should only be able to damage the enemy if it's not transitioning
if(!obj_button_enemy_down.transitioning && !obj_button_enemy_up.transitioning) 
{	
	// Create a temporary place to store how much extra damage a click on the enemy should do
	var click_mod = accumulate_stats("click");
	
	// Check for a crit
	var crit_chance = accumulate_stats("crit");

	// Store the damage that a click causes: 1 plus the click modifier just created
	var dmg = 1 + click_mod;
	
	// Determine whether the player has hit a critical hit
	var crit = random(100) < crit_chance;
	
	// If the player scores a crit, double the damage
	if(crit) 
	{
		// Play a critical hit sound effect but randomise the pitch for variance
		audio_play_sound(snd_enemy_crit, 0, 0, 1, 0, random_range(0.8, 1.2));
		
		dmg *= 2;
	}
	else
	{
		// Play a regular click sound effect but randomise the pitch for variance
		audio_play_sound(snd_enemy_click, 0, 0, 1, 0, random_range(0.8, 1.2));
	}

	// Store the time that the click took place and the amount of damage it did so that it can be added to the dps representation
	var click = {
		time : current_time,
		damage : dmg	
	}

	// Damage the enemy
	hp -= dmg;
	
	// Trigger any on-click effects
	obj_game_manager.on_click();  

	// Send the stored time/damage structure to the dps object
	with(obj_dps) 
	{
		array_push(recent_clicks, click);
	}

	// Create a burst of a particle to show that the enemy has been damaged
	with(obj_particle_manager) 
	{
		if(!crit)
		{
			part_particles_burst(particle_system, mouse_x, mouse_y, ps_damage);
		}
		else
		{
			part_particles_burst(particle_system, mouse_x, mouse_y, choose(ps_crit_left, ps_crit_right));
		}
	}
}