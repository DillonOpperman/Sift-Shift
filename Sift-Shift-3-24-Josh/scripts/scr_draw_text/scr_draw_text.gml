function align_string(str, length) {
	var new_str = "";
	
	for(var i = 1; i < string_length(str) + 1; i++) {
		new_str += string_char_at(str, i);
		
		if(string_width(new_str) > length) {
			while(string_char_at(new_str, i) != " ") {
				new_str = string_delete(new_str, i, 1);
				i--;
			}
			new_str = string_delete(new_str, i, 1);
			new_str += "\n";
		}
	}
	
	return new_str;
}

function draw_text_line(font, str, tx, ty, xscale, yscale, length) {
	draw_set_font(font);
	
	var new_str = align_string(str, length);
	
	draw_text_transformed(tx, ty, new_str, xscale, yscale, 0);
}

function shorten_num(num) {
	var new_str = "";
	
	if(num >= 1000000000) {
		new_str = string(floor(num / 1000000000))
		if(floor((num % 1000000000) / 100000000) != 0) {
			new_str += "." + string(floor((num % 1000000000) / 100000000));
		}
		new_str += "B";
	}
	else if(num >= 1000000) {
		new_str = string(floor(num / 1000000))
		if(floor((num % 1000000) / 100000) != 0) {
			new_str += "." + string(floor((num % 1000000) / 100000));
		}
		new_str += "M";
	}
	else if(num >= 1000) {
		new_str = string(floor(num / 1000));
		if(floor((num % 1000) / 100) != 0) {
			new_str += "." + string(floor((num % 1000) / 100));
		}
		new_str += "K";
	} else {
		new_str = string(num);
	}
	
	return new_str;
}

function draw_num(tx, ty, xscale, yscale, font, num) {
	draw_set_font(font);
	
	var new_str = shorten_num(num);
	
	draw_text_transformed(tx, ty, new_str, xscale, yscale, 0);
}