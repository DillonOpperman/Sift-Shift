// Find whether there are any locked cards
var any_locked = false;

with(obj_card)
{
	if(!unlocked)
	{
		any_locked = true;
	}
}

// If the player doesn't have enough money yet or there aren't any more cards to unlock
if(card_unlock > global.save.bank || !any_locked)
{
	// Pause the lock sequence and set its position to the start position
	with(lock)
	{
		layer_sequence_pause(seq);
		layer_sequence_headpos(seq, 0);
	}
	
	// Make the button transparent
	image_alpha = 0.5;
}
else // Otherwise, play the sequence and reset the alpha
{
	with(lock)
	{
		layer_sequence_play(seq);
	}
	
	image_alpha = 1;
}