if place_meeting(x-1,y,O_Miner) {
	input = instance_position(x-1, y, all);
}

if (instance_exists(input)){
	input.copperOre--
	copperOre++
}

if place_meeting(x+1,y,O_Warehouse) {
	output = instance_position(x+1, y, all);
}

if (instance_exists(output)){
	copperOre--
	output._copperOre++
}