if obj_miner.on == true {
	move_and_collide(1,0,obj_warehouse)
	if place_meeting(x+1,y,obj_warehouse) {
		quantity++
		x = obj_miner.x
	}
}
