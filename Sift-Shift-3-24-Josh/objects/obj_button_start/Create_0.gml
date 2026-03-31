// Create a flag to say whether the button should be getting larger or smaller
mode = 0;

// Start the in game music
if(!audio_is_playing(snd_music))
{
	audio_play_sound(snd_music, 0, true);
}