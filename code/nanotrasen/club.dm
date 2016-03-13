/*
/obj/machinery/club/lightmusic
	name = "Light music"
	desc = "."
	icon = 'device.dmi'
	icon_state = "locator"
	var/on = 0
	var/error = 0
	var/speed = 0
	New()
		sleep(30)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "invi"
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "bluenew")
				T.icon_state = "invi"
				if(!error)
					sleep(900)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 1

/obj/machinery/club/lightmusic/attack_hand()
	var/dat = {"<B> Valve properties: </B>
	<BR> <B> Speed:</B>[speed != 0 ? "<A href='?src=\ref[src];speed_0=1'>0</A>" : "0"]
	<!--B> </B> [speed != 1 ? "<A href='?src=\ref[src];speed_1=1'>1</A>" : "1"]-->
	<B> </B> [speed != 2 ? "<A href='?src=\ref[src];speed_2=1'>2</A>" : "2"]
	<B> </B> [speed != 3 ? "<A href='?src=\ref[src];speed_3=1'>3</A>" : "3"]"}

	usr << browse(dat, "window=light_music;size=600x300")
	onclose(usr, "light_music")
	return

/obj/machinery/club/lightmusic/Topic(href, href_list)
	..()
	if ( usr.stat || usr.restrained() )
		return
	if(href_list["speed_0"])
		sleep(10)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "invi"
		sleep(3)
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "blinkblue")
				T.icon_state = "invi"
				if(error != 2)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 2
		speed = 0
		return
	else if(href_list["speed_1"])
		usr << "Function is not allowed for now."
		return
	else if(href_list["speed_2"])
		sleep(10)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "blinkblue"
		sleep(3)
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "invi")
				T.icon_state = "blinkblue"
				if(error != 2)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 2
		speed = 2
		return
	else if(href_list["speed_3"])
		//usr << "Function is not allowed for now."
		usr << "PARTY TIEM!"
		var/area/A = src.loc
		A = A.loc
		if (!( istype(A, /area) ))
			return
		A.partyalert()
		return
	updateUsrDialog()


/turf/simulated/floor/clubfloor
	icon_state = "bcircuitoff"
	New()
		if(prob(10))
			overlays << image (icon = 'structures.dmi', icon_state = "latticefull")



/obj/effect/overlay/bluelight
	icon = 'alert.dmi'
	icon_state = "bluenew"
	mouse_opacity = 0
	layer = 10
	anchored = 1
	var/turf
	New()
		turf = src.loc

*/

/mob/var/jukemusic = 0

/area/crew_quarters/bar
	Exited(atom/movable/Obj)
		..()
		if(ismob(Obj))
			if(Obj:client)
				var/mob/M = Obj
				var/sound/S = sound(null)
				S.channel = 10
				S.wait = 0
				M << S
				M.jukemusic = 0
		if(istype(Obj,/obj/structure/stool/bed/chair/vehicle))
			var/obj/structure/stool/bed/chair/vehicle/leaving = Obj
			var/mob/living/rider = leaving.buckled_mob
			rider << sound(null, channel = 10, wait = 0)
			rider.jukemusic = 0


/*
/sound/jukebox/test
	file = 'astley.ogg'
	falloff = 2
	repeat = 1
*/

/obj/machinery/club/jukebox
	name = "Old Jukebox"
	desc = "Vintage music machine adopted for broadcast radio wave"
	icon = 'jukebox.dmi'
	icon_state = "jukebox"
	//icon_state_on = "jukeboxon"
	density = 1
	anchored = 1
	var/playing = 0
	var/sound/current_track
	//var/sound/nullsound = sound(null, channel = 10, wait = 0)
	var/list/tracks = list(\
	loop1=sound('slowstar.ogg'), loop2=sound('vseidetpoplanu.ogg'), loop3=sound('moyaoborona.ogg'), loop4=sound('mskskins.ogg'), loop5=sound('petrosyan.ogg'),\
	loop6=sound('astley.ogg'), loop7=sound('pahom.ogg'),loop8=sound('bigbootybitches.ogg'),loop9=sound('HittheRoadJack.ogg'),loop10=sound('maltesefalcon.ogg'),\
	loop11=sound('kyoto.ogg'),loop12=sound('SanQuentin.ogg'),loop13=sound('SpaceOddity.ogg'),loop14=sound('sparta.ogg'),loop15=sound('Manwithagun.ogg'),\
	loop16=sound('DrunkenSailor.ogg'),loop17=sound('cantina.ogg'),loop18=sound('GayBar.ogg'),loop19=sound('openbsd_blob.ogg'),loop20=sound('magadan.ogg'),loop21=sound('clownol.ogg'))

/*
/obj/machinery/club/jukebox/New()
	..()
	sleep(2)
	new /sound/jukebox/test(src)
	return
*/

/obj/machinery/club/jukebox/process()
	set background = 1
	..()
	if(playing)
		var/area/A = get_area(src)
		for(var/mob/living/M in A)
			if((get_area(M) in A.related) && M.jukemusic == 0 && !(M.sdisabilities & DEAF))
				//world << "DEBUG: Found the song..."
				M << current_track
				M.jukemusic = 1
		sleep(10)

/obj/machinery/club/jukebox/proc/song_refresh() //Refresh current playing song on when it changes
	if(playing)
		var/area/A = get_area(src)
		for(var/mob/living/M in A)
			if((get_area(M) in A.related) && M.jukemusic)
				var/sound/S = sound(null)
				S.channel = 10
				S.wait = 0
				M << S
				spawn(10)
					M << current_track

/obj/machinery/club/jukebox/attack_hand(mob/user as mob)

	var/t = "<B>Turntable Interface</B><br><br>"
	t += "<A href='?src=\ref[src];music_off=1'>Off</A><br><br>"
	if(user.mind && (user.mind.assigned_role == "Clown"))
		t += "<A href='?src=\ref[src];music_on=loop5'>Молодежная тема</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop1'>Би-2 и Диана Арбенина - Медленная Звезда</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop2'>ГрОб - Все идет по плану</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop3'>ГрОб - Моя оборона</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop4'>Бритоголовые Москвички</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop6'>Rick Astley - Never Gonna Give You Up</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop7'>Пахом - А жизнь веселый карнавал</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop8'>A Lost People - Big Booty Bitches</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop9'>Ray Charles - Hit the Road Jack</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop10'>Maltese Falcon</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop11'>Skrillex - Kyoto</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop12'>Johnny Cash - San Quentin</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop13'>David Bowie - Space Oddity</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop14'>Sparta Techno Remix</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop15'>Press Play on tape - Man with a gun</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop16'>Irish Rovers - Drunken Sailor</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop17'>Star Wars - Cantina</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop18'>Electric Six - Gay Bar</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop19'>OpenBSD project - BLOB!</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop20'>Alexander Zaloopin - Магадан</A><br>"
	t += "<A href='?src=\ref[src];music_on=loop21'>Rainbow Clownol</A><br>"

	user << browse(sanitize_easy(t), "window=turntable;size=420x800")
	onclose(user, "turntable")


/obj/machinery/club/jukebox/Topic(href, href_list)
	..()
	if(href_list["music_off"])
		if(playing)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 0
			for(var/mob/living/M in world)
				if(M.jukemusic)
					M << S
					M.jukemusic = 0
			current_track = sound(null)
			playing = 0
			//for(var/area/RA in A.related)  //WTF?
		return
	if(href_list["music_on"])
		var/track = href_list["music_on"]
		//usr << "Playing [track]"
		if(track in tracks)
			current_track = tracks[track]
		else
			usr << "\red No such track!"
			current_track = sound(null)
			return
		current_track.repeat = 1
		current_track.channel = 10
		current_track.falloff = 2
		current_track.wait = 0
		current_track.environment = 0
		if(playing)
			song_refresh()
		playing = 1
		//Easter time!
		if(track=="loop4" && prob(30))
			if(istype(usr,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = usr
				if(H.gender==FEMALE)
					H.h_style = "Skinhead"
					H.update_hair()

					H.put_in_any_hand_if_possible(new /obj/item/weapon/melee/classic_baton(H),0)

					if(H.shoes)
						H.drop_from_inventory(H.shoes)
					H.equip_to_slot_or_del(new /obj/item/clothing/shoes/combat(H), slot_shoes)

					if(H.wear_suit)
						H.drop_from_inventory(H.wear_suit)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/suspenders(H), slot_wear_suit)
					H << "You feel something special about this track"
	updateUsrDialog()
