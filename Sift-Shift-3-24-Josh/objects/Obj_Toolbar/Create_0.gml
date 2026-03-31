// 1. DATA SETUP - Matching Asset Browser exactly
// Note: GameMaker is case-sensitive!
options_sprites = [TravelRoadLR, MineIcon, WarehouseIcon, WagonIcon]; 
options_names = ["Road", "Mine", "Warehouse", "Wagon"];

// Prices based on your project goals
costs = [5, 50, 1000, 250]; 

selected_index = 0;

// 2. GUI SCALING FIX
// This ensures the toolbar stays the same size even when Ben's camera zooms out
display_set_gui_size(window_get_width(), window_get_height());

// 3. VISUAL SETTINGS
slot_size = 90; 
spacing = 15;
total_width = (array_length(options_names) * slot_size) + (array_length(options_names) * spacing);