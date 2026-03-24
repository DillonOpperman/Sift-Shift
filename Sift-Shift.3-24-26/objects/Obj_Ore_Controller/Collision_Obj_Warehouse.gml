switch (item_type) {
	case 4: global.iron++; break;
	case 524287: global.copper++; break;
	case 34: global.coal++; break;
}

instance_destroy();