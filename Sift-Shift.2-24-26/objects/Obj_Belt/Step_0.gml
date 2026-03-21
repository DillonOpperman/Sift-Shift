var it = instance_place(x, y, Obj_Iron);

if (it != noone) {
	switch (dir) {
		case 0: it.vx += push; break;
		case 1: it.vy -= push; break;
		case 2: it.vx -= push; break;
		case 3: it.vy += push; break;
	}
}

