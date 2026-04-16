hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)

if (hovering && mouse_check_button_pressed(mb_left)) 
{
	clicked = true
} 

if (mouse_check_button_released(mb_left)) 
{
	clicked = false;
	if (hovering) 
	{
		global.gold += 
		(global.copper*1) + 
		(global.iron*2) + 
		(global.tin*2) + 
		(global.silver*4) + 
		(global.copperIngot*2) + 
		(global.ironIngot*4) + 
		(global.tinIngot*4) + 
		(global.bronzeIngot*6) + 
		(global.silverIngot*8) + 
		(global.copperTools*6) + 
		(global.ironTools*12) + 
		(global.bronzeTools*18) + 
		(global.timber*1) + 
		(global.lumber*2);
		
		global.copper = 0;
		global.iron = 0;
		global.tin = 0;
		global.bronze = 0;
		global.silver = 0;
		global.copperIngot = 0;
		global.ironIngot = 0;
		global.tinIngot = 0;
		global.bronzeIngot = 0;
		global.silverIngot = 0;
		global.timber = 0;
		global.lumber = 0;
		global.copperTools = 0;
		global.ironTools = 0;
		global.bronzeTools = 0;
	}
	
} 

if (clicked) 
{
	image_index = 2;
} 
else if (hovering) 
{
	image_index = 1;
} 
else 
{
	image_index = 0;
} 