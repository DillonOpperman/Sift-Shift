// Draw the background
draw_self();

// Set the font
draw_set_font(fnt_UI);

// Set the alignment
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Draw the text in the form of: current hp / maximum hp
draw_text_colour(x - sprite_width / 4, y, shorten_num(enemy.hp), #eed8cd, #eed8cd, #eed8cd, #eed8cd, image_alpha);
draw_text_colour(x, y, "/", #eed8cd, #eed8cd, #eed8cd, #eed8cd, image_alpha);
draw_text_colour(x + sprite_width / 4, y, shorten_num(enemy.max_hp), #eed8cd, #eed8cd, #eed8cd, #eed8cd, image_alpha);

// Reset the alignment
draw_set_valign(fa_top);
draw_set_halign(fa_left);