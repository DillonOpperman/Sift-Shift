if (menu_state == "none") {
    if (notify_timer > 0) {
        _draw_notify();
        notify_timer--;
    }
    exit;
}
 
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
 
// ═════════════════════════════════════════════════════════════
// 1. BACKGROUND
// ═════════════════════════════════════════════════════════════
 
if (menu_state == "title" || menu_state == "title_load" || menu_state == "title_settings" || menu_state == "title_delete") {
    // Title screens: solid dark background (game isn't "running" visually)
    draw_set_color(make_color_rgb(18, 18, 22));
    draw_set_alpha(1);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
} else {
    // Pause screens: frozen game + dim overlay
    if (surface_exists(pause_surface)) {
        draw_set_alpha(1);
        draw_surface_stretched(pause_surface, 0, 0, _gui_w, _gui_h);
    }
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
}
 
// ═════════════════════════════════════════════════════════════
// 2. PANEL BOX
// ═════════════════════════════════════════════════════════════
 
var _box_w = 380;
var _box_h = 460;
var _x1 = _gui_w / 2 - _box_w / 2;
var _y1 = _gui_h / 2 - _box_h / 2;
var _x2 = _x1 + _box_w;
var _y2 = _y1 + _box_h;
 
// Panel fill
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(25, 25, 30));
draw_rectangle(_x1, _y1, _x2, _y2, false);
 
// Panel border
draw_set_alpha(1);
draw_set_color(make_color_rgb(180, 170, 150));
draw_rectangle(_x1, _y1, _x2, _y2, true);
draw_rectangle(_x1 + 1, _y1 + 1, _x2 - 1, _y2 - 1, true);  // double border
 
// ═════════════════════════════════════════════════════════════
// 3. HEADER
// ═════════════════════════════════════════════════════════════
 
draw_set_font(Fnt_UI);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
 
var _header = "";
switch (menu_state) {
    case "title":          _header = "SIFT / SHIFT";  break;
    case "title_load":     _header = "LOAD GAME";     break;
    case "title_settings": _header = "SETTINGS";      break;
    case "title_delete":   _header = "DELETE SAVES";   break;
    case "pause":          _header = "PAUSED";         break;
    case "pause_save":     _header = "SAVE GAME";      break;
    case "pause_load":     _header = "LOAD GAME";      break;
    case "pause_settings": _header = "SETTINGS";       break;
    case "pause_controls": _header = "CONTROLS";       break;
}
 
// Shadow
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_text_transformed(_gui_w / 2 + 2, _y1 + 42, _header, 1.5, 1.5, 0);
// Main
draw_set_alpha(1);
draw_set_color(make_color_rgb(230, 220, 190));
draw_text_transformed(_gui_w / 2, _y1 + 40, _header, 1.5, 1.5, 0);
 
// Divider line
draw_set_color(make_color_rgb(180, 170, 150));
draw_line_width(_x1 + 30, _y1 + 68, _x2 - 30, _y1 + 68, 1);
 
 
// ═════════════════════════════════════════════════════════════
// 4. MENU BUTTONS — drawn per state
// ═════════════════════════════════════════════════════════════
 
// Reset btn_rects for mouse detection in Step
btn_rects = [];
 
var _btn_w = 280;
var _btn_h = 42;
var _gap   = 12;
var _start_y = _y1 + 95;
var _cx = _gui_w / 2;
 
 
// ─── TITLE SCREEN ────────────────────────────────────────────
if (menu_state == "title") {
    var _labels = ["NEW GAME", "LOAD GAME", "SETTINGS", "QUIT"];
    for (var i = 0; i < array_length(_labels); i++) {
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w, _btn_h, _labels[i], i == menu_index);
    }
}
 
// ─── TITLE → LOAD SLOTS ─────────────────────────────────────
else if (menu_state == "title_load") {
    for (var i = 0; i < SAVE_SLOT_COUNT; i++) {
        var _info  = save_get_info(i + 1);
        var _label = "Slot " + string(i + 1);
        if (_info != undefined) {
            _label += "  —  " + _info.timestamp;
        } else {
            _label += "  —  Empty";
        }
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w + 40, _btn_h, _label, i == menu_index);
    }
    // Back button
    var _back_y = _start_y + SAVE_SLOT_COUNT * (_btn_h + _gap) + 10;
    _draw_menu_btn(_cx, _back_y, 160, _btn_h, "BACK", menu_index == SAVE_SLOT_COUNT);
}
 
// ─── TITLE SETTINGS (includes Delete Saves) ─────────────────
else if (menu_state == "title_settings") {
    var _fs_text    = window_get_fullscreen() ? "Fullscreen: ON" : "Fullscreen: OFF";
    var _music_text = global.music_on ? "Music: ON" : "Music: OFF";
    var _labels = [_fs_text, _music_text, "DELETE SAVES", "BACK"];
    for (var i = 0; i < array_length(_labels); i++) {
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w, _btn_h, _labels[i], i == menu_index);
    }
}
 
// ─── PAUSE SETTINGS (no delete option) ──────────────────────
else if (menu_state == "pause_settings") {
    var _fs_text    = window_get_fullscreen() ? "Fullscreen: ON" : "Fullscreen: OFF";
    var _music_text = global.music_on ? "Music: ON" : "Music: OFF";
    var _labels = [_fs_text, _music_text, "BACK"];
    for (var i = 0; i < array_length(_labels); i++) {
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w, _btn_h, _labels[i], i == menu_index);
    }
}
 
// ─── TITLE → DELETE SAVES ───────────────────────────────────
else if (menu_state == "title_delete") {
    for (var i = 0; i < SAVE_SLOT_COUNT; i++) {
        var _info  = save_get_info(i + 1);
        var _label = "Slot " + string(i + 1);
        if (_info != undefined) {
            _label += "  —  " + _info.timestamp + "  (click to delete)";
        } else {
            _label += "  —  Empty";
        }
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w + 40, _btn_h, _label, i == menu_index);
    }
    var _back_y = _start_y + SAVE_SLOT_COUNT * (_btn_h + _gap) + 10;
    _draw_menu_btn(_cx, _back_y, 160, _btn_h, "BACK", menu_index == SAVE_SLOT_COUNT);
}
 
// ─── PAUSE MENU ──────────────────────────────────────────────
else if (menu_state == "pause") {
    var _labels = ["RESUME", "SAVE GAME", "SETTINGS", "CONTROLS", "EXIT TO MENU"];
    for (var i = 0; i < array_length(_labels); i++) {
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w, _btn_h, _labels[i], i == menu_index);
    }
}
 
// ─── PAUSE → SAVE SLOTS ─────────────────────────────────────
else if (menu_state == "pause_save") {
    for (var i = 0; i < SAVE_SLOT_COUNT; i++) {
        var _info  = save_get_info(i + 1);
        var _label = "Slot " + string(i + 1);
        if (_info != undefined) {
            _label += "  —  " + _info.timestamp + " (overwrite)";
        } else {
            _label += "  —  Empty";
        }
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w + 40, _btn_h, _label, i == menu_index);
    }
    var _back_y = _start_y + SAVE_SLOT_COUNT * (_btn_h + _gap) + 10;
    _draw_menu_btn(_cx, _back_y, 160, _btn_h, "BACK", menu_index == SAVE_SLOT_COUNT);
}
 
// ─── PAUSE → LOAD SLOTS ─────────────────────────────────────
else if (menu_state == "pause_load") {
    for (var i = 0; i < SAVE_SLOT_COUNT; i++) {
        var _info  = save_get_info(i + 1);
        var _label = "Slot " + string(i + 1);
        if (_info != undefined) {
            _label += "  —  " + _info.timestamp;
        } else {
            _label += "  —  Empty";
        }
        _draw_menu_btn(_cx, _start_y + i * (_btn_h + _gap), _btn_w + 40, _btn_h, _label, i == menu_index);
    }
    var _back_y = _start_y + SAVE_SLOT_COUNT * (_btn_h + _gap) + 10;
    _draw_menu_btn(_cx, _back_y, 160, _btn_h, "BACK", menu_index == SAVE_SLOT_COUNT);
}
 
// ─── PAUSE → CONTROLS ───────────────────────────────────────
else if (menu_state == "pause_controls") {
    // Info lines (not buttons — just text)
    var _controls = [
        "LMB — Place Building",
        "RMB — Remove Building",
        "WASD — Pan Camera",
        "Scroll — Zoom",
        "1-7 — Select Facility",
        "ESC — Pause"
    ];
 
    draw_set_font(Fnt_UI);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(200, 195, 180));
 
    for (var i = 0; i < array_length(_controls); i++) {
        draw_text(_cx, _start_y + i * 32, _controls[i]);
    }
 
    // Back button below
    var _back_y = _start_y + array_length(_controls) * 32 + 20;
    _draw_menu_btn(_cx, _back_y, 160, _btn_h, "BACK", true);
}
 
 
// ═════════════════════════════════════════════════════════════
// 5. FOOTER — balance display (only on title & pause)
// ═════════════════════════════════════════════════════════════
if (menu_state == "title" || menu_state == "pause") {
    draw_set_font(Fnt_UI);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(140, 135, 120));
    if (game_active) {
        draw_text(_x2 - 16, _y2 - 10, "Gold: " + string(global.gold));
    }
}
 
// ═════════════════════════════════════════════════════════════
// 6. SAVE NOTIFICATION (overlaid on everything)
// ═════════════════════════════════════════════════════════════
if (notify_timer > 0) _draw_notify();
 
// ── Reset draw state ─────────────────────────────────────────
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
 
 
// ═════════════════════════════════════════════════════════════
// HELPER FUNCTIONS (instance-scoped)
// ═════════════════════════════════════════════════════════════
 
/// Draws a single menu button and registers its rect for mouse detection.
/// _cx, _cy = center position; _w, _h = dimensions
function _draw_menu_btn(_cx, _cy, _w, _h, _text, _highlighted) {
    var _bx1 = _cx - _w / 2;
    var _by1 = _cy - _h / 2;
    var _bx2 = _cx + _w / 2;
    var _by2 = _cy + _h / 2;
 
    // Register for mouse detection
    array_push(btn_rects, [_bx1, _by1, _bx2, _by2]);
 
    draw_set_font(Fnt_UI);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
 
    if (_highlighted) {
        // Highlighted: warm fill + bright border
        draw_set_alpha(0.35);
        draw_set_color(make_color_rgb(180, 160, 100));
        draw_rectangle(_bx1, _by1, _bx2, _by2, false);
 
        draw_set_alpha(1);
        draw_set_color(make_color_rgb(230, 210, 140));
        draw_rectangle(_bx1, _by1, _bx2, _by2, true);
 
        // Text
        draw_set_color(make_color_rgb(255, 245, 200));
        draw_text(_cx, _cy, _text);
    } else {
        // Normal: subtle fill + dim border
        draw_set_alpha(0.15);
        draw_set_color(make_color_rgb(100, 100, 100));
        draw_rectangle(_bx1, _by1, _bx2, _by2, false);
 
        draw_set_alpha(0.5);
        draw_set_color(make_color_rgb(120, 115, 105));
        draw_rectangle(_bx1, _by1, _bx2, _by2, true);
 
        // Text
        draw_set_alpha(1);
        draw_set_color(make_color_rgb(190, 185, 170));
        draw_text(_cx, _cy, _text);
    }
 
    draw_set_alpha(1);
}
 
/// Draws the save-notification banner at the top of the screen.
function _draw_notify() {
    var _gw    = display_get_gui_width();
    var _alpha = min(1, notify_timer / 60);
 
    draw_set_font(Fnt_UI);
    var _tw = string_width(notify_text) + 40;
    var _th = 30;
    var _nx = (_gw - _tw) / 2;
    var _ny = 14;
 
    draw_set_alpha(_alpha * 0.75);
    draw_set_color(c_black);
    draw_rectangle(_nx, _ny, _nx + _tw, _ny + _th, false);
 
    draw_set_alpha(_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(230, 220, 190));
    draw_text(_nx + _tw / 2, _ny + _th / 2, notify_text);
 
    draw_set_alpha(1);
}
 