// Set the text to display
text = "You reached 5 billion coins! Congratulations! You won!";

// Set the maximum width of the text on the screen
str_length = 600;

// Set the initial scale
image_xscale = 0.7;
image_yscale = 0.7;

// Set the target size of the text box
target_xscale = 4;
target_yscale = 2;

// Create variables to hold references to the buttons
menu_button = 0;
reset_button = 0;

// Set a flag to say the box is not fully open yet
open = false;

// Sound cue for the popup;
audio_play_sound(snd_popup, 0, false);