switch (item_type) {
	case 1: global.copper++; break;
	case 2: global.iron++; break;
	case 3: global.tin++; break;
	case 4: global.bronze++; break;
	case 5: global.silver++; break;
	case 11: global.copperIngot++; break;
	case 12: global.ironIngot++; break;
	case 13: global.tinIngot++; break;
	case 14: global.bronzeIngot++; break;
	case 15: global.silverIngot++; break;
}

instance_destroy();