// If there is a pause surface to draw
if(surface_exists(global.paused_surf)) {
	
	// Set the shader to the window shader
	shader_set(sh_draw_window);
	
	// Find the shader handles to set the window corners
	var win_handle = shader_get_uniform(sh_draw_window, "window");
	shader_set_uniform_f(win_handle, window[0], window[1], window[2], window[3]);
	var res_handle = shader_get_uniform(sh_draw_window, "resolution");
	shader_set_uniform_f(res_handle, room_width, room_height);
	
	// Draw the pause surface
	gpu_set_blendenable(false);
	draw_surface(global.paused_surf, 0, 0);
	gpu_set_blendenable(true);
	
	// Reset the shader
	shader_reset();
}

// Translate the pixel size of the window into a scale size for the brackets
var window_xscale = (window[2] - window[0] + 24) / sprite_get_width(spr_brackets);
var window_yscale = (window[3] - window[1] + 24) / sprite_get_height(spr_brackets);

// Draw the brackets - they are 9-sliced so the corners will line up
draw_sprite_ext(spr_brackets, 0, window[0] - 12, window[1] - 12, window_xscale, window_yscale, 0, c_white, 1);

// Set the text alignments
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Set the font
draw_set_font(fnt_HUD);

// Draw the text
draw_text(room_width / 2, 938, text);

// Reset the text alignments
draw_set_halign(fa_left);
draw_set_valign(fa_top);