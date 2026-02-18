// Inherit the parent event
event_inherited();

// Set the button's text
text = "Menu";
has_text = true;

// Create the function to trigger when the button is clicked
press_function = function() 
{
	// Resume the game
	resume_everything();
	
	// Save the current enemy's health
	global.save.enemy_hp[global.save.enemy_diff] = obj_enemy.hp;
	
	// If the game has been won, delete the save file
	if(global.won) 
	{
		file_delete("idle.sav");
	}
	else // Otherwise, save the game
	{ 
		with(obj_save_manager) 
		{
			save();
		}
	}
	
	// Destroy the save manager
	instance_destroy(obj_save_manager);
	
	// Destroy the particle manager
	instance_destroy(obj_particle_manager);
	
	// Go to the main menu
	room_goto(rm_main_menu);
}