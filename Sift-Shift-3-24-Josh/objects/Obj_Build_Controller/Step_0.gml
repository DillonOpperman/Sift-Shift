//gets x and y and snaps it to the 32x32 grid
var mx = mouse_x div tile_size;
var my = mouse_y div tile_size;

hover_x = mx * tile_size;
hover_y = my * tile_size;

hovered_facility = instance_position(mouse_x, mouse_y, all)

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
	
	//removes 2x2 tile if not empty, -1 is to keep within total 2x2 box
	if(clicked_tile == 0 && !Obj_Sell.hovering) {
		if(global.gold > 0) {
			global.gold -= 1
			switch(facility){
				case 1: instance_create_layer(big_x,big_y,layer_get_id("In_Factory"),Obj_Belt); break;
				case 2: instance_create_layer(big_x,big_y,layer_get_id("In_Factory"),Obj_Mine); break;
				case 3: instance_create_layer(big_x,big_y,layer_get_id("In_Factory"),Obj_Smelter); break;
				case 4: instance_create_layer(big_x,big_y,layer_get_id("In_Factory"),Obj_Blacksmith); break;
				case 5: instance_create_layer(big_x,big_y,layer_get_id("In_Factory"),Obj_Sawmill); break;
				case 6: instance_create_layer(big_x,big_y,layer_get_id("In_Factory"),Obj_Windmill); break;
				case 7: instance_create_layer(big_x,big_y,layer_get_id("In_Factory"),Obj_Warehouse); break;
				case 8: instance_destroy(hovered_facility); break;
			}
			
		}
	}

}
	
	