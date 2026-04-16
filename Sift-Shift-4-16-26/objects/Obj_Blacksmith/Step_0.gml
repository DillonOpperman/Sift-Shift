spawn_timer ++;
hovering = position_meeting(mouse_x, mouse_y, self)

if(spawn_timer >= spawn_interval) {
	spawn_timer = 0;
	
	if(tool_object != noone){
		var sx = x;
		var sy = y - tile;
		
		if (instance_place(sx, sy, tool_object) == noone) {
			if(current_fuel > 0){
			current_fuel--
			var it = instance_create_layer(sx, sy, "In_Resources", tool_object);
			it.vx = 0;
			it.vy = 0;
			}
		}
	}
}



if(hovering){
	icon_alpha = 1
} else {
	icon_alpha = 0
}

if (mouse_check_button_pressed(mb_right) && position_meeting(mouse_x, mouse_y, self)){
	if (item_type == 28){
		item_type = 26
	} else {
		item_type++
	}
}

switch(item_type) {
	case 26: current_tool = Spr_CopperTools; current_fuel = global.copperIngot; tool_object = Obj_CopperTools; break;
	case 27: current_tool = Spr_IronTools; current_fuel = global.ironIngot; tool_object = Obj_IronTools; break;
	case 28: current_tool = Spr_BronzeTools; current_fuel = global.bronzeIngot; tool_object = Obj_BronzeTools; break;
}