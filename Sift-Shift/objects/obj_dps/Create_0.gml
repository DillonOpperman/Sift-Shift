// Create an array to store all the recent clicks
recent_clicks = [];

// Create a variable to store all the damage the clicks would do
dps = 0;

// Create a function to add the click damage to the dps variable
function add_to_dps(element, index) 
{
	dps += element.damage;
}