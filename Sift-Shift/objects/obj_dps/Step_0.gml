// Run through the array and check if the clicks were over a second ago
while(true) 
{
	// If there are any clicks to parse
	if(array_length(recent_clicks) > 0) 
	{
		// If the time difference is over a second
		if(current_time - recent_clicks[0].time > 1000) 
		{
			// Delete the element from the array
			array_delete(recent_clicks, 0, 1);
		} 
		else // Otherwise break the loop
		{
			break;
		}
	} 
	else // Otherwise break the loop
	{
		break;
	}
}

// Set the baseline dps to the global variable
dps = global.dps;

//Add the click damage to the dps
array_foreach(recent_clicks, add_to_dps);