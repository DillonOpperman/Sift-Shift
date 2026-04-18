menu_index          = 0;
game_active         = false;
pause_surface       = -1;
notify_timer        = 0;
notify_text         = "";
_pending_load_slot  = -1;
 
// Settings
if (!variable_global_exists("music_on")) global.music_on = true;
ini_open("settings.ini");
global.music_on = ini_read_real("Audio", "Music", 1) > 0;
var _fs = ini_read_real("Display", "Fullscreen", 1) > 0;
ini_close();
window_set_fullscreen(_fs);
 
// Resource safety net
if (!variable_global_exists("money"))  global.money  = 100;
if (!variable_global_exists("copper")) global.copper = 0;
if (!variable_global_exists("iron"))   global.iron   = 0;
if (!variable_global_exists("tin"))    global.tin    = 0;
if (!variable_global_exists("bronze")) global.bronze = 0;
if (!variable_global_exists("silver")) global.silver = 0;
if (!variable_global_exists("gold"))   global.gold   = 0;
 
// Decide state based on _menu_action
if (!variable_global_exists("_menu_action")) global._menu_action = "title";
 
var _action = global._menu_action;
global._menu_action = "title";   // reset for next time
 
switch (_action) {
    case "new_game":
        menu_state  = "none";
        game_active = true;
        show_debug_message("obj_pause: NEW GAME");
        break;
 
    case "exit_menu":
    case "title":
    default:
        menu_state  = "title";
        game_active = false;
        alarm[0] = 1;   // freeze the world in 1 frame
        show_debug_message("obj_pause: TITLE SCREEN");
        break;
}

	// Start the music loop if the player hasn't muted it
	if (global.music_on) {
	    audio_play_sound(snd_main_theme, 10, true);
}
 