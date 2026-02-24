if on == false
{
	image_index = 0
	if position_meeting(mouse_x, mouse_y, id)
	{
		image_index = 1	
	}
	if mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id){
		on = true
	}
} else {
	image_index = 2
	if position_meeting(mouse_x, mouse_y, id)
	{
		image_index = 3	
	}
	if mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id){
		on = false
	}
}