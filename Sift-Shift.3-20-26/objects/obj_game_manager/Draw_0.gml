// Draw the paused surface if the game is paused
if(global.paused) {
	// Turn off blending so the main game below doesn't show through
	gpu_set_blendenable(false)
	
	// Draw the paused surface
	draw_surface(global.paused_surf, 0, 0);
	
	// Turn blending back on
	gpu_set_blendenable(true);
	
	// Also draw a black rectangle over the screen to make popups more distinct
	draw_set_colour(c_black);
	draw_set_alpha(0.3);
	
	draw_rectangle(0, 0, room_width, room_height, false);
	
	draw_set_colour(c_white);
	draw_set_alpha(1);
}