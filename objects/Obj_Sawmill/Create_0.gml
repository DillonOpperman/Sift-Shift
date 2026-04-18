// Sawmill specific data
building_name = "Sawmill";
produces      = "Wood Planks";
consumes      = "Raw Logs";
description   = "Processes raw timber into high-quality planks for construction.";

// Production timing
spawn_interval = game_get_speed(gamespeed_fps) * 4; // 4 seconds
spawn_timer    = 0;