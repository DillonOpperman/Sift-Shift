var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// Start X position to keep the bar centered
var _start_x = (_gui_w / 2) - (total_width / 2);
var _y_pos = _gui_h - 80;

for (var i = 0; i < array_length(options); i++) {
    var _x_pos = _start_x + (i * (slot_size + spacing));
    
    // 1. Draw Slot Background
    draw_set_alpha(0.8);
    draw_set_color( (i == selected_index) ? c_yellow : make_color_rgb(40, 40, 40) );
    draw_rectangle(_x_pos, _y_pos, _x_pos + slot_size, _y_pos + slot_size, false);
    
    // 2. Draw Border
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_rectangle(_x_pos, _y_pos, _x_pos + slot_size, _y_pos + slot_size, true);
   
		// 3. Draw Item Label (Smaller font or scale if needed)
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);

		// Draw text slightly smaller to fit in the box
		draw_text_transformed(_x_pos + (slot_size/2), _y_pos + (slot_size/2), options[i], 0.8, 0.8, 0);

		// 4. Draw Cost below (Move it down a bit further)
		draw_set_color(c_yellow);
		draw_text(_x_pos + (slot_size/2), _y_pos + slot_size + 20, "$" + string(costs[i]));;
}

// 5. Draw "Currently Building" info
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(20, _gui_h - 30, "Selected: " + options[selected_index]);