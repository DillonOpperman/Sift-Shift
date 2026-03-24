// Draw the card regardles of current sprite
draw_self();

// If the card's sprite is the front then draw the text onto it
if(sprite_index = spr_card_front)
{
	// Draw the icon on the card
	draw_sprite_ext(sprite, 0, x, y - 55 * image_yscale, sprite_scale * image_xscale, sprite_scale * image_yscale, 0, c_white, 1);
	
	// Set the alignments
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	// Set the font for the card's name
	draw_set_font(fnt_card_name);
	
	// Draw the card's name
	draw_text_transformed_colour(x, y + 9 * image_yscale, name, image_xscale, image_yscale, image_angle, #eed8cd, #eed8cd, #eed8cd, #eed8cd, 1);

	// Write the text onto the card with the same scaling as the card so it looks like one piece
	draw_text_line(fnt_card, "DPS: " + shorten_num(dps) + "\n" + description, x, y + 72 * image_yscale, image_xscale, image_yscale, 160);
	
	// Reset the alignment
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}