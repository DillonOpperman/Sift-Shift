is_paused = false;
pause_surface = -1;

// Menu States: "main", "settings", "controls"
menu_state = "main"; 

menu_index = 0;
menu_options_main = ["Resume", "Settings", "Controls", "Quit"];
menu_options_settings = ["Fullscreen: Off", "Music: 100%", "SFX: 100%", "Back"];
menu_options_controls = ["LMB: Place Object", "RMB: Remove Object", "WASD: Pan Camera", "Back"];

// This variable will point to whichever array we are currently using
current_menu = menu_options_main;

global.money = 100;