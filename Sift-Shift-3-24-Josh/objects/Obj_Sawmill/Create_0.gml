tile = 32;

x = floor(x / tile) * tile;
y = floor(y / tile) * tile;

hovering = false
icon_alpha = 0
item_type = 21
current_lumber = Spr_Lumber
current_fuel = global.timber
lumber_object = Obj_Lumber;

spawn_interval = game_get_speed(gamespeed_fps) * 3;
spawn_timer = 0;

var layer_id = layer_get_id("Tiles_Resource");
var tm_id = layer_tilemap_get_id(layer_id);

var tdata = tilemap_get_at_pixel(tm_id, x, y);
var tidx = tile_get_index(tdata);
