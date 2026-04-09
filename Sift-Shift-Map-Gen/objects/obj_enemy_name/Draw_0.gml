// Draw the background
draw_self();

// Set the font
draw_set_font(fnt_enemy);

// Set the alignment
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Draw the name
draw_text_colour(x, y, name, #eed8cd, #eed8cd, #eed8cd, #eed8cd, image_alpha);

// Reset the alignment
draw_set_valign(fa_top);
draw_set_halign(fa_left);