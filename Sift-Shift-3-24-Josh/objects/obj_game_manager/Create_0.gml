// Create a space to hold all important variables that can be saved to the disk
// bank :				the amount of gold the player has
// enemy_num:			how many of each enemy the player has killed
// enemy_hp:			how much hp each enemy currently has
// enemy_augments:		the augment each enemy has
// enemy_diff:			the current enemy difficulty on display
global.save = {
	bank : 0,
	enemy_num : [-1, 0, 0, 0, 0, 0, 0, 0, 0],
	enemy_hp : [0, 0, 0, 0, 0, 0, 0, 0, 0],
	enemy_augments : ["", "", "", "", "", "", "", "", ""],
	enemy_diff : 0,
}

// Create a space to store the amount of damage the cards add up to
global.dps = 0;

// Create a flag to show whether the game has been won yet
global.won = false;

// Create a flag to show whether the game is paused
global.paused = false;

// Create a space to store a surface to display while the game is paused
global.paused_surf = -1;

// Store how much time has passed since the last time the enemy took damage
damage_timer = 0;

// Create variables to represent periods where the enemy should take double damage
double_timer = 0;
double_dps = false;

// Seed the random numbers
randomise();

// Enable font effects
font_enable_effects(fnt_HUD, true, {
	dropShadowEnable: true,
    dropShadowSoftness: 0,
    dropShadowOffsetX: 4,
    dropShadowOffsetY: 4,
	dropShadowColour: c_black,
    dropShadowAlpha: 0.6
});
font_enable_effects(fnt_enemy, true, {
	dropShadowEnable: true,
    dropShadowSoftness: 0,
    dropShadowOffsetX: 3,
    dropShadowOffsetY: 3,
	dropShadowColour: c_black,
    dropShadowAlpha: 0.6
});
font_enable_effects(fnt_card_name, true, {
	outlineEnable: true,
	outlineDistance: 2,
	outlineColour: c_black
});
font_enable_effects(Fnt_UI, true, {
	outlineEnable: true,
	outlineDistance: 2,
	outlineColour: c_black
});

// Create arrays to store the effects that trigger when the player clicks on an enemy, kills an enemy, and spawns a new enemy
onclick_methods = [];
onkill_methods = [];
onappear_methods = [];

// Function to trigger all on-click effects
function on_click() {
	for(var i = 0; i < array_length(onclick_methods); i++) {
		method_call(onclick_methods[i], []);
	}
}

// Function to trigger all on-kill effects
function on_kill() {
	for(var i = 0; i < array_length(onkill_methods); i++) {
		method_call(onkill_methods[i], []);
	}
}

// Function to trigger all on-appear effects
function on_appear() {
	for(var i = 0; i < array_length(onappear_methods); i++) {
		method_call(onappear_methods[i], []);
	}
}