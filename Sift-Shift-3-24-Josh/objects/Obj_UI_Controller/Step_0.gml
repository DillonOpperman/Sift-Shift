switch(keyboard_lastchar){
	case "1": Obj_Build_Controller.facility = 1; break;
	case "2": Obj_Build_Controller.facility = 2; break;
	case "3": Obj_Build_Controller.facility = 3; break;
	case "4": Obj_Build_Controller.facility = 4; break;
	case "5": Obj_Build_Controller.facility = 5; break;
	case "6": Obj_Build_Controller.facility = 6; break;
	case "7": Obj_Build_Controller.facility = 7; break;
	case "8": Obj_Build_Controller.facility = 8; break;	
}

if(keyboard_check(vk_tab)){
	inventory_alpha = 1	
} else {
	inventory_alpha = 0	
}