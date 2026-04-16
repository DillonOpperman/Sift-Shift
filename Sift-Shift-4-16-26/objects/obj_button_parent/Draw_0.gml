// The buttons will have different formats such as an icon on a background, text on a background, or just an icon
// If it has a background and an icon
if(has_background) 
{
	// Draw this object's sprite as the background
	draw_self();

	// Draw the icon sprite at the target scale and transparency
	draw_sprite_ext(icon, 0, x, y, image_xscale * target_scale, image_yscale * target_scale, image_angle, image_blend, image_alpha);
} 
else if(has_text) // Otherwise, if it's a background with text
{ 
	// Draw this object's background at the target scale
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale * target_scale, image_yscale * target_scale, image_angle, image_blend, image_alpha);
	
	// Set the font
	draw_set_font(Fnt_UI);
	
	// Set the text alignments
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	// Draw the text at the target scale
	draw_text_transformed(x, y, text, image_xscale * target_scale, image_yscale * target_scale, image_angle);
	
	// Reset the text alignments
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
} 
else // Otherwise, it's just an icon
{ 
	// Draw this object's sprite at the target scale
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale * target_scale, image_yscale * target_scale, image_angle, image_blend, image_alpha);
}