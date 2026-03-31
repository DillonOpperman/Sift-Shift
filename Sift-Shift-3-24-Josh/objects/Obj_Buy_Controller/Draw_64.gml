var margin = 20;
var spacing = 40;

//draws iron sprite and amount in top left of screen
//draw_sprite_ext(Spr_Iron, 0, margin, margin, 3, 3, 0, c_white, 1);
//draw_text(margin + 40, margin, " = " + string(global.iron));

//draws copper sprite and amount in top left of screen
draw_sprite_ext(Spr_CopperOre, 0, margin, margin + spacing, 1, 1, 0, c_white, 1);
draw_text(margin + 40, margin + spacing, " = " + string(global.copper));

//draws coal sprite and amount in top left of screen
//draw_sprite_ext(Spr_Coal, 0, margin, margin + (spacing * 2), 3, 3, 0, c_white, 1);
//draw_text(margin + 40, margin + (spacing * 2), " = " + string(global.coal));