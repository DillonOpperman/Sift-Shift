var it = instance_place(x, y, Obj_Ore_Controller);

image_index = dir;

if (it != noone) {
	switch (dir) {
		case 0: it.vx += push; break;
		case 1: it.vy -= push; break;
		case 2: it.vx -= push; break;
		case 3: it.vy += push; break;
	}
}

if (mouse_check_button_pressed(mb_right) && position_meeting(mouse_x, mouse_y, self)){
	if (dir == 3){
		dir = 0
	} else {
		dir++
	}
}
