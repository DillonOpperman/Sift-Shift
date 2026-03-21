spawn_timer ++;

if(spawn_timer >= spawn_interval) {
	spawn_timer = 0;
	
	var sx = x;
	var sy = y - 32;
	
	var it = instance_create_layer(sx, sy, "Instances_Items", Obj_Iron);
	
	it.vx = 0;
	it.vy = 0;
}
