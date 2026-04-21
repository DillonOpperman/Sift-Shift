// ── Input guard countdown ───────────
if (variable_global_exists("_input_guard") && global._input_guard > 0) {
    global._input_guard--;
}
 
// ── During active gameplay ───────────────────────────────────
if (menu_state == "none") {
 
    // Escape → open pause menu
    if (keyboard_check_pressed(vk_escape)) {
        if (surface_exists(pause_surface)) { surface_free(pause_surface); pause_surface = -1; }
        pause_surface = surface_create(
            surface_get_width(application_surface),
            surface_get_height(application_surface)
        );
        surface_set_target(pause_surface);
        draw_surface(application_surface, 0, 0);
        surface_reset_target();
 
        instance_deactivate_all(true);
        menu_state = "pause";
        menu_index = 0;
    }
 
    if (notify_timer > 0) notify_timer--;
    exit;
}
 
// MENU INPUT (shared by all states)
 
var _btn_count = 0;
switch (menu_state) {
    case "title":          _btn_count = 4; break;
    case "title_load":     _btn_count = SAVE_SLOT_COUNT + 1; break;
    case "title_settings": _btn_count = 4; break;
    case "title_delete":   _btn_count = SAVE_SLOT_COUNT + 1; break;
    case "pause":          _btn_count = 5; break;
    case "pause_save":     _btn_count = SAVE_SLOT_COUNT + 1; break;
    case "pause_settings": _btn_count = 3; break;
    case "pause_controls": _btn_count = 1; break;
}
 
// Keyboard navigation
var _move = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
if (_move != 0) {
    menu_index += _move;
    if (menu_index < 0)          menu_index = _btn_count - 1;
    if (menu_index >= _btn_count) menu_index = 0;
}
 
// Mouse hover
if (variable_instance_exists(id, "btn_rects") && is_array(btn_rects)) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    for (var i = 0; i < array_length(btn_rects); i++) {
        var _r = btn_rects[i];
        if (_mx >= _r[0] && _mx <= _r[2] && _my >= _r[1] && _my <= _r[3]) {
            if (menu_index != i) menu_index = i;
            break;
        }
    }
}
 
// Selection (Enter or left-click on highlighted button)
var _selected = keyboard_check_pressed(vk_enter);
if (!_selected && mouse_check_button_pressed(mb_left)) {
    if (variable_instance_exists(id, "btn_rects") && is_array(btn_rects)
        && menu_index >= 0 && menu_index < array_length(btn_rects)) {
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);
        var _r  = btn_rects[menu_index];
        if (_mx >= _r[0] && _mx <= _r[2] && _my >= _r[1] && _my <= _r[3]) {
            _selected = true;
        }
    }
}
 
var _back = keyboard_check_pressed(vk_escape);
 

// STATE-SPECIFIC ACTIONS

// ─── TITLE SCREEN ────────────────────────────────────────────
if (menu_state == "title") {
    if (_selected) {
        switch (menu_index) {
            case 0:  // New Game → room_goto resets tiles + buildings
                reset_game_state();
                global._menu_action = "new_game";
                room_goto(Room1);
                break;
 
            case 1:  // Load Game → show slot picker
                menu_state = "title_load";
                menu_index = 0;
                break;
 
            case 2:  // Settings
                menu_state = "title_settings";
                menu_index = 0;
                break;
 
            case 3:  // Quit
                game_end();
                break;
        }
    }
}
 
// ─── TITLE → LOAD SLOTS ─────────────────────────────────────
else if (menu_state == "title_load") {
    if (_back) { menu_state = "title"; menu_index = 1; }
    else if (_selected) {
        if (menu_index < SAVE_SLOT_COUNT) {
            var _slot = menu_index + 1;
            if (save_exists(_slot)) {
                // Delay load by 1 frame so the mouse click clears
                // before game objects run their Step events
                _pending_load_slot = _slot;
                alarm[1] = 1;
            }
        } else {
            menu_state = "title";
            menu_index = 1;
        }
    }
}
 
// ─── TITLE → SETTINGS ───────────────────────────────────────
else if (menu_state == "title_settings") {
    if (_back) { menu_state = "title"; menu_index = 2; }
    else if (_selected) {
        switch (menu_index) {
            case 0:
                window_set_fullscreen(!window_get_fullscreen());
                ini_open("settings.ini");
                ini_write_real("Display", "Fullscreen", window_get_fullscreen());
                ini_close();
                break;
            case 1:
                global.music_on = !global.music_on;
                if (!global.music_on) audio_pause_all(); else audio_resume_all();
                ini_open("settings.ini");
                ini_write_real("Audio", "Music", global.music_on);
                ini_close();
                break;
            case 2:  // Delete Saves → open slot picker
                menu_state = "title_delete";
                menu_index = 0;
                break;
            case 3:  // Back
                menu_state = "title"; menu_index = 2;
                break;
        }
    }
}
 
// ─── TITLE → DELETE SAVES ───────────────────────────────────
else if (menu_state == "title_delete") {
    if (_back) { menu_state = "title_settings"; menu_index = 2; }
    else if (_selected) {
        if (menu_index < SAVE_SLOT_COUNT) {
            var _slot = menu_index + 1;
            if (save_exists(_slot)) {
                save_delete(_slot);
                notify_timer = 180;
                notify_text  = "Deleted Slot " + string(_slot);
            } else {
                notify_timer = 120;
                notify_text  = "Slot " + string(_slot) + " is empty";
            }
        } else {
            // Back
            menu_state = "title_settings"; menu_index = 2;
        }
    }
}
 
// ─── PAUSE MENU ──────────────────────────────────────────────
else if (menu_state == "pause") {
    if (_back) {
        global._input_guard = 5;
        instance_activate_all();
        menu_state = "none"; menu_index = 0;
        if (surface_exists(pause_surface)) { surface_free(pause_surface); pause_surface = -1; }
    }
    else if (_selected) {
        switch (menu_index) {
            case 0:  // Resume
                global._input_guard = 5;
                instance_activate_all();
                menu_state = "none"; menu_index = 0;
                if (surface_exists(pause_surface)) { surface_free(pause_surface); pause_surface = -1; }
                break;
            case 1:  // Save Game
                menu_state = "pause_save"; menu_index = 0;
                break;
            case 2:  // Settings
                menu_state = "pause_settings"; menu_index = 0;
                break;
            case 3:  // Controls
                menu_state = "pause_controls"; menu_index = 0;
                break;
            case 4:  // Exit to Menu
                global._menu_action = "exit_menu";
                room_goto(Room1);
                break;
        }
    }
}
 
// ─── PAUSE → SAVE SLOTS ─────────────────────────────────────
else if (menu_state == "pause_save") {
    if (_back) { menu_state = "pause"; menu_index = 1; }
    else if (_selected) {
        if (menu_index < SAVE_SLOT_COUNT) {
            var _slot = menu_index + 1;
            save_game(_slot);
            notify_timer = 180;
            notify_text  = "Saved to Slot " + string(_slot);
            menu_state = "pause"; menu_index = 1;
        } else {
            menu_state = "pause"; menu_index = 1;
        }
    }
}
 
// ─── PAUSE → SETTINGS ───────────────────────────────────────
else if (menu_state == "pause_settings") {
    if (_back) { menu_state = "pause"; menu_index = 2; }
    else if (_selected) {
        switch (menu_index) {
            case 0:
                window_set_fullscreen(!window_get_fullscreen());
                ini_open("settings.ini");
                ini_write_real("Display", "Fullscreen", window_get_fullscreen());
                ini_close();
                break;
			case 1: // Music Toggle in Title Settings
			    global.music_on = !global.music_on;
			    if (global.music_on) {
			        if (!audio_is_playing(snd_main_theme)) audio_play_sound(snd_main_theme, 10, true);
			    } else {
			        audio_stop_sound(snd_main_theme);
			    }
			    ini_open("settings.ini");
			    ini_write_real("Audio", "Music", global.music_on);
			    ini_close();
			    break;
            case 2:
                menu_state = "pause"; menu_index = 2;
                break;
        }
    }
}
 
// ─── PAUSE → CONTROLS ───────────────────────────────────────
else if (menu_state == "pause_controls") {
    if (_back || _selected) {
        menu_state = "pause"; menu_index = 3;
    }
}