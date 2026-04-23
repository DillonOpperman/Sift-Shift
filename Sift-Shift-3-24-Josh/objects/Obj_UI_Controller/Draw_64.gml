draw_set_font(Fnt_UI);
draw_set_alpha(1);
 
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
 
// 1. INVENTORY STATUS LABEL (top-left — Tab key to open)

var _tab_x = 10;
var _tab_y = 10;
var _tab_w = 200;
var _tab_h = 34;
 
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
 
// Label fill
draw_set_alpha(inv_open ? 0.95 : 0.8);
draw_set_color(make_color_rgb(25, 25, 30));
draw_rectangle(_tab_x, _tab_y, _tab_x + _tab_w, _tab_y + _tab_h, false);
 
// Label border
draw_set_alpha(1);
draw_set_color(make_color_rgb(inv_open ? 230 : 180,
                              inv_open ? 210 : 170,
                              inv_open ? 140 : 150));
draw_rectangle(_tab_x, _tab_y, _tab_x + _tab_w, _tab_y + _tab_h, true);
 
// Label text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(inv_open ? 255 : 200,
                              inv_open ? 245 : 195,
                              inv_open ? 200 : 170));
draw_text((_tab_x * 2 + _tab_w) / 2, _tab_y + _tab_h / 2,
          inv_open ? "INVENTORY  [TAB]" : "INVENTORY  [TAB]");
 
// 2. INVENTORY PANEL (only when open)

if (inv_open) {
    var _pnl_x  = _tab_x;
    var _pnl_y  = _tab_y + _tab_h + 4;
    var _pnl_w  = 420;
    var _pnl_h  = 320;
    var _pnl_x2 = _pnl_x + _pnl_w;
    var _pnl_y2 = _pnl_y + _pnl_h;
 
    // Panel fill
    draw_set_alpha(0.94);
    draw_set_color(make_color_rgb(25, 25, 30));
    draw_rectangle(_pnl_x, _pnl_y, _pnl_x2, _pnl_y2, false);
 
    // Panel border (double)
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(180, 170, 150));
    draw_rectangle(_pnl_x, _pnl_y, _pnl_x2, _pnl_y2, true);
    draw_rectangle(_pnl_x + 1, _pnl_y + 1, _pnl_x2 - 1, _pnl_y2 - 1, true);
 
    // Header bar
    var _header_h = 32;
    draw_set_alpha(0.5);
    draw_set_color(make_color_rgb(40, 38, 35));
    draw_rectangle(_pnl_x + 2, _pnl_y + 2, _pnl_x2 - 2, _pnl_y + _header_h, false);
 
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(230, 220, 190));
    draw_text(_pnl_x + 14, _pnl_y + _header_h / 2 + 2, "RESOURCES");
 
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(140, 135, 120));
    draw_text(_pnl_x2 - 14, _pnl_y + _header_h / 2 + 2, "[TAB]");
 
    // ─── Scrollable item list ──────────────────────────────
    var _list_x  = _pnl_x + 6;
    var _list_y  = _pnl_y + _header_h + 4;
    var _list_x2 = _pnl_x2 - 6;
    var _list_y2 = _pnl_y2 - 6;
    var _list_h  = _list_y2 - _list_y;
 
    var _row_h   = 50;
    var _row_gap = 6;
    var _n       = array_length(inv_items);
    var _content_h = _n * (_row_h + _row_gap) - _row_gap;
 
    // Clamp scroll
    inv_scroll_max = max(0, _content_h - _list_h);
    inv_scroll     = clamp(inv_scroll, 0, inv_scroll_max);
 
    // Reset rects for Step hit-detection
    sell_rects  = [];
    input_rects = [];
 
    for (var i = 0; i < _n; i++) {
        var _ry  = _list_y + i * (_row_h + _row_gap) - inv_scroll;
        var _ry2 = _ry + _row_h;
 
        // Skip if completely outside visible list
        if (_ry2 < _list_y || _ry > _list_y2) continue;
 
        // Row background
        var _vis_top = max(_ry, _list_y);
        var _vis_bot = min(_ry2, _list_y2);
        if (_vis_bot - _vis_top < 4) continue;
 
        draw_set_alpha(0.2);
        draw_set_color(make_color_rgb(60, 55, 45));
        draw_rectangle(_list_x, _vis_top, _list_x2, _vis_bot, false);
        draw_set_alpha(0.4);
        draw_set_color(make_color_rgb(120, 110, 90));
        draw_rectangle(_list_x, _vis_top, _list_x2, _vis_bot, true);
 
        // ── Draw row contents (always, even if partially visible) ──
        var _item = inv_items[i];
        var _val  = variable_global_exists(_item.key) ? variable_global_get(_item.key) : 0;
        var _cy   = _ry + _row_h / 2;   // vertical center of row
 
        draw_set_alpha(1);
 
        // COUNT (left side, right-aligned number before the icon)
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(200, 195, 175));
        draw_text(_list_x + 36, _cy, string(_val));
 
        // ICON (after the count)
        draw_sprite_ext(_item.sprite, 0,
                        _list_x + 42, _cy - 14,
                        1, 1, 0, c_white, 1);
 
        // NAME (after the icon)
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(230, 220, 190));
        draw_text(_list_x + 80, _cy, _item.name);
 
        // PRICE (middle area, dimmer gold text)
        draw_set_color(make_color_rgb(180, 170, 100));
        draw_text(_list_x + 225, _cy, string(_item.sell_price) + "g ea.");
 
        // ── RIGHT SIDE: Input box + SELL button ─────────────
 
        // SELL button (rightmost)
        var _sell_w  = 52;
        var _sell_h  = 26;
        var _sell_x1 = _list_x2 - _sell_w - 6;
        var _sell_y1 = _cy - _sell_h / 2;
        var _sell_x2 = _sell_x1 + _sell_w;
        var _sell_y2 = _sell_y1 + _sell_h;
 
        var _sell_hover = (_mx >= _sell_x1 && _mx <= _sell_x2
                        && _my >= _sell_y1 && _my <= _sell_y2);
 
        array_push(sell_rects, {
            rect: [_sell_x1, _sell_y1, _sell_x2, _sell_y2],
            item_name: _item.name,
            item_index: i
        });
 
        // Sell fill
        draw_set_alpha(_sell_hover ? 0.5 : 0.25);
        draw_set_color(make_color_rgb(160, 140, 80));
        draw_rectangle(_sell_x1, _sell_y1, _sell_x2, _sell_y2, false);
        draw_set_alpha(1);
        draw_set_color(make_color_rgb(_sell_hover ? 230 : 180,
                                      _sell_hover ? 210 : 160,
                                      _sell_hover ? 140 : 110));
        draw_rectangle(_sell_x1, _sell_y1, _sell_x2, _sell_y2, true);
 
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(_sell_hover ? 255 : 220,
                                      _sell_hover ? 245 : 210,
                                      _sell_hover ? 200 : 170));
        draw_text((_sell_x1 + _sell_x2) / 2, (_sell_y1 + _sell_y2) / 2, "SELL");
 
        // Quantity input box (left of SELL button)
        var _inp_w  = 48;
        var _inp_h  = 26;
        var _inp_x1 = _sell_x1 - _inp_w - 4;
        var _inp_y1 = _cy - _inp_h / 2;
        var _inp_x2 = _inp_x1 + _inp_w;
        var _inp_y2 = _inp_y1 + _inp_h;
 
        var _is_focused = (inv_focus == i);
        var _inp_hover  = (_mx >= _inp_x1 && _mx <= _inp_x2
                        && _my >= _inp_y1 && _my <= _inp_y2);
 
        array_push(input_rects, {
            rect: [_inp_x1, _inp_y1, _inp_x2, _inp_y2],
            item_index: i
        });
 
        // Input box fill
        draw_set_alpha(_is_focused ? 0.5 : (_inp_hover ? 0.3 : 0.15));
        draw_set_color(make_color_rgb(50, 48, 40));
        draw_rectangle(_inp_x1, _inp_y1, _inp_x2, _inp_y2, false);
 
        // Input box border
        draw_set_alpha(1);
        if (_is_focused) {
            draw_set_color(make_color_rgb(230, 210, 140));
        } else if (_inp_hover) {
            draw_set_color(make_color_rgb(180, 170, 130));
        } else {
            draw_set_color(make_color_rgb(120, 115, 100));
        }
        draw_rectangle(_inp_x1, _inp_y1, _inp_x2, _inp_y2, true);
 
        // Input text + cursor
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(240, 235, 210));
        var _display_text = inv_input[i];
        if (_is_focused && ((current_time div 500) mod 2 == 0)) {
            _display_text += "|";
        }
        draw_text((_inp_x1 + _inp_x2) / 2, (_inp_y1 + _inp_y2) / 2, _display_text);
    }
 
    // Scroll indicator
    if (inv_scroll_max > 0) {
        var _sb_x1 = _pnl_x2 - 6;
        var _sb_x2 = _pnl_x2 - 3;
        var _sb_y1 = _list_y;
        var _sb_y2 = _list_y2;
        var _thumb_h = max(24, _list_h * (_list_h / _content_h));
        var _thumb_y = _sb_y1 + (_sb_y2 - _sb_y1 - _thumb_h)
                     * (inv_scroll / max(1, inv_scroll_max));
        draw_set_alpha(0.25);
        draw_set_color(make_color_rgb(180, 170, 150));
        draw_rectangle(_sb_x1, _sb_y1, _sb_x2, _sb_y2, false);
        draw_set_alpha(0.9);
        draw_rectangle(_sb_x1, _thumb_y, _sb_x2, _thumb_y + _thumb_h, false);
    }
}
 
// 3. ERROR POP-UP (centered, above everything)

if (inv_error_timer > 0) {
    var _alpha = min(1, inv_error_timer / 30);
 
    draw_set_font(Fnt_UI);
    var _tw = string_width(inv_error_text) + 48;
    var _th = 34;
    var _nx = (_gui_w - _tw) / 2;
    var _ny = _gui_h / 2 - _th / 2 - 40;
 
    draw_set_alpha(_alpha * 0.9);
    draw_set_color(make_color_rgb(50, 15, 15));
    draw_rectangle(_nx, _ny, _nx + _tw, _ny + _th, false);
 
    draw_set_alpha(_alpha);
    draw_set_color(make_color_rgb(200, 80, 80));
    draw_rectangle(_nx, _ny, _nx + _tw, _ny + _th, true);
    draw_rectangle(_nx + 1, _ny + 1, _nx + _tw - 1, _ny + _th - 1, true);
 
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 180, 180));
    draw_text(_nx + _tw / 2, _ny + _th / 2, inv_error_text);
}
 
// 4. GOLD / MONEY COUNTER (bottom-left, always visible)

draw_set_alpha(1);
draw_sprite_ext(Spr_Bar, -1, 0, 385, 6, 6, 0, c_white, 1);
draw_set_color(c_white);
draw_sprite_ext(Spr_GoldCoin, -1, 7, 707, 2, 2, 0, c_white, 1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext_transformed(75, 707, string(global.gold), 10, 300, 2, 2, 0);

// 5. FACILITY SELECTOR (bottom, always visible)

build_margin = 250;
facility_margin = 80;
draw_sprite_ext(Spr_BeltIcon_fake,       -1, build_margin + (facility_margin * 0), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_MineIcon_fake,       -1, build_margin + (facility_margin * 1), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_SmelterIcon_fake,    -1, build_margin + (facility_margin * 2), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_BlacksmithIcon_fake, -1, build_margin + (facility_margin * 3), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_SawmillIcon_fake,    -1, build_margin + (facility_margin * 4), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_TimbermillIcon_fake,   -1, build_margin + (facility_margin * 5), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_WarehouseIcon_fake,  -1, build_margin + (facility_margin * 6), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_Destroy,  -1, build_margin + (facility_margin * 7), 700, 2, 2, 0, c_white, 1);
draw_sprite_ext(Spr_BuildBorder, -1,
                build_margin + (facility_margin * (Obj_Build_Controller.facility - 1)),
                700, 2, 2, 0, c_white, 1);
 
 
 // --- BUILDING INSPECTOR (Right Side) ---
// --- Inside Draw GUI Event (At the bottom!) ---

if (global.hovering_building != noone) {
    var _inst = global.hovering_building;
    
    var _pnl_w = 500;
    var _pnl_h = 260;
    var _pnl_x1 = display_get_gui_width() - _pnl_w - 20;
    var _pnl_y1 = 120; 
    
    // Background box
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(30, 30, 35));
    draw_rectangle(_pnl_x1, _pnl_y1, _pnl_x1 + _pnl_w, _pnl_y1 + _pnl_h, false);
    
    // Border
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(180, 170, 150));
    draw_rectangle(_pnl_x1, _pnl_y1, _pnl_x1 + _pnl_w, _pnl_y1 + _pnl_h, true);
    
    // Text setup
    draw_set_font(Fnt_UI); // Make sure this font name matches your browser!
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // Title (Yellow)
    draw_set_color(c_yellow);
    draw_text_transformed(_pnl_x1 + 15, _pnl_y1 + 15, string(_inst.building_name), 1.2, 1.2, 0);
    
    // Description (White)
    draw_set_color(c_white);
    draw_text_ext(_pnl_x1 + 15, _pnl_y1 + 50, string(_inst.description), 20, _pnl_w - 30);
    
    // Production Stats
    draw_set_color(make_color_rgb(100, 255, 100));
    draw_text(_pnl_x1 + 15, _pnl_y1 + 130, "Produces: " + string(_inst.produces));
    
    draw_set_color(make_color_rgb(255, 100, 100));
    draw_text(_pnl_x1 + 15, _pnl_y1 + 155, "Consumes: " + string(_inst.consumes));
}

 
// ── Reset draw state ─────────────────────────────────────────
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);