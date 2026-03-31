// Set that the tutorial should close
close = true;

// Find the width and height of the target window
var win_width = target_window[2] - target_window[0];
var win_height = target_window[3] - target_window[1];

// Find the center of that window
var center = [0, 0];
center[0] = window[0] + win_width / 2;
center[1] = window[1] + win_height / 2;

// Find the width and height of the bracket sprite
var bracket_width = sprite_get_width(spr_brackets);
var bracket_height = sprite_get_height(spr_brackets);
		
// Set the target window to 2/5 of its current size
target_window[0] = target_window[0] + 2 * win_width / 5;
target_window[1] = target_window[1] + 2 * win_height / 5;
target_window[2] = target_window[2] - 2 * win_width / 5;
target_window[3] = target_window[3] - 2 * win_height / 5;

// Make sure the target window isn't so small it would make the bracket sprite's 9-slicing break
target_window[0] = min(target_window[0], center[0] - bracket_width / 2);
target_window[1] = min(target_window[1], center[1] - bracket_height / 2);
target_window[2] = max(target_window[2], center[0] + bracket_width / 2);
target_window[3] = max(target_window[3], center[1] + bracket_height / 2);

// Sound cue for the popup;
audio_play_sound(snd_popup, 0, false, 1, 0, 0.6);