// Set the sprite according to the enemy difficulty
// The wasp sprites should be slightly smaller so set their scale
switch(global.save.enemy_diff) {
	case 0:
		sprite_index = Enemy1_Pink;
		image_xscale = 0.8;
		image_yscale = 0.8;
		break;
	case 1:
		sprite_index = Enemy2_Aqua;
		break;
	case 2:
		sprite_index = Enemy3_Blue;
		break;
	case 3:
		sprite_index = Enemy1_Red;
		image_xscale = 0.8;
		image_yscale = 0.8;
		break;
	case 4:
		sprite_index = Enemy2_Yellow;
		break;
	case 5:
		sprite_index = Enemy3_Green;
		break;
	case 6:
		sprite_index = Enemy1_Yellow;
		image_xscale = 0.8;
		image_yscale = 0.8;
		break;
	case 7:
		sprite_index = Enemy2_Green;
		break;
	case 8:
		sprite_index = Enemy3_Red;
		break;
}

// Set up an augment for the enemy
// This is dependent upon the card abilities unlocked
// Make a place to store the augment type
augment = "";

// Set out the augment types
var name_mods = [
	"Tough", 
	"Rich"
]

// Create a baseline amount that the enemy can be augmented
var augment_mod = accumulate_stats("augment")

// Create a place to store the enemy's name
name = "";

// If the enemy does not have a saved augment, only then assign it a new one
if(global.save.enemy_augments[global.save.enemy_diff] == "") 
{
	// Take the augment amount as a percentage chance to gain a random augment
	if(irandom(100) < augment_mod) 
	{
		augment = name_mods[irandom(array_length(name_mods) - 1)];
		name = augment + " ";
	} 
	else // If there is no augment, save it as such
	{
		augment = "NONE";
	}
} 
else  // Otherwise, remove the augment from the save and apply it here
{
	augment = global.save.enemy_augments[global.save.enemy_diff];
	global.save.enemy_augments[global.save.enemy_diff] = "";
	if(augment != "NONE") 
	{
		name += augment + " ";
	}
}

// Name the enemy based on the difficulty
switch(global.save.enemy_diff) {
	case 0:
		name += "Planetary Wasp";
		break;
	case 1:
		name += "Interstellar Ant";
		break;
	case 2:
		name += "Strange Beetle";
		break;
	case 3:
		name += "Advanced Wasp";
		break;
	case 4:
		name += "Lunar Ant";
		break;
	case 5:
		name += "Experimental Beetle";
		break;
	case 6:
		name += "Cosmic Wasp";
		break;
	case 7:
		name += "Stellar Ant";
		break;
	case 8:
		name += "Infinite Beetle";
		break;
}

// Place the eyes
left_eye_ps = part_system_create(ps_enemy_eyeglowing);
right_eye_ps = part_system_create(ps_enemy_eyeglowing);

part_system_automatic_draw(left_eye_ps, false);
part_system_automatic_draw(right_eye_ps, false);

// Create a name plate to store the enemy's name
name_plate = instance_create_layer(room_width / 2, 180, "UI_Interactible", obj_enemy_name);
name_plate.name = name;

// Set a place to store the enemy's maximum health
max_hp = 10;

// Enemies have different maximum health amounts depending on the enemy's difficulty
// At level 0, it starts at 5, moves up to at 1 per enemy defeated, and then that amount goes up by 1 each enemy past 6
if(global.save.enemy_diff == 0)
{
	var add = min(4, global.save.enemy_num[global.save.enemy_diff])
	var n = max(0, global.save.enemy_num[global.save.enemy_diff] - 4);
	
	var sum = (n * (n + 1)) / 2;
	
	max_hp = 5 + add + sum;
}
else
{
	// Regular enemies' hp goes up by 10 after the first enemy defeated and then that amount goes up by 1
	// For every difficulty past the initial, the increase is multiplied by 10
	if(global.save.enemy_num[global.save.enemy_diff] != 0)
	{
		// Build the sum of all numbers above and including 10 and the number of this enemy defeated to add to the hp
		var n = 9 + global.save.enemy_num[global.save.enemy_diff];
		var sum = (n * (n + 1)) / 2;
		sum -= 45;
		
		// Add 100 to reach the basic health level
		max_hp = 100 + sum;
		
		max_hp *= power(10, global.save.enemy_diff - 1);
	}
	else // However, we don't want to add anything if no enemies at this level have been defeated yet
	{
		max_hp = 100;
		
		max_hp *= power(10, global.save.enemy_diff - 1);
	}
}

// Set the current hp level to equal the max hp
hp = max_hp;

// If the enemy has been damaged at another time and its health has been saved, instead make that the current hp value
if(global.save.enemy_hp[global.save.enemy_diff] != 0) 
{
	hp = global.save.enemy_hp[global.save.enemy_diff];
	global.save.enemy_hp[global.save.enemy_diff] = 0;
}

// Create an instance to display the health
health_bar = instance_create_layer(x, y + 289, "UI_Interactible", obj_enemy_healthbar);
health_bar.enemy = self;

// Set out variables dictating fire
onfire = false;
fire_timer = 0;
fire_ticks = 0;

// Set out the amount of gold this enemy is worth when defeated
gold = 5;
gold *= power(10, global.save.enemy_diff);

// Enact the augment's effects on the enemy if it has one
switch(augment) {
	case "Tough" : // Tough means hp increases
		max_hp = round(max_hp * 1.5);
		break;
	case "Rich" : // Rich means double gold value
		gold *= 2;
		break;
}

// Create an instance to show how much gold this enemy is worth
gold_indicator = instance_create_layer(1248, 672, layer, obj_gold_indicator);
gold_indicator.enemy = self;

// Trigger any on-appear effects
obj_game_manager.on_appear();

// Create a particle system to give the enemy a powerful aura
particle = part_system_create(ps_character_idle);
part_system_position(particle, x, y + sprite_height / 2);
part_system_automatic_draw(particle, false);