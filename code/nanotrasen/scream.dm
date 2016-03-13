/mob/living/carbon/human/proc/call_sound_emote(var/E)
	if(!ishuman(src)) return // Just in case..
	if(src.zombie)
		return //Zombies will not scream!
	if(src.sdisabilities & MUTE)
		return // Guess
	switch(E)
		if("scream")
			for(var/mob/M in viewers(usr, null))
				if (src.gender == "male")
					M << sound(pick('Screams_Male_1.ogg','Screams_Male_2.ogg','Screams_Male_3.ogg'))
				else
					M << sound(pick('Screams_Woman_1.ogg','Screams_Woman_2.ogg','Screams_Woman_3.ogg'))