var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// 1. POSITIONING MATH
var _total_w = (array_length(options_names) * (slot_size + spacing)) - spacing;
var _start_x = (_gui_w / 2) - (_total_w / 2);
var _y_pos = _gui_h - 140; 

// 2. DRAW LOOP
for (var i = 0; i < array_length(options_names); i++) {
    var _x_pos = _start_x + (i * (slot_size + spacing));
    
    // Draw Slot Background
    draw_set_alpha(0.8);
    draw_set_color((i == selected_index) ? c_yellow : make_color_rgb(35, 35, 35));
    draw_rectangle(_x_pos, _y_pos, _x_pos + slot_size, _y_pos + slot_size, false);
    
    // Draw Border
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_rectangle(_x_pos, _y_pos, _x_pos + slot_size, _y_pos + slot_size, true);
    
    // Draw Sprite Icon
    if (sprite_exists(options_sprites[i])) {
        draw_sprite_stretched(options_sprites[i], 0, _x_pos + 8, _y_pos + 8, slot_size - 16, slot_size - 16);
    }
    
    // Name Label
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text_transformed(_x_pos + (slot_size/2), _y_pos + slot_size + 5, options_names[i], 0.8, 0.8, 0);
    
    // Gold Cost
    draw_set_color(c_yellow);
    draw_text_transformed(_x_pos + (slot_size/2), _y_pos + slot_size + 22, "$" + string(costs[i]), 0.9, 0.9, 0);
}

// 3. SELECTION TEXT
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(20, _gui_h - 40, "Building: " + options_names[selected_index]);