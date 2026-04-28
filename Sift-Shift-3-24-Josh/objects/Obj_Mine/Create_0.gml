tile = 32;

x = floor(x / tile) * tile;
y = floor(y / tile) * tile;

building_name = "Mine"
produces = "Ore"
consumes = "Sits on an ore tile"
description = "Facility used to generate ore."

spawn_interval = game_get_speed(gamespeed_fps) * 3;
spawn_timer = 0;

var layer_id = layer_get_id("Tiles_Resource");
var tm_id = layer_tilemap_get_id(layer_id);

var tdata = tilemap_get_at_pixel(tm_id, x, y);
var tidx = tile_get_index(tdata);

ore_object = noone;

switch(tidx) {
	case 1: ore_object = Obj_Copper; break;
	case 2: ore_object = Obj_Iron; break;
	case 3: ore_object = Obj_Tin; break;
	case 4: ore_object = Obj_Bronze; break;
	case 5: ore_object = Obj_Silver; break;
}
