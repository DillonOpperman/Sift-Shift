// 1. Toggle Pause with Escape
if (keyboard_check_pressed(vk_escape)) {
    is_paused = !is_paused;

    if (is_paused) {
        instance_deactivate_all(true);
        menu_index = 0; // Reset menu to top
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
    
    // Navigation
    var _move = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
    if (_move != 0) {
        menu_index += _move;
        if (menu_index < 0) menu_index = _count - 1;
        if (menu_index >= _count) menu_index = 0;
    }

    // Selection Logic
    if (keyboard_check_pressed(vk_enter)) {
        if (menu_state == "main") {
            switch(menu_index) {
                case 0: is_paused = false; instance_activate_all(); break; // Resume
                case 1: menu_state = "settings"; current_menu = menu_options_settings; menu_index = 0; break;
                case 2: menu_state = "controls"; current_menu = menu_options_controls; menu_index = 0; break;
                case 3: game_end(); break;
				case 4: save_game(); break; // New Save Button
				case 5: load_game(); is_paused = false; instance_activate_all(); break; // New Load Button
            }
        } 
else if (menu_state == "settings") {
    switch(menu_index) {
        case 0: // Toggle Fullscreen
            window_set_fullscreen(!window_get_fullscreen());
            menu_options_settings[0] = window_get_fullscreen() ? "Fullscreen: On" : "Fullscreen: Off";
            break;
            
        case 1: // Toggle Music
            global.music_on = !global.music_on;
            
            // Update the text in the menu array
            if (global.music_on) {
                menu_options_settings[1] = "Music: On";
                // audio_resume_sound(snd_background_music); // Resume if paused
            } else {
                menu_options_settings[1] = "Music: Off";
                audio_pause_all(); // Or audio_stop_sound(snd_background_music);
            }
            break;

        case 3: // Back
            menu_state = "main"; 
            current_menu = menu_options_main; 
            menu_index = 1; 
            break;
    }
}
        else if (menu_state == "controls") {
            if (menu_index == 3) { // Back button
                menu_state = "main"; current_menu = menu_options_main; menu_index = 2;
            }
        }
    }
}