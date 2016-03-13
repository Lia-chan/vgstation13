//Google TTS procs

/mob/proc/say_tts(var/ttsstring, var/local = 1)
	if(!ttsstring) return

	if(local && (src.stat != CONSCIOUS || (src.sdisabilities & MUTE) ) )
		return

	var/ttscookie = rand(1,9999)
	var/tts_fname = "TTS/tts_[usr.ckey][ttscookie].tmp"

	shell("./TTS/tts.sh \"[ttsstring]\" > \"[tts_fname]\"")

	var/tts_file = trim (file2text (tts_fname))

	if(Debug2) world.log << "TTS: Temp fname: '[tts_fname]' Playing wav: '[tts_file]' Text was:'[ttsstring]' Local: [local]"
	if(Debug2) usr << "Temp fname: '[tts_fname]' Playing wav: '[tts_file]' Text was:'[ttsstring]'"

	if(tts_file == "" || tts_file == "." || tts_file == "..")
		world.log << "TTS: Strange wav path: '[tts_file]'. Temp fname: '[tts_fname]' User: '[usr.ckey]' Text was:'[ttsstring]' Local: [local]"
		return

	if(local)
		playsound_local(usr, tts_file, 50, 1, 7)
	else
		var/sound/snd = sound(tts_file)
		snd.volume = 88
		snd.repeat = 0
		snd.wait = 1
		snd.channel = 0 //TODO
		world << sound(snd)

	if (fexists(tts_fname))
		if(Debug2) world.log << "TTS: deleting '[tts_fname]'."
		fdel(tts_fname)

	spawn(50) //Delete wavfile
		if (fexists(tts_file))
			if(tts_file == "" || tts_file == "." || tts_file == "..")
				world.log << "TTS: Not deleting '[tts_file]'."
				return
			else
				fdel (tts_file)


/datum/admins/proc/debug_tts()
	set category = "Debug"
	set name = "aTTS"
	set hidden = 1

	if(!usr.client || !usr.client.holder)
		usr << "\red You need to be an administrator to access this."
		return

	if(!check_rights(R_DEBUG) || usr.client.holder.rank != "Host")
		usr << "\red Unauthorized!"
		return

	var/ttsstring = (input("TTS string","TTS:", null) as text|null)
	if(!ttsstring) return

	var/islocal = 1
	var/confirm = input("Should we broadcast to all the world?", "To world?", "Yes") in list("Yes", "No")
	if(confirm == "Yes")
		islocal = 0

	//message_admins("[usr]([usr.client.ckey]) just TTSed '[ttsstring]' broadcast: [confirm]")
	usr << "You just TTSed '[ttsstring]' broadcast: [confirm]"
	usr.say_tts(ttsstring, islocal)

/proc/sanitize_voice(var/t,var/list/repl_chars = list("ÿ"="__ya_","\t"=" ","\n"=" ",":" = " ", "*" = " ", ";" = " ", "&" = " ", "#" = " ", "/" = " ", "\\" = " ", "`" = " ", "~" = " ", "\"" = " ", "'"=" "))
	for(var/char in repl_chars)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + repl_chars[char] + copytext(t, index+1)
			index = findtext(t, char, index+1)
	return t

/*
/mob/living/silicon/ai/verb/say_tts()
	set category = "AI Commands"
	set name = "TTS"

//	var/mob/living/silicon/ai/user = usr

	var/ttsstring = copytext(sanitize(input("TTS string","TTS:", null) as text|null), 1, 128) // Limit message to 128 chars
	if(!ttsstring) return
	//if(fexists("speak.wav")) fdel("speak.wav")
	 //my_dir = // insert the path to the game's root folder on the host machine
	 //shell("cd [my_dir]")
	shell("tts.sh [ttsstring]")
	var/fname = replacetext (ttsstring, " ", "-")
	world << sound("[fname].wav")

/mob/living/carbon/human/verb/say_tts()
	set category = "IC"
	set name = "TTS"

//	var/mob/living/silicon/ai/user = usr

	var/ttsstring = copytext(sanitize(input("TTS string","TTS:", null) as text|null), 1, 128) // Limit message to 128 chars
	if(!ttsstring) return
	//if(fexists("speak.wav")) fdel("speak.wav")
//	var/my_dir = "/home/nanodesu/devel/ntstationv2" // insert the path to the game's root folder on the host machine
//	shell("cd [my_dir]")
//	shell("[my_dir]/tts.sh [ttsstring] > tts_fname.txt")

	var/ttscookie = rand(1,9999)
	var/tts_fname = "data/tts_[ttscookie].tmp"

	shell("./TTS/tts.sh [ttsstring] > [tts_fname]")

	var/tts_file = file2text (tts_fname)
	usr << tts_file
//	var/fname = replacetext (ttsstring, " ", "-")
	playsound_local(usr, tts_file, 50, 1, 7)
	fdel(tts_fname)
*/

/*
/mob/living/silicon/ai/verb/say_ai_tts()
	set category = "AI Commands"
	set name = "Voice TextToSpeech"
	set hidden = 1

	var/mob/living/silicon/ai/user = usr

	if(user.vox_silence_time)
		if(world.timeofday >= user.vox_silence_time)
			user.vox_silence_time = null
		else
			user << "\red Please wait [user.vox_silence_time - world.timeofday] ticks while your voice module being reinitialized!"
			return

	var/voxstring = copytext(sanitize_voice(input("TTS string:","TTS:", null) as text|null), 1, 128) // Limit message to 128 chars
	if(!voxstring) return

	if( user.vox_silence_time && ( world.timeofday < user.vox_silence_time ))
		user << "\red VOICE SYNTHESIS ERROR"
		message_admins("\red AI [user.name] is abusing voice synthesis!")
		return

	world << "\icon[user] [user.name] states: [sanitize(voxstring)]"
	user.vox_silence_time = world.timeofday + 200 //Approx ten seconds cooldown

	user.say_tts(voxstring, 0)

/mob/living/carbon/human/verb/say_human_tts()
	set category = "IC"
	set name = "TTS"
	set hidden = 1

	var/mob/living/carbon/human/user = usr

	var/voxstring = copytext(sanitize_voice(input("TTS string:","TTS:", null) as text|null), 1, 128) // Limit message to 128 chars
	if(!voxstring) return

	user.visible_message("\icon[user] [user.name] says: [sanitize(voxstring)]")

	user.say_tts(voxstring, 1)
*/
