// If the tutorial is not fully open yet
if(!close && !open)
{	
	// LERP the current corners towards the target corners
	for(var i = 0; i < 4; i++) {
		window[i] = lerp(window[i], target_window[i], 0.2);
	}
	
	// If the window's corners are close enough to the targets, set them to the target and set the tutorial as open
	if(abs(window[0] - target_window[0]) <= 5)
	{
		for(var i = 0; i < 4; i++) {
			window[i] = target_window[i];
		}
		
		open = true;
	}
} 
else if (close) // If the tutorial is should be closing, repeat the process
{	
	for(var i = 0; i < 4; i++) {
		window[i] = lerp(window[i], target_window[i], 0.2);
	}
	
	// If it has reached the smallest it should be, destroy the tutorial
	if(abs(window[0] - target_window[0]) <= 5)
	{
		instance_destroy();
	}
}