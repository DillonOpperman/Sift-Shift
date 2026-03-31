// Inherit the parent event
event_inherited();

// Set the base unlock price
card_unlock = 30;

// Create a function to remake the card unlock price
function setup() {
	// Set the base price
	card_unlock = 30;

	// Multiply the price by 10 for each currently unlocked card
	with(obj_card) {
		if(unlocked) {
			other.card_unlock = other.card_unlock * 10;
		}
	}
}

// Create a lock object instance to show better that a you can unlock a card or not
lock = instance_create_layer(x, y - sprite_get_height(spr_card_back) / 2, layer, obj_lock); 

// Create a function to trigger when the button is pressed
press_function = function() 
{
	// If the player does not have the gold to unlock a card, do not trigger this function
	if(card_unlock > global.save.bank)
	{
		exit;
	}
	
	// Find the number of cards still currently locked
	var num_locked = 8;
	
	with(obj_card)
	{
		if(unlocked)
		{
			num_locked--;
		}
	}
	
	// If there are no cards to unlock, do not trigger this function
	if(num_locked == 0)
	{
		exit;
	}
	
	// Find the next card to unlock
	var unlock = 8 - num_locked;
	
	// Unlock the card in that position
	with(obj_card_dock.cards[unlock])
	{
		// Play a flip sound effect
		audio_play_sound(snd_flip, 0, 0);
				
		// Create a burst of particles
		with(obj_particle_manager) {
			part_particles_burst(particle_system, other.x, other.y, ps_card_reveal);	
		}
				
		// Unlock this card
		unlocked = true;
	}

	// Take the gold needed from the player's bank
	global.save.bank -= card_unlock;
	
	// Increase the amount of gold needed to unlock the next card
	card_unlock = card_unlock * 10;
}