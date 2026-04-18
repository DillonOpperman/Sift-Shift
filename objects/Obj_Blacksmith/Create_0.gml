// Blacksmith specific data
building_name = "Blacksmith";
produces      = "Tools & Hardware";
consumes      = "Metal Ingots";
description   = "Forges refined metals into tools and equipment for your factory expansion.";

// Production timing
spawn_interval = game_get_speed(gamespeed_fps) * 5; // A bit slower than the smelter
spawn_timer    = 0;