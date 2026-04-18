switch (item_type) {
	case 1: global.copper++; break;
	case 2: global.iron++; break;
	case 3: global.tin++; break;
	case 4: global.bronze++; break;
	case 5: global.silver++; break;
}

instance_destroy();