// If there is no lower difficulty then the button should be deactivated
// To show that it's deactivated, make it slightly transparent
if(global.save.enemy_diff <= 0)
{
	image_alpha = 0.5;
	target_scale = 1;
}

// Inherit the parent event
event_inherited();

// Reset the image alpha for the next frame
image_alpha = 1;