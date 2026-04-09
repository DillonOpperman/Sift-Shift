spawn_timer ++;

if(spawn_timer >= spawn_interval) {
	spawn_timer = 0;
	
	if(wood_object != noone){
		var sx = x;
		var sy = y - tile;
		
		if (instance_place(sx, sy, wood_object) == noone) {
			var it = instance_create_layer(sx, sy, "In_Resources", wood_object);
			it.vx = 0;
			it.vy = 0;
		}
	}
}
