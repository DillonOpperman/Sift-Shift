tile = 32;

x = floor(x / tile) * tile;
y = floor(y / tile) * tile;

building_name = "Timbermill"
produces = "Timber"
consumes = "Sits on a grove or forest tile."
description = "Facility used to make timber."

spawn_interval = game_get_speed(gamespeed_fps) * 3;
spawn_timer = 0;

var layer_id = layer_get_id("Tiles_Resource");
var tm_id = layer_tilemap_get_id(layer_id);

var tdata = tilemap_get_at_pixel(tm_id, x, y);
var tidx = tile_get_index(tdata);

wood_object = noone;

switch(tidx) {
	case 11: wood_object = Obj_Timber; break;
	case 12: wood_object = Obj_Timber; break;
}
