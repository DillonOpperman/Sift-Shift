// Resume the game
resume_everything();
instance_activate_object(obj_button_options);

global.paused = false;

surface_free(global.paused_surf);

// Destroy the buttons
instance_destroy(menu_button);
instance_destroy(reset_button);

// Delete the save file
if(file_exists("idle.sav")) {
	file_delete("idle.sav");
}