if (is_paused) {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    // 1. CAPTURE & DRAW FROZEN BACKGROUND
    // This creates the "screenshot" effect so the game stays frozen behind the menu
    if (!surface_exists(pause_surface)) {
        pause_surface = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
        surface_copy(pause_surface, 0, 0, application_surface);
    }
    draw_surface_stretched(pause_surface, 0, 0, _gui_w, _gui_h);

    // 2. DIM THE SCREEN
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    
    // 3. DRAW THE MENU PANEL
    var _box_w = 360;
    var _box_h = 500;
    var _x1 = _gui_w/2 - _box_w/2;
    var _y1 = _gui_h/2 - _box_h/2;
    var _x2 = _gui_w/2 + _box_w/2;
    var _y2 = _gui_h/2 + _box_h/2;

    // Draw Dark Background Box
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(25, 25, 25)); // Deep grey/black
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    
    // Draw Border (Matches Sift/Shift grid style)
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_rectangle(_x1, _y1, _x2, _y2, true);

    // 4. DYNAMIC HEADER
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var _header_text = "PAUSED";
    if (menu_state == "settings") _header_text = "SETTINGS";
    if (menu_state == "controls") _header_text = "CONTROLS";

    // Header Shadow
    draw_set_color(c_black);
    draw_text_transformed(_gui_w/2 + 2, _y1 + 42, _header_text, 1.5, 1.5, 0);
    // Header Main
    draw_set_color(c_white);
    draw_text_transformed(_gui_w/2, _y1 + 40, _header_text, 1.5, 1.5, 0);
    
    // Decorative line under header
    draw_line_width(_x1 + 40, _y1 + 70, _x2 - 40, _y1 + 70, 2);

    // 5. DRAW CURRENT MENU OPTIONS
    for (var i = 0; i < array_length(current_menu); i++) {
        var _y_pos = (_gui_h / 2 - 20) + (i * 45); // Vertical spacing
        
        if (i == menu_index) {
            // Highlight Bar
            draw_set_alpha(0.2);
            draw_set_color(c_yellow);
            draw_rectangle(_x1 + 10, _y_pos - 18, _x2 - 10, _y_pos + 18, false);
            
            // Highlighted Text
            draw_set_alpha(1.0);
            draw_set_color(c_yellow);
            draw_text(_gui_w / 2, _y_pos, "> " + current_menu[i] + " <");
        } else {
            // Normal Text
            draw_set_alpha(1.0);
            draw_set_color(c_white);
            draw_text(_gui_w / 2, _y_pos, current_menu[i]);
        }
    }

    // 6. CURRENCY / STATS DISPLAY (Bottom of box)
    draw_set_color(c_ltgray);
    draw_set_halign(fa_right);
    draw_text(_x2 - 20, _y2 - 20, "Balance: $" + string(global.money));
    
    // 7. RESET DRAW SETTINGS (Good practice!)
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}