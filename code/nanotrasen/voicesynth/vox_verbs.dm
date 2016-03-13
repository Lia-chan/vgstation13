
/mob/living/silicon/ai/var/vox_silence_time = null

/mob/living/silicon/ai/proc/vox_play(var/E)
	if(!E) return
	if(!(E in vox_sounds)) return
	var/soundfile = vox_sounds[E]
	var/sound/snd = sound(soundfile)

	snd.volume = 88
	snd.repeat = 0
	snd.wait = 1
	snd.channel = 776 //TODO
//	usr << "playing [snd] as [E] at [soundfile]"
	world << snd // TODO: Change world to something other, like intercom hearers..

/mob/living/silicon/ai/verb/say_vox()
	set category = "AI Commands"
	set name = "Voice synthesis"

	var/mob/living/silicon/ai/user = usr

	if(user.vox_silence_time)
		if(world.timeofday >= user.vox_silence_time)
			user.vox_silence_time = null
		else
			user << "\red Please wait [user.vox_silence_time - world.timeofday] ticks while your voice module being reinitialized!"
			return

	var/voxstring = copytext(sanitize(input("VOX string(comma and period are delays):","VOX:", null) as text|null), 1, 128) // Limit message to 128 chars
	if(!voxstring) return

	if( user.vox_silence_time && ( world.timeofday < user.vox_silence_time ))
		user << "\red VOICE SYNTHESIS ERROR"
		message_admins("\red AI [user.name] is abusing voice synthesis!")
		return

	var/list/correct_words = new
	for(var/word in vox_split_words (voxstring))
		if (word in vox_sounds)
			correct_words += word
		else
			user << "\red Voice module error: no such word: '[word]'. Activation aborted."
			return

	if( !correct_words || correct_words.len < 1) return

	world << "\icon[user] [user.name] states: [voxstring]"
	user.vox_silence_time = world.timeofday + 100 //Approx ten seconds cooldown

	for(var/cword in correct_words)
		user.vox_play(cword)

/mob/living/silicon/ai/proc/vox_split_words(var/string)
	var/list/outp = new
	string = replacetext (string, ",", " _comma ") // Comma
	string = replacetext (string, ".", " _period ") // Period
	string = replacetext (string, "+", " ") // Plus
	string = replacetext (string, "  ", " ") //Two space into one

	var/list/L = text2list(trim(string), " ")

	for (var/word in L)
		word = trim (word)
		if (word)
			outp += word

	usr << "Your voice module is trying to synthesize: [dd_list2text(outp,"+")]"
	return outp
