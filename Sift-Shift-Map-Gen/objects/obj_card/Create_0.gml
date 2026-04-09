// Set ability-related variables
// sprite			The icon to display on the card
// sprite_scale		The size to display the icon at
// name				The name to display on the card
// dps				The amount of damage the card adds per second
// description		A high-level description of what the card does
// onkill			Whether the card's ability triggers on killing an enemy
// onappear			Whether the card's ability triggers when a new enemy appears
// onclick			Whether the card's ability triggers when the player clicks on the enemy
// stat_buff		Whether the card adds another stat than the base DPS
// stat_type		The stat other than the DPS to affect
// stat_value		The amount of the stat to use
// func				The card's ability if it triggers on kill, appear, or click
sprite = spr_card_front;
sprite_scale = 1;
name = "";
dps = 0;
description = "";
onkill = true;
onappear = false;
onclick = false;
stat_buff = false;
stat_type = "";
stat_value = 0;
func = function(){ };

// Set that the card is not unlocked yet
unlocked = false;

// Get the animation curve used to animate the card flipping over
ac = animcurve_get(ac_card_flip);
ac_timer = 0;
flipped = false;

// Set the card's abilities
function set_build(new_build)
{
	// With every part of the new build, set the current build to its corresponding value
	sprite = new_build.sprite;
	sprite_scale = new_build.sprite_scale;
	name = new_build.name;
	dps = new_build.dps;
	description = new_build.description;
	onkill = new_build.onkill;
	onappear = new_build.onappear;
	onclick = new_build.onclick;
	stat_buff = new_build.stat_buff;
	stat_type = new_build.stat_type;
	stat_value = new_build.stat_value;
	func = new_build.func;
}

// Function to unlock the card without needing to see the full animation
function quick_unlock() 
{
	// Unlock the card
	unlocked = true;
	flipped = true;
	
	// Set the sprite
	sprite_index = spr_card_front;
	
	// Set up the card's ability in the game manager
	if(onclick) { array_push(obj_game_manager.onclick_methods, func); }
	else if (onappear) { array_push(obj_game_manager.onappear_methods, func); }
	else if (onkill) { array_push(obj_game_manager.onkill_methods, func); }
}