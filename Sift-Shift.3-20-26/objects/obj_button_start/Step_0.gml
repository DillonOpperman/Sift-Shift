// If the "mode" means that the graphic should be getting larger
if(mode == 0) 
{
	// Make the graphic larger
	image_xscale += 0.005;
	image_yscale += 0.005;
	
	// Make the graphic more transparent
	image_alpha -= 0.01;
	
	// If the graphic is at the upper bound
	if(image_xscale >= 1.3) 
	{
		// Switch to the mode that makes it smaller
		mode = 1;
	}
} 
else // If the graphic should be getting smaller
{ 
	// Make the graphic smaller
	image_xscale -= 0.005;
	image_yscale -= 0.005;
	
	// Make the graphic more opaque
	image_alpha += 0.01;
	
	// If the graphic is at the lower bound
	if(image_xscale <= 1){
		// Switch to the mode that makes it larger
		mode = 0;
	}
}