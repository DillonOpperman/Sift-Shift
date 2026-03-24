// Draw the text box
draw_self();

// Only draw the text if it's fully open
if(open)
{	
	// Set the text alignment
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	// Set the font 
	draw_set_font(fnt_UI);

	// Draw the text
	draw_text(x, y - 100, align_string(text, str_length));

	// Reset the text alignments
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}