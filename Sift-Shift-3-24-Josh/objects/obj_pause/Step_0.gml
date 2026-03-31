// 1. Toggle Pause with Escape
if (keyboard_check_pressed(vk_escape)) {
    is_paused = !is_paused;

    if (is_paused) {
        instance_deactivate_all(true);
        menu_index = 0; // Reset menu to top
        menu_state = "main";
        current_menu = menu_options_main;
    } else {
        instance_activate_all();
        if (surface_exists(pause_surface)) {
            surface_free(pause_surface);
            pause_surface = -1;
        }
    }
}

if (is_paused) {
    var _count = array_length(current_menu);
    
    // 2. Navigation
    var _move = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
    if (_move != 0) {
        menu_index += _move;
        if (menu_index < 0) menu_index = _count - 1;
        if (menu_index >= _count) menu_index = 0;
    }

    // 3. Selection Logic
    if (keyboard_check_pressed(vk_enter)) {
        
        // --- MAIN MENU ---
        if (menu_state == "main") {
            switch(menu_index) {
                case 0: // Resume
                    is_paused = false; 
                    instance_activate_all(); 
                    break; 
                case 1: // Settings
                    menu_state = "settings"; 
                    current_menu = menu_options_settings; 
                    menu_index = 0; 
                    break;
                case 2: // Controls
                    menu_state = "controls"; 
                    current_menu = menu_options_controls; 
                    menu_index = 0; 
                    break;
                case 3: // Quit
                    game_end(); 
                    break;
                case 4: // Save Game
                    scr_save_game(); 
                    is_paused = false; 
                    instance_activate_all(); 
                    break; 
                case 5: // Load Game
                    scr_load_game(); 
                    is_paused = false; 
                    instance_activate_all(); 
                    break; 
            }
        } 
        
        // --- SETTINGS MENU ---
        else if (menu_state == "settings") {
            switch(menu_index) {
                case 0: // Toggle Fullscreen
                    window_set_fullscreen(!window_get_fullscreen());
                    menu_options_settings[0] = window_get_fullscreen() ? "Fullscreen: On" : "Fullscreen: Off";
                    break;
                    
                case 1: // Toggle Music
                    global.music_on = !global.music_on;
                    if (global.music_on) {
                        menu_options_settings[1] = "Music: On";
                    } else {
                        menu_options_settings[1] = "Music: Off";
                        audio_pause_all(); 
                    }
                    // Save preference immediately
                    ini_open("settings.ini");
                    ini_write_real("Audio", "Music", global.music_on);
                    ini_close();
                    break;

                case 3: // Back to Main
                    menu_state = "main"; 
                    current_menu = menu_options_main; 
                    menu_index = 1; 
                    break;
            }
        }
        
        // --- CONTROLS MENU ---
        else if (menu_state == "controls") {
            if (menu_index == 3) { // Back button
                menu_state = "main"; 
                current_menu = menu_options_main; 
                menu_index = 2;
            }
        }
    }
}