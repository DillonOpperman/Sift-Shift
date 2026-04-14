if (is_paused) {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    // 1. CAPTURE & DRAW FROZEN BACKGROUND
    if (!surface_exists(pause_surface)) {
        pause_surface = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
        surface_set_target(pause_surface);
        draw_surface(application_surface, 0, 0);
        surface_reset_target();
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
    draw_set_color(make_color_rgb(25, 25, 25)); 
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    
    // Draw Border
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
    
    draw_line_width(_x1 + 40, _y1 + 70, _x2 - 40, _y1 + 70, 2);

  // 5. DRAW CURRENT MENU OPTIONS
for (var i = 0; i < array_length(current_menu); i++) {
    var _y_pos = (_gui_h / 2 - 80) + (i * 55); // Increased spacing slightly for icons
    var _color = (i == menu_index) ? c_yellow : c_white;
    draw_set_color(_color);
    draw_set_valign(fa_middle); // CRITICAL: Centers text vertically with the icon

    // 5a. DRAW THE ICON
    if (menu_state == "main" && i < array_length(menu_icons_main)) {
        var _icon_x = _gui_w / 2 - 110; // Adjust this number to move icons left/right
        
        // Draw icon scaled to a consistent size (40x40ish) so they don't look random
        var _scale = 1.0;
        if (sprite_get_width(menu_icons_main[i]) > 64) _scale = 0.5; // Shrink huge sprites
        
        draw_sprite_ext(menu_icons_main[i], 0, _icon_x, _y_pos, _scale, _scale, 0, _color, 1);
    }

    // 5b. DRAW THE TEXT
    draw_set_halign(fa_center);
    if (i == menu_index) {
        // Selection Highlight Box
        draw_set_alpha(0.2);
        draw_rectangle(_x1 + 20, _y_pos - 20, _x2 - 20, _y_pos + 20, false);
        draw_set_alpha(1.0);
        
        draw_text(_gui_w / 2, _y_pos, "> " + current_menu[i] + " <");
    } else {
        draw_text(_gui_w / 2, _y_pos, current_menu[i]);
    }
}
draw_set_valign(fa_top); // Reset for other UI elements

    // 6. CURRENCY / STATS DISPLAY
    draw_set_color(c_ltgray);
    draw_set_halign(fa_right);
    draw_text(_x2 - 20, _y2 - 20, "Balance: $" + string(global.money));
    
    // 7. RESET DRAW SETTINGS
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}