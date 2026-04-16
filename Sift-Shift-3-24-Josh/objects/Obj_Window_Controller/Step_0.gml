//end the game if the escape key is pressed
if keyboard_check(vk_escape){
	game_end()	
}

//check if the WASD keys are pressed and change the coordinate for the viewport
if keyboard_check(ord("W")){
	view_y -= 5
}
if keyboard_check(ord("A")){
	view_x -= 5
}
if keyboard_check(ord("S")){
	view_y += 5
}
if keyboard_check(ord("D")){
	view_x += 5
}

//apply the new coordinates
camera_set_view_pos(view_get_camera(0),view_x,view_y)

//check if the mouse wheel is moving up or down and change the coordinate for the camera
if(mouse_wheel_up()){
	if(cam_height >=180 || cam_width >= 320){
		cam_height -= 18
		cam_width -= 32
	}
}
if(mouse_wheel_down()){
	cam_height += 18
	cam_width += 32
}

//apply the new coordinates
camera_set_view_size(view_get_camera(0),cam_width,cam_height)