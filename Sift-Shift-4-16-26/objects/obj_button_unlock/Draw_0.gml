// Copy the target draw scale for manipulation
var draw_scale = target_scale;

// Find if there are any cards to unlock
// Find if any cards exist as a baseline
var any_locked = !instance_exists(obj_card);

with(obj_card)
{
	if(!unlocked)
	{
		any_locked = true;
	}
}

// Check if there is nothing more for the player to unlock
if(card_unlock > global.save.bank || !any_locked)
{
	// Reset the draw scale and set the button to draw in greyscale
	draw_scale = 1;
	shader_set(sh_greyscale);
}

// Multiply the draw scale by the current image scale to find the proper draw scale
var draw_xscale = draw_scale * image_xscale;
var draw_yscale = draw_scale * image_yscale;

// Store the center of the text to draw as 4 pixels above the center of the object
var center_y = y - 4;

// Draw the background sprite
draw_sprite_ext(sprite_index, 0, x, y, draw_xscale, draw_yscale, image_angle, image_blend, image_alpha);

// If there are any more locked cards, draw a gold icon
if(any_locked)
{
	draw_sprite_ext(icon, 0, x + 60 * draw_xscale, center_y, draw_xscale * 0.8, draw_yscale * 0.8, image_angle, image_blend, image_alpha);
}

// Reset the shader
shader_reset();

// Set the text draw colour depending on if there are any more cards to unlock
if(card_unlock > global.save.bank || !any_locked)
{
	draw_set_colour(#dcdcdc);
} 
else 
{
	draw_set_colour(#eed8cd);
}

// Set the text alignments
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Set the font
draw_set_font(Fnt_UI);

// Draw the text on the button
if(any_locked) 
{
	draw_text_transformed(x - 60 * draw_xscale, center_y, "Unlock", draw_xscale, draw_yscale, image_angle);
	draw_num(x + 100 * draw_xscale, center_y, draw_xscale, draw_yscale, Fnt_UI, card_unlock);
} 
else 
{
	draw_text_transformed(x, center_y, "All unlocked", draw_xscale, draw_yscale, image_angle);
}

// Reset the text alignment and colour
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_colour(c_white);