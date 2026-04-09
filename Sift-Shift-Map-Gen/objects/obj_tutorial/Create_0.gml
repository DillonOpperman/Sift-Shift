// Create a variable to hold the text to display
text = "";

// Create a variable to hold the next function to spawn the next tutorial
next_spawn_method = function() {};

// Set the initial scaling of the text box
image_xscale = 0.7;
image_yscale = 0.7;

// Create a variable to store how large the text box should be
target_xscale = 1;
target_yscale = 1;

// Create flags to show whether the text box is opening or closing
open = false;
close = false;

// Create variables to store the current window corners and the target window corners
window = [0, 0, 0, 0];
target_window = [0, 0, 0, 0];

// Sound cue for the popup;
audio_play_sound(snd_popup, 0, false);