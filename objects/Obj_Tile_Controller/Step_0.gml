// gets x and y and snaps it to the 32x32 grid
var mx = mouse_x div tile_size;
var my = mouse_y div tile_size;
 
hover_x = mx * tile_size;
hover_y = my * tile_size;
 
// ── INPUT GUARD: skip click processing after load/resume ────
if (variable_global_exists("_input_guard") && global._input_guard > 0) {
    exit;
}
 
// ── INVENTORY OPEN: skip clicks while inventory panel is up ──
if (variable_global_exists("_mouse_over_inv") && global._mouse_over_inv) {
    exit;
}
 
// when mouse is clicked on question tiles it removes them
if (mouse_check_button_pressed(mb_left)) {
    // gets the id of buyable layer
    var layer_id = layer_get_id("Tiles_Buyable");
    // gets the tile map ID of that layer
    var map_id = layer_tilemap_get_id(layer_id);
 
    // finds top left of box mouse is in
    var big_x = (mouse_x div 32) * 32;
    var big_y = (mouse_y div 32) * 32;
 
    // gets tile at mouse position
    var clicked_tile = tilemap_get_at_pixel(map_id, big_x, big_y);
 
    // removes 2x2 tile if not empty, -1 is to keep within total 2x2 box
    if (clicked_tile != 0) {
        if (global.copper > 0) {
            global.copper--;
            tilemap_set_at_pixel(map_id, 0, big_x, big_y);
            tilemap_set_at_pixel(map_id, 0, big_x + tile_size - 1, big_y);
            tilemap_set_at_pixel(map_id, 0, big_x, big_y + tile_size - 1);
            tilemap_set_at_pixel(map_id, 0, big_x + tile_size - 1, big_y + tile_size - 1);
        }
    }
}
 