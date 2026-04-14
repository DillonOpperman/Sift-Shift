is_paused = false;
pause_surface = -1;

// Menu States: "main", "settings", "controls"
menu_state = "main"; 

// Icon Mapping
menu_icons_main = [Spr_Resume, SettingsIcon, PlayerIcon, InventoryIcon, TimerIcon, Spr_Quit]; 

menu_index = 0;
menu_options_main = ["Resume", "Settings", "Controls", "Quit", "Save Game", "Load Game"];
menu_options_settings = ["Fullscreen: Off", "Music: On", "SFX: 100%", "Back"];
menu_options_controls = ["LMB: Place Object", "RMB: Remove Object", "WASD: Pan Camera", "Back"];

// This variable will point to whichever array we are currently using
current_menu = menu_options_main;

global.money = 100;
global.music_on = true;

// Load the saved preference on startup
ini_open("settings.ini");
global.music_on = ini_read_real("Audio", "Music", true);
ini_close();

// Sync the menu text to the loaded setting
menu_options_settings[1] = global.music_on ? "Music: On" : "Music: Off";