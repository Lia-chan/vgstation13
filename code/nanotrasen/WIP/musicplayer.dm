// this toggle doesn't save across rounds
/*
/mob/verb/musictoggle()
	set name = "Music Toggle"
	if(src.be_music == 0)
		src.be_music = 1
		src << "\blue Music toggled on!"
		return
	src.be_music = 0
	src << "\blue Music toggled off!"
*/
// TODO: check A.[c]key
// This checks a var on each area and plays that var
/area/proc/playmusic(mob/A as mob, var/area/B)
	if (A && ismob(A))
		if (A.client && (A.client.prefs.toggles & SOUND_MIDI) && B.music != "" && (A.music_lastplayed != B.music))
			A.music_lastplayed = B.music
			A << sound(B.music, repeat = 0, wait = 0, volume = 20, channel = 775)
