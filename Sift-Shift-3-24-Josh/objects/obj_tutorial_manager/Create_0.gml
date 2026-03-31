// Find whether the game has already been run by checking if there's a save file already
tutorialed = file_exists("idle.sav");
first_run = true;

// Depending on whether the game has been run, either spawn all the cards and load the game, or spawn the tutorials
if(tutorialed) {
	with(obj_card_dock) {
		spawn_cards();
	}
	with(obj_save_manager) {
		load();
	}
} else {
	global.save.enemy_num[global.save.enemy_diff]++;
}

// Create an enemy
instance_create_layer(room_width / 2, 446, "Enemy", obj_enemy);