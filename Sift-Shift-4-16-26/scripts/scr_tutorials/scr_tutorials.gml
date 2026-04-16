function spawn_tutorial(tut_setup)
{
	var tut = instance_create_layer(0, 0, "Popups", obj_tutorial);
	
	draw_set_font(Fnt_UI);
	
	with(tut) {
		text = tut_setup.text;
		target_window = tut_setup.target_window;
		
		var win_width = target_window[2] - target_window[0];
		var win_height = target_window[3] - target_window[1];
		
		var center = [0, 0];
		center[0] = target_window[0] + win_width / 2;
		center[1] = target_window[1] + win_height / 2;

		var bracket_width = sprite_get_width(spr_brackets);
		var bracket_height = sprite_get_height(spr_brackets);
		
		window[0] = target_window[0] + 2 * win_width / 5;
		window[1] = target_window[1] + 2 * win_height / 5;
		window[2] = target_window[2] - 2 * win_width / 5;
		window[3] = target_window[3] - 2 * win_height / 5;
		
		window[0] = min(window[0], center[0] - bracket_width / 2);
		window[1] = min(window[1], center[1] - bracket_height / 2);
		window[2] = max(window[2], center[0] + bracket_width / 2);
		window[3] = max(window[3], center[1] + bracket_height / 2);
		
		next_spawn_method = tut_setup.next_method;
	}
}

function spawn_tut_enemy() {
	var tut_setup = { 
		text : "Click the enemy to damage it\nDefeat enemies to earn gold",
		target_window : [700, 130, 1220, 770],
		next_method : spawn_tut_difficulty
	};
	 
	spawn_tutorial(tut_setup);
}

function spawn_tut_difficulty() {
	var tut_setup = { 
		text : "Use the arrows to switch enemy\nTougher enemies give greater rewards!",
		target_window : [590, 340, 1330, 480],
		next_method : spawn_tut_cards
	};
	 
	spawn_tutorial(tut_setup);
}

function spawn_tut_cards() {
	var tut_setup = { 
		text : "Use gold to unlock cards and increase your DPS\nand gain new abilities!",
		target_window : [100, 350, 476, 750],
		next_method : 0
	};
	 
	spawn_tutorial(tut_setup);
}