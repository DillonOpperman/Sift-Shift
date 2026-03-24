// If the box isn't fully open yet
if(!open)
{
	// LERP the current scale towards the target scale
	image_xscale = lerp(image_xscale, target_xscale, 0.2);
	image_yscale = lerp(image_yscale, target_yscale, 0.2);
	
	// Check if the current scale is close enough to the target scale
	if(abs(1 - image_xscale / target_xscale) <= 0.01)
	{
		// Set the current scale to the target scale
		image_xscale = target_xscale;
		image_yscale = target_yscale;
		
		// Flag that the box is fully open
		open = true;
		
		// Create the buttons
		menu_button = instance_create_depth(x - 200, y + 100, depth - 10, obj_button_menu);
		reset_button = instance_create_depth(x + 200, y + 100, depth - 10, obj_button_reset);
	}
}