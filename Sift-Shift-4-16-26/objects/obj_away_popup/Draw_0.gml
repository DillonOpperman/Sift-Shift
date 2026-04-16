// Extract the number of minutes from the amount of time since the last save
var mins = floor(time_since / 60);

// Extract the number of seconds remaining in that time
var secs = floor(time_since - mins * 60);

// Turn the number of minutes into hours
var hours = floor(mins / 60);
mins -= floor(hours * 60);

// Create a string with all the information
var text = string("You have been away for {0}:{1}:{2}!\nYou earned {3} gold!", (hours > 9 ? "" : "0") + string(hours), (mins > 9 ? "" : "0") + string(mins), (secs > 9 ? "" : "0") + string(secs), shorten_num(gold_earned));

// Align the text to the desired width
var str = align_string(text, 600);
		
// Set the scale so that it fits the text
image_xscale = (string_width(str) + 100) / sprite_get_width(sprite_index);
image_yscale = (string_height(str) + 100) / sprite_get_height(sprite_index);

// Draw the box
draw_self();

// Set text alignment
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Set the font and colour
draw_set_font(Fnt_UI);
draw_set_color(#eed8cd);

// Draw the text
draw_text(x, y, str);

// Reset the alignment
draw_set_valign(fa_top);
draw_set_halign(fa_left);

// Reset the colour
draw_set_colour(c_white);