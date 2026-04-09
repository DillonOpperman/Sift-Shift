var margin = 10;
var spacing = 40;

draw_set_font(Fnt_UI)
draw_set_halign(fa_left)
draw_set_colour(c_black)

//Ore

//draws copper icon sprite and amount in top left of screen
draw_sprite_ext(Spr_CopperOre, 0, margin, margin + (spacing * 0), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 0 - 4), "= " + string(global.copper), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws iron icon sprite and amount in top left of screen
draw_sprite_ext(Spr_IronOre, 0, margin, margin + (spacing * 1), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 1 - 2), "= " + string(global.iron), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws tin icon sprite and amount in top left of screen
draw_sprite_ext(Spr_TinOre, 0, margin, margin + (spacing * 2), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 2 - 2), "= " + string(global.tin), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws bronze icon sprite and amount in top left of screen
draw_sprite_ext(Spr_BronzeOre, 0, margin, margin + (spacing * 3), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 3 - 2), "= " + string(global.bronze), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws silver icon sprite and amount in top left of screen
draw_sprite_ext(Spr_SilverOre, 0, margin, margin + (spacing * 4), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 4 - 2), "= " + string(global.silver), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//Ingots

//draws copper icon sprite and amount in top left of screen
draw_sprite_ext(Spr_CopperIngot, 0, margin, margin + (spacing * 5), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 5- 4), "= " + string(global.copperIngot), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws iron icon sprite and amount in top left of screen
draw_sprite_ext(Spr_IronIngot, 0, margin, margin + (spacing * 6), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 6 - 2), "= " + string(global.ironIngot), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws tin icon sprite and amount in top left of screen
draw_sprite_ext(Spr_TinIngot, 0, margin, margin + (spacing * 7), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 7 - 2), "= " + string(global.tinIngot), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws bronze icon sprite and amount in top left of screen
draw_sprite_ext(Spr_BronzeIngot, 0, margin, margin + (spacing * 8), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 8 - 2), "= " + string(global.bronzeIngot), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws silver icon sprite and amount in top left of screen
draw_sprite_ext(Spr_SilverIngot, 0, margin, margin + (spacing * 9), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 9 - 2), "= " + string(global.silverIngot), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);


//draws silver icon sprite and amount in top left of screen
draw_sprite_ext(Spr_Timber, 0, margin, margin + (spacing * 10), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 10 - 2), "= " + string(global.timber), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws silver icon sprite and amount in top left of screen
draw_sprite_ext(Spr_Lumber, 0, margin, margin + (spacing * 11), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 11 - 2), "= " + string(global.lumber), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);


//draws tin icon sprite and amount in top left of screen
draw_sprite_ext(Spr_CopperTools, 0, margin, margin + (spacing * 12), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 12 - 2), "= " + string(global.copperTools), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws bronze icon sprite and amount in top left of screen
draw_sprite_ext(Spr_IronTools, 0, margin, margin + (spacing * 13), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 13 - 2), "= " + string(global.ironTools), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);

//draws silver icon sprite and amount in top left of screen
draw_sprite_ext(Spr_BronzeTools, 0, margin, margin + (spacing * 14), 1, 1, 0, c_white, inventory_alpha);
draw_text_ext_colour(margin + 30, margin + (spacing * 14 - 2), "= " + string(global.bronzeTools), 5, 300, c_black, c_black, c_black, c_black, inventory_alpha);


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
draw_sprite_ext(Spr_TimbermillIcon_fake, -1, build_margin + (facility_margin * 5), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_WarehouseIcon_fake, -1, build_margin + (facility_margin * 6), 700, 2, 2, 0, c_white, 1)
draw_sprite_ext(Spr_Destroy, -1, build_margin + (facility_margin * 7), 700, 2, 2, 0, c_white, 1)

draw_sprite_ext(Spr_BuildBorder, -1, build_margin + (facility_margin * (Obj_Build_Controller.facility - 1)), 700, 2, 2, 0, c_white, 1)