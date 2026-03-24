// Only save the enemy if the enemy is not dead
if (!global.paused && hp > 0)
{
	global.save.enemy_hp[global.save.enemy_diff] = hp;
	global.save.enemy_augments[global.save.enemy_diff] = augment;
}

// Destroy related instances and particle systems
instance_destroy(name_plate);
instance_destroy(health_bar);
instance_destroy(gold_indicator);
part_system_destroy(particle);