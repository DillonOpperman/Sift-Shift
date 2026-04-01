var margin = 10;
var spacing = 40;

draw_set_font(Fnt_UI)
draw_set_halign(fa_left)
draw_set_colour(c_black)

//draws iron sprite and amount in top left of screen
draw_sprite_ext(Spr_CopperOre, 0, margin, margin + (spacing * 0), 1, 1, 0, c_white, 1);
draw_text(margin + 30, margin + (spacing * 0 - 4), "= " + string(global.copper));

//draws copper sprite and amount in top left of screen
draw_sprite_ext(Spr_IronOre, 0, margin, margin + (spacing * 1), 1, 1, 0, c_white, 1);
draw_text(margin + 30, margin + (spacing * 1 - 2), "= " + string(global.iron));

//draws coal sprite and amount in top left of screen
draw_sprite_ext(Spr_TinOre, 0, margin, margin + (spacing * 2), 1, 1, 0, c_white, 1);
draw_text(margin + 30, margin + (spacing * 2 - 2), "= " + string(global.tin));

//draws coal sprite and amount in top left of screen
draw_sprite_ext(Spr_BronzeOre, 0, margin, margin + (spacing * 3), 1, 1, 0, c_white, 1);
draw_text(margin + 30, margin + (spacing * 3 - 2), "= " + string(global.bronze));

//draws coal sprite and amount in top left of screen
draw_sprite_ext(Spr_SilverOre, 0, margin, margin + (spacing * 4), 1, 1, 0, c_white, 1);
draw_text(margin + 30, margin + (spacing * 4 - 2), "= " + string(global.silver));

draw_sprite_ext(Spr_Bar, -1, 0, 385, 6, 6, 0, c_white, 1)

draw_set_colour(c_white)
draw_sprite_ext(Spr_GoldCoin, -1, 7, 707, 2, 2, 0, c_white, 1)
draw_text_ext_transformed(75, 707, string(global.gold), 10, 300, 2, 2, 0)

build_margin = 250
facility_margin = 80
draw_sprite_ext(Spr_BeltIcon_fake, -1, build_margin + (facility_margin * 0), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_MineIcon_fake, -1, build_margin + (facility_margin * 1), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_SmelterIcon_fake, -1, build_margin + (facility_margin * 2), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_BlacksmithIcon_fake, -1, build_margin + (facility_margin * 3), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_SawmillIcon_fake, -1, build_margin + (facility_margin * 4), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_WindmillIcon_fake, -1, build_margin + (facility_margin * 5), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_WarehouseIcon_fake, -1, build_margin + (facility_margin * 6), 700, 2, 2, 0, c_white, 1)

draw_sprite_ext(Spr_BuildBorder, -1, build_margin + (facility_margin * (Obj_Build_Controller.facility - 1)), 700, 2, 2, 0, c_white, 1)