// Find an appropriate width for the card sprite
var w2 = 0.75 * sprite_get_width(spr_card_back) / 2;
var h2 = 0.75 * sprite_get_height(spr_card_back) / 2;

// Draw the card sprite slightly slanted
draw_sprite_pos(spr_card_back, 0, 
	x - w2 - 10, y - h2, 
	x + w2 - 10, y - h2,
	x + w2 + 10, y + h2,
	x - w2 + 10, y + h2,
	image_alpha);
	
// The sequence will appear just above because it was created after this was