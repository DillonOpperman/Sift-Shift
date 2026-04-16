spawn_timer ++;
hovering = position_meeting(mouse_x, mouse_y, self)

if(spawn_timer >= spawn_interval) {
	spawn_timer = 0;
	
	if(ingot_object != noone){
		var sx = x;
		var sy = y - tile;
		
		if (instance_place(sx, sy, ingot_object) == noone) {
			if(item_type == 14){
				if(global.copper > 0 && global.tin > 0){
					global.copper--
					global.tin--
					var it = instance_create_layer(sx, sy, "In_Resources", ingot_object);
					it.vx = 0;
					it.vy = 0;
				}
			} else if (item_type == 0) {
				//do nothing
			} else {
				if(current_fuel > 0){
					if(item_type == 11){
						global.copper--	
					}
					if(item_type == 12){
						global.iron--	
					}
					if(item_type == 13){
						global.tin--	
					}
					if(item_type == 15){
						global.silver--	
					}
					var it = instance_create_layer(sx, sy, "In_Resources", ingot_object);
					it.vx = 0;
					it.vy = 0;
				}
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
	if (item_type == 15){
		item_type = 0
	} else if (item_type == 0){
		item_type = 11
	} else {
		item_type++
	}
}

switch(item_type) {
	case 11: current_ingot = Spr_CopperIngot; current_fuel = global.copper; ingot_object = Obj_CopperIngot; break;
	case 12: current_ingot = Spr_IronIngot; current_fuel = global.iron; ingot_object = Obj_IronIngot; break;
	case 13: current_ingot = Spr_TinIngot; current_fuel = global.tin; ingot_object = Obj_TinIngot; break;
	case 14: current_ingot = Spr_BronzeIngot; current_fuel = global.bronze; ingot_object = Obj_BronzeIngot; break;
	case 15: current_ingot = Spr_SilverIngot; current_fuel = global.silver; ingot_object = Obj_SilverIngot; break;
	case 0: current_ingot = Spr_Inactive;
}