//gets x and y and snaps it to the 32x32 grid
var mx = mouse_x div tile_size;
var my = mouse_y div tile_size;

hover_x = mx * tile_size;
hover_y = my * tile_size;


//when mouse is clicked on question tiles it removes them
if(mouse_check_button_pressed(mb_left)) {
	// gets the id of buyable layer
	var layer_id = layer_get_id("Tiles_Buyable");
	//gets the tile map ID of that layer
	var map_id = layer_tilemap_get_id(layer_id);
	
	//finds top left of box mouse is in
	var big_x = (mouse_x div 32) * 32;
	var big_y = (mouse_y div 32) * 32;
	
	//gets tile at mouse position
	var clicked_tile = tilemap_get_at_pixel(map_id, big_x, big_y);
	
	//gets surrounding tiles
	var up_tile = tilemap_get_at_pixel(map_id, big_x, big_y + tile_size);
	var down_tile = tilemap_get_at_pixel(map_id, big_x, big_y - tile_size);
	var left_tile = tilemap_get_at_pixel(map_id, big_x - tile_size, big_y);
	var right_tile = tilemap_get_at_pixel(map_id, big_x + tile_size, big_y);
	
	//checks surrounding tiles to only allow expansion of surrounding tiles
	if(up_tile == 0 || down_tile == 0 || left_tile == 0 || right_tile == 0){
	//removes 2x2 tile if not empty, -1 is to keep within total 2x2 box
		if(clicked_tile != 0 && !Obj_Sell.hovering) {
				if(global.gold > 0) {
					//global.gold--;
					tilemap_set_at_pixel(map_id, 0, big_x, big_y);
					tilemap_set_at_pixel(map_id, 0, big_x + tile_size - 1, big_y);
					tilemap_set_at_pixel(map_id, 0, big_x, big_y + tile_size - 1);
					tilemap_set_at_pixel(map_id, 0, big_x + tile_size - 1, big_y + tile_size - 1);
				}
		}
	
	}
	

}
	
	