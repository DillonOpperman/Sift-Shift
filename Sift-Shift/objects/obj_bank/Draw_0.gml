// Draw the icon
draw_self();

// Set the draw colour
draw_set_colour(#eed8cd);

// Set the vertical text alignment
draw_set_valign(fa_middle);

// Draw the DPS value
draw_num(x + sprite_width / 2 + 20, y - 3, image_xscale, image_yscale, fnt_HUD, global.save.bank);

// Reset the colour and the vertical alignment
draw_set_colour(c_white);
draw_set_valign(fa_top);