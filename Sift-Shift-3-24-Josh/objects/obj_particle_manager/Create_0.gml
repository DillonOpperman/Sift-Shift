// Create a particle system for miscellaneous effects
particle_system = part_system_create_layer("UI_Interactible", false);

// Store the amount of coins on the previous frame
prev_coins = global.save.bank;

// Function to clear the particle system
function reset() {
	part_system_clear(particle_system);
}