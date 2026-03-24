// Reposition the particle system to be in line with the enemy's feet
part_system_position(particle, x, y + sprite_height / 2);

// Reposition the eyes per the sprite
switch(global.save.enemy_diff)
{
	case 0:
	case 3:
	case 6:
		part_system_position(left_eye_ps, x + 64 * image_xscale, y - 3 * image_yscale);
		part_system_position(right_eye_ps, x + 114 * image_xscale, y);
		break;
	case 1:
	case 4:
	case 7:
		part_system_position(left_eye_ps, x - 7 * image_xscale, y - 125 * image_yscale);
		part_system_position(right_eye_ps, x + 68 * image_xscale, y - 120 * image_yscale);
		break;
	case 2:
	case 5:
	case 8:
		part_system_position(left_eye_ps, x - 17 * image_xscale, y - 117 * image_yscale);
		part_system_position(right_eye_ps, x + 56 * image_xscale, y - 109 * image_yscale);
		break;
}

// Find the position vector between where the enemy was instantiated and the current position
var x_diff = x - xstart;
var y_diff = y - ystart;

// With all associated instances, move them 20% of the same movement vector and match the transparency
with(health_bar) 
{
	x = xstart + x_diff * 0.2;
	image_alpha = other.image_alpha;
}

with(name_plate) 
{
	x = xstart + x_diff * 0.2;
	image_alpha = other.image_alpha;
}

with(gold_indicator) 
{
	x = xstart + x_diff * 0.2;
	image_alpha = other.image_alpha;
}

// If the enemy is on fire
if(onfire) 
{
	if(fire_timer == 0 && fire_ticks == 0)
	{
		audio_play_sound(snd_fire, 0, false);
		part_particles_burst(obj_particle_manager.particle_system, x + random_range(-sprite_width / 4, sprite_width / 4), y + random_range(-sprite_height / 4, sprite_height / 4), ps_fire);
	}
	
	// Increase the timer for the fire
	fire_timer += delta_time / 1000000;
	
	// Every 0.2 seconds, damage the enemy proportional to the current dps amount and increment the fire ticks
	if(fire_timer >= 0.2) 
	{
		hp = floor(hp - global.dps / 3);
		fire_timer -= 0.2;
		fire_ticks++;
	}
	
	// If there have been 6 fire ticks, extinguish the fire
	if(fire_ticks >= 6) 
	{
		onfire = false;
		fire_ticks = 0;
		fire_timer = 0;
	}
}

// Set the hp to the maximum value between it and 0
hp = max(hp, 0);

// If the hp has reached 0, "kill" the enemy with user event 1
if(hp <= 0) {
	// Spark the enemy a bit
	repeat(5) part_particles_burst(obj_particle_manager.particle_system, x + irandom_range(-100, 100), y + irandom_range(-100, 100), ps_spark_damage);
	part_particles_burst(obj_particle_manager.particle_system, room_width / 2 - 80, 735, ps_health_end);
	
	global.save.enemy_num[global.save.enemy_diff]++;
	
	event_perform(ev_other, ev_user1);
}