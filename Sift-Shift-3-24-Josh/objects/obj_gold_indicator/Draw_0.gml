// Draw the background
draw_self();

// Draw a gold coin sprite
draw_sprite_ext(spr_gold_coin, 0, x, y - 20, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

// Set the font
draw_set_font(fnt_UI);

// Set the text alignments
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Find how many coins the enemy is worth
var coins = enemy.gold;
var num = shorten_num(coins)

// Draw that number to the screen
draw_text_colour(x, y + 25, num, #eed8cd, #eed8cd, #eed8cd, #eed8cd, image_alpha);

// Reset the text alignments
draw_set_valign(fa_top);
draw_set_halign(fa_left);