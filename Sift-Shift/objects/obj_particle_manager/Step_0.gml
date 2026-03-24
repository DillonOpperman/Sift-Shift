// If the player has earned more coins since last frame, trigger an effect
if(global.save.bank != prev_coins && global.save.bank != 0) 
{
	// The effect should happen over the coin so trigger it there
	with(obj_bank) 
	{
		part_particles_burst(other.particle_system, x, y, ps_gold);
	}
	
	// Save the new amount of coins
	prev_coins = global.save.bank
}