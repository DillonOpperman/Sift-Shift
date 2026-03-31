// Make sure the user didn't click on another button
if(!collision_point(mouse_x, mouse_y, obj_button_parent, true, false)) {
	// Go to the next room
	room_goto_next();
}