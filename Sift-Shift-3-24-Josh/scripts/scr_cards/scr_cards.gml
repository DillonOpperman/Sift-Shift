function get_cards() { return 
	[
	 
		{
			sprite : spr_icon_phaser,
			sprite_scale : 0.6,
			name : "Phaser",
			dps : 1,
			description : "+3 Click Power",
			onkill : false,
			onappear : false,
			onclick : false,
			stat_buff : true,
			stat_type : "click_base",
			stat_value : 3,
			func : function(){ }
		}, 
		{
			sprite : spr_icon_sonic,
			sprite_scale : 0.4,
			name : "Sonic Driver",
			dps : 20,
			description : "50% Gold on click",
			onkill : false,
			onappear : false,
			onclick : true,
			stat_buff : false,
			stat_type : "",
			stat_value : 0,
			func : function(){ if(irandom(100) < 20) { global.save.bank += 7; audio_play_sound(snd_gold, 0, 0); }}
		},
		{
			sprite : spr_icon_blaster,
			sprite_scale : 0.5,
			name : "Blaster",
			dps : 400,
			description : "40% Gold Chance on kill",
			onkill : true,
			onappear : false,
			onclick : false,
			stat_buff : false,
			stat_type : "",
			stat_value : 0,
			func : function(){ if(irandom(100) < 40) { global.save.bank += obj_enemy.gold / 10; }}
		}, 
		{
			sprite : spr_icon_blowtorch,
			sprite_scale : 0.5,
			name : "Blowtorch",
			dps : 3500,
			description : "30% Fire Chance on click",
			onkill : false,
			onappear : false,
			onclick : true,
			stat_buff : false,
			stat_type : "",
			stat_value : 0,
			func : function(){ if(irandom(100) < 30) { with(obj_enemy) onfire = true; }}
		}, 
		{
			sprite : spr_icon_chemical_pink,
			sprite_scale : 0.4,
			name : "Chemical D",
			dps : 195000,
			description : "40% Crit Chance",
			onkill : false,
			onappear : false,
			onclick : false,
			stat_buff : true,
			stat_type : "crit_base",
			stat_value : 40,
			func : function(){ }
		}, 
		{
			sprite : spr_icon_chemical_purple,
			sprite_scale : 0.4,
			name : "Chemical N",
			dps : 1800000,
			description : "30% Augment Chance",
			onkill : false,
			onappear : false,
			onclick : false,
			stat_buff : true,
			stat_type : "augment_base",
			stat_value : 30,
			func : function(){ }
		}, 
		{
			sprite : spr_icon_blaster_laser,
			sprite_scale : 0.5,
			name : "Laser",
			dps : 2000000,
			description : "15% 1/2 HP Chance on spawn",
			onkill : false,
			onappear : true,
			onclick : false,
			stat_buff : false,
			stat_type : "",
			stat_value : 0,
			func : function(){ if(irandom(100) < 15) { with(obj_enemy) hp = max_hp / 2; }}
		}, 
		{
			sprite : spr_icon_plasma,
			sprite_scale : 0.5,
			name : "Plasma Sword",
			dps : 20000000,
			description : "30% chance x2 DPS on kill",
			onkill : true,
			onappear : false,
			onclick : false,
			stat_buff : false,
			stat_type : "",
			stat_value : 0,
			func : function(){ if(irandom(100) < 30) { obj_game_manager.double_dps = true; }}
		}
	]
}

function accumulate_stats(stat_name)
{
	var base_name = stat_name + "_base";
	var mult_name = stat_name + "_mult";
	
	// Check for a crit
	var stat_amount = 0;
	
	// Check with each card to see if it increases the base amount of damage a click on the enemy does
	with(obj_card) 
	{
		// The card must be unlocked to give the buff
		if(flipped) 
		{
			// Check if it's a stat buff and the correct type of buff
			if(stat_buff && stat_type == base_name) 
			{
				stat_amount += stat_value;
			}
		}
	}

	// Check with each card to see if it increases the base amount of damage a click on the enemy does
	with(obj_card) 
	{
		// The card must be unlocked to give the buff
		if(flipped) 
		{
			// Check if it's a stat buff and the correct type of buff
			if(stat_buff && stat_type == mult_name) 
			{
				stat_amount *= stat_value;
			}
		}
	}
	
	return stat_amount
}