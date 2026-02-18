// Create an array to hold the card objects
cards = []

// Function to spawn the cards
function spawn_cards() 
{
	// Create 8 cards
	for(var i = 0; i < 8; i++)
	{
		// Create the card and set up its build
		var card = instance_create_layer(197.5 + (sprite_get_width(spr_card_back) + 40) * i, (y - sprite_get_height(spr_card_back) / 2 - 4), "UI_Interactible", obj_card);
		card.set_build(get_cards()[i]);
	
		// Store the card's ID for access later
		array_push(cards, card);
	}
}