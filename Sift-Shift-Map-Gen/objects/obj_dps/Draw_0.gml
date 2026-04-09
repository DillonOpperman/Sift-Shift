// Draw the icon
draw_self();

// Set the font
draw_set_font(fnt_HUD);

// Set the draw colour
draw_set_colour(#eed8cd);

// Set the text alignment
draw_set_valign(fa_middle);

// Draw the dps amount
draw_text_transformed(x + sprite_width / 2 + 20, 55, shorten_num(dps) + " DPS", image_xscale, image_yscale, image_angle)

// Reset the draw colour and alignment
draw_set_colour(c_white);
draw_set_valign(fa_top);