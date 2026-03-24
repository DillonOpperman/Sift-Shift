// Create the spaces to save the time since the last save, the number of enemies killed, and the amount of gold earned in that time
time_since = 0;
enemies_killed = 0;
gold_earned = 0;

// Create a function to set the 3 important stats
function setup(time, enemies, gold) {
	time_since = time;
	enemies_killed = enemies;
	gold_earned = gold;
}

// Sound cue for the popup;
audio_play_sound(snd_popup, 0, false);