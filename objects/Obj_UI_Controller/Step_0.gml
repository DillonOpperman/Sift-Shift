global._mouse_over_inv = inv_open;
 
// Skip everything if pause/title menu is showing
var _menu_blocking = false;
with (obj_pause) {
    if (menu_state != "none") _menu_blocking = true;
}
if (_menu_blocking) {
    if (inv_error_timer > 0) inv_error_timer--;
    exit;
}
 
// ── KEYBOARD FACILITY SHORTCUTS (only when NO input focused) ─
if (inv_focus == -1) {
    switch (keyboard_lastchar) {
        case "1": Obj_Build_Controller.facility = 1; break;
        case "2": Obj_Build_Controller.facility = 2; break;
        case "3": Obj_Build_Controller.facility = 3; break;
        case "4": Obj_Build_Controller.facility = 4; break;
        case "5": Obj_Build_Controller.facility = 5; break;
        case "6": Obj_Build_Controller.facility = 6; break;
        case "7": Obj_Build_Controller.facility = 7; break;
    }
}
 
// ── TAB TOGGLE ──────────────────────────────────────────────
if (keyboard_check_pressed(vk_tab)) {
    inv_open = !inv_open;
    if (!inv_open) {
        inv_scroll        = 0;
        inv_scroll_target = 0;
        inv_focus         = -1;
    }
    global._mouse_over_inv = inv_open;
}
 
// Block input during menu transitions (load / resume)
var _guard_active = (variable_global_exists("_input_guard") && global._input_guard > 0);
 
// Error pop-up countdown
if (inv_error_timer > 0) inv_error_timer--;
 
// ── SMOOTH SCROLL (lerp toward target) ──────────────────────
if (variable_instance_exists(id, "inv_scroll_target")) {
    inv_scroll += (inv_scroll_target - inv_scroll) * 0.3;
    // Snap when close enough
    if (abs(inv_scroll_target - inv_scroll) < 0.5) {
        inv_scroll = inv_scroll_target;
    }
}
 
// ── PANEL INTERACTIONS (only when open) ────────────────────
if (inv_open) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
 
    // Panel rect (must match Draw_64)
    var _tab_x = 10;
    var _tab_y = 10;
    var _tab_w = 200;
    var _tab_h = 34;
    var _panel_r = [
        _tab_x,
        _tab_y,
        _tab_x + 380,
        _tab_y + _tab_h + 4 + 320
    ];
    var _over_panel = (_mx >= _panel_r[0] && _mx <= _panel_r[2]
                    && _my >= _panel_r[1] && _my <= _panel_r[3]);
 
    // Mouse wheel scrolling (target-based for smoothness)
    if (!_guard_active) {
        if (mouse_wheel_up())   inv_scroll_target -= 24;
        if (mouse_wheel_down()) inv_scroll_target += 24;
        inv_scroll_target = clamp(inv_scroll_target, 0, inv_scroll_max);
    }
 
    // ── CLICK HANDLING ──────────────────────────────────────
    if (!_guard_active && mouse_check_button_pressed(mb_left)) {
        var _clicked_something = false;
 
        // Check input box clicks (focus that box)
        for (var i = 0; i < array_length(input_rects); i++) {
            var _entry = input_rects[i];
            var _r = _entry.rect;
            if (_mx >= _r[0] && _mx <= _r[2] && _my >= _r[1] && _my <= _r[3]) {
                inv_focus = _entry.item_index;
                _clicked_something = true;
                break;
            }
        }
 
        // Check sell button clicks
        if (!_clicked_something) {
            for (var i = 0; i < array_length(sell_rects); i++) {
                var _entry = sell_rects[i];
                var _r = _entry.rect;
                if (_mx >= _r[0] && _mx <= _r[2] && _my >= _r[1] && _my <= _r[3]) {
                    _clicked_something = true;
                    _do_sell(_entry.item_index);
                    break;
                }
            }
        }
 
        // Click inside panel but not on a button, clear focus
        if (!_clicked_something && _over_panel) {
            inv_focus = -1;
        }
    }
 
    // ── KEYBOARD INPUT (when a text box is focused) ─────────
    if (inv_focus >= 0 && inv_focus < array_length(inv_input)) {
        // Digit keys (0-9)
        for (var d = 0; d <= 9; d++) {
            if (keyboard_check_pressed(ord(string(d)))) {
                var _cur = inv_input[inv_focus];
                if (string_length(_cur) < 5) {
                    if (_cur == "0") {
                        if (d != 0) inv_input[inv_focus] = string(d);
                    } else {
                        inv_input[inv_focus] = _cur + string(d);
                    }
                }
            }
        }
 
        // Numpad digits
        for (var d = 0; d <= 9; d++) {
            if (keyboard_check_pressed(vk_numpad0 + d)) {
                var _cur = inv_input[inv_focus];
                if (string_length(_cur) < 5) {
                    if (_cur == "0") {
                        if (d != 0) inv_input[inv_focus] = string(d);
                    } else {
                        inv_input[inv_focus] = _cur + string(d);
                    }
                }
            }
        }
 
        // Backspace
        if (keyboard_check_pressed(vk_backspace)) {
            var _cur = inv_input[inv_focus];
            if (string_length(_cur) > 1) {
                inv_input[inv_focus] = string_copy(_cur, 1, string_length(_cur) - 1);
            } else {
                inv_input[inv_focus] = "0";
            }
        }
 
        // Enter → execute sell
        if (keyboard_check_pressed(vk_enter)) {
            _do_sell(inv_focus);
        }
 
        // Escape → unfocus
        if (keyboard_check_pressed(vk_escape)) {
            inv_focus = -1;
        }
    }
}
 
 
/// ─── SELL FUNCTION (instance-scoped) ───────────────────────
function _do_sell(_idx) {
    var _item  = inv_items[_idx];
    var _qty_s = inv_input[_idx];
    var _qty   = real(_qty_s);
 
    if (_qty <= 0) {
        inv_error_timer = 120;
        inv_error_text  = "Enter an amount to sell";
        return;
    }
 
    var _have = variable_global_exists(_item.key) ? variable_global_get(_item.key) : 0;
 
    if (_qty > _have) {
        inv_error_timer = 120;
        inv_error_text  = "Not enough " + _item.name + "! (have " + string(_have) + ")";
        return;
    }
 
    // Execute the sale
    variable_global_set(_item.key, _have - _qty);
    global.gold += _qty * _item.sell_price;
 
    // Reset input to "1"
    inv_input[_idx] = "1";
}


// --- Inside Step Event ---
global.hovering_building = noone;

// Only look for buildings if the menu is CLOSED
if (!inv_open) {
    var _mx = mouse_x;
    var _my = mouse_y;
    
    // Safety check: Does the object even exist in the asset browser?
    if (object_exists(obj_building_parent)) {
        global.hovering_building = instance_position(_mx, _my, obj_building_parent);
    }
}



if (global.hovering_building != noone) show_debug_message("I SEE A BUILDING!");
 
 
 
 