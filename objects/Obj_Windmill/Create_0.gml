// Windmill specific data
building_name = "Windmill";
produces      = "Mechanical Power / Flour";
consumes      = "Wind / Raw Grain";
description   = "Harnesses the wind to provide power to nearby machines or grind agricultural products.";

// Production timing
spawn_interval = game_get_speed(gamespeed_fps) * 6; 
spawn_timer    = 0;