function src_pause(){
	
	function pause_everything() {
	with(obj_particle_manager) {
		if(instance_exists(obj_enemy)) {
			part_system_automatic_update(obj_enemy.particle, false);
		}
		part_system_automatic_update(particle_system, false);
		part_system_automatic_draw(particle_system, false);
	}
		
	instance_deactivate_layer("UI_Interactible");
	instance_deactivate_layer("UI_Background");
	instance_deactivate_layer("Enemy");
}

function resume_everything() {
	instance_activate_layer("UI_Interactible");
	instance_activate_layer("UI_Background");
	instance_activate_layer("Enemy");
	
	with(obj_particle_manager) {
		if(instance_exists(obj_enemy)) {
			part_system_automatic_update(obj_enemy.particle, true);
		}
	
		part_system_automatic_draw(particle_system, true);
		part_system_automatic_update(particle_system, true);
	}
}

}