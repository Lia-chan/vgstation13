/*
/obj/machinery/bendydoor // a bolted down airlock that is being bended open by zombies.
	icon = 'zombiedamage.dmi'
	icon_state = "bendy0"
	var/bendedness = 0
	var/cooldown = 0
	var/destroyed = 0

/obj/machinery/bendydoor/attack_hand()
	var count = 0
	for (mob/human/M in orange(2,src))
		count += 1
	if (count > 3 && !cooldown)
		bendedness += 1
		icon_state = "bendy[bendedness]"
		cooldown = 1
		spawn(15)
			cooldown = 0
		*/
//Zombie mode stuff
/datum/game_mode
	// this includes admin-appointed traitors and multitraitors. Easy!
	var/list/datum/mind/zombies = list()

/var
	zombiewin = 0
	zombieshuttle = 0
	list/humans_left_lol = ""
	list/zombies_left_lol = ""
	shuttleleft = 0

/datum/game_mode/zombie
	name = "Zombie Outbreak"
	config_tag = "zombie"
	required_players = 10
	required_players_secret = 30
	required_enemies = 5
	recommended_enemies = 5
	votable = 0 //TODO: Remove when ready

	var/datum/mind/patient_zero = null
	var/finished = 0
	var/const/waittime_l = 600 //lower bound on time before intercept arrives (in tenths of seconds)
	var/const/waittime_h = 3000 //upper bound on time before intercept arrives (in tenths of seconds)
	var/list/objectives = list()
	var/zombies_possible = 3 //hard limit on zombies
	var/const/zombie_scaling_coeff = 7.0 //how much does the amount of players get divided by to determine zombies

/datum/game_mode/zombie/announce()
	world << "<B>The current game mode is - Zombie Outbreak!</B>"
	world << "<B>One of your crew members is contaminated with a biological weapon</B>"
	world << "<B>Centcom have quarantined your station, do not make any attempt to call the shuttle</B>"

/datum/game_mode/zombie/pre_setup()
	var/list/possible_zombies = get_players_for_role(BE_TRAITOR) // No pref for zombies for now

	// stop setup if no possible zombies
	if(!possible_zombies.len)
		return 0

	var/num_zombies = 1
	if(config.traitor_scaling)
		num_zombies = max(1, round((num_players())/(zombie_scaling_coeff))) //Use traitor scaling for zombies
	else
		num_zombies = max(1, min(num_players(), zombies_possible))

	for(var/j = 0, j < num_zombies, j++)
		if (!possible_zombies.len)
			break
		var/datum/mind/zombie = pick(possible_zombies)
		if(!istype(zombie, /datum/mind)) world << "\red ERROR! Not a mind [zombie] \ref[zombie]"
		if(!patient_zero)
			patient_zero = zombie
			patient_zero.special_role = "zombie"
			//patient_zero.objectives += new /datum/objective/brainz
			world.log << "DEBUG: zombiemode picked [patient_zero] as patient zero."
		else
			zombies += zombie
			zombie.special_role = "zombie"
			//zombie.objectives += new /datum/objective/brainz
			world.log << "DEBUG: zombiemode picked [zombie] as zombie. Their number is [zombies.len]"
		possible_zombies.Remove(zombie)

	if(!patient_zero && !zombies.len)
		return 0
	return 1

/datum/game_mode/zombie/post_setup()
	if(patient_zero)
		equip_zero()
		greet_zero()
	else
		world.log << "DEBUG: zombiemode without patient zero"
	pick_immune()
	for(var/datum/mind/Z in zombies)
		//forge_traitor_objectives(Z)
		spawn(rand(10,100))
			//finalize_traitor(Z)
			equip_zombie(Z)
			greet_zombie(Z)
	modePlayer += patient_zero
	modePlayer += zombies
	spawn (rand(waittime_l, waittime_h))
		//send_intercept() //See datum/intercept_text
		send_detection()
	..()
	return 1

/datum/game_mode/zombie/proc/equip_zero()
	var/datum/objective/brainz/zombie_objective = new
	zombie_objective.owner = patient_zero
	patient_zero.objectives += zombie_objective
	objectives += zombie_objective
	// var/datum/objective/zombie_infect/infect_objective = new //TODO
	patient_zero.current.traitor_infect()
	patient_zero.current.store_memory("Either turn or kill all humans!.")

/datum/game_mode/zombie/proc/equip_zombie(var/datum/mind/zombie)
	var/datum/objective/brainz/zombie_objective = new
	zombie_objective.owner = zombie
	objectives += zombie_objective
	zombie.objectives += zombie_objective
	zombie.current.zombie_infect()
//	patient_zero.current.store_memory("Either turn or kill all humans!.")

/*
/datum/game_mode/zombie/proc/pick_zombie() // OUTDATED
	var/mob/living/carbon/human/killer //= pick(get_synd_list())
	//patient_zero = killer //in setup stage

	//var/objective = "Braaiiinnns....(What do you think? Eat them all.)"
	// /datum/objective/brainz
	var/datum/objective/brainz/zombie_objective = new
	zombie_objective.owner = killer.mind
	objectives += zombie_objective

	//objectives += objective
	killer.traitor_infect()
	killer << "\red<font size=3><B>You are Patient Zero!</B><br>\nBraaiiinnns....(What do you think? Eat them all.)"
	killer.store_memory("Either turn or kill all humans!.")
*/
/datum/game_mode/zombie/proc/pick_immune()
	var/mob/living/carbon/human/M = pick(player_list) // get_human_list())
	world.log << "DEBUG: zombiemode picked [M] as immune"
	M << "Your now immune to the zombies (Don't Metagame)"
	M.zombieimmune = 1

/* NOT USED
/datum/game_mode/zombie/proc/get_synd_list()
	var/list/mobs = list()
	mobs = get_players_for_role(BE_TRAITOR)
	if(mobs.len < 1)
		mobs = get_mob_list()
	return mobs
*/
/datum/game_mode/zombie/proc/greet_zombie(var/datum/mind/zombie)
	var/mob/living/M = zombie.current
	M << "<B><font size=3 color=red>You are the zombie.</font></B>"
	var/obj_count = 1
	for(var/datum/objective/objective in zombie.objectives)
		M << "<B>Objective #[obj_count]</B>: [objective.explanation_text]"
		obj_count++
	return

/datum/game_mode/zombie/proc/greet_zero()
	var/mob/living/M = patient_zero.current
	M << "\red<B><font size=3 color=red>You are Patient Zero!</font></B>"
	var/obj_count = 1
	for(var/datum/objective/objective in patient_zero.objectives)
		M << "<B>Objective #[obj_count]</B>: [objective.explanation_text]"
		obj_count++
	return

/datum/game_mode/zombie/proc/send_detection()
	world << "<FONT size = 3><B>Cent. Com. Update</B> Biological Contamination Detected. Security Level Elevated</FONT><BR>"
	for(var/mob/living/silicon/ai/M in mob_list)
		if (!(M.stat == 2 && M.see_in_dark == 0))
			M.add_ion_law("Biological contaminted personel are not Human.")
			M.add_ion_law("Humans are not allowed access to EVA.")
			for(var/mob/living/silicon/ai/O in mob_list)
				O << "\red...LAWS ARE UPDATED"

/*
/datum/game_mode/zombie/proc/check_win_ex() //OUTDATED!
	var/area/shuttle = locate(/area/shuttle)
	var/list/humans_left = get_human_list()
	var/list/zombies_left = get_zombies_list()
	var/list/zombieonshuttle

	humans_left_lol = humans_left
	zombies_left_lol = zombies_left
	if(humans_left.len < 1 && zombies_left.len < 1)
		world << "<FONT size = 3><B>Neutral Victory everyone died!</B></FONT>"
		sleep(300)
		world.log << "Rebooting due to end of game"
		world << "\red Rebooting due to end of game"
		finished = 1
		world.Reboot()
		return 1
	else if(humans_left.len < 1)
		world << "<FONT size = 3>\red <B>Zombies are Victorious</B></FONT>"
//		ticker.killer.unlock_medal("Patient Zero", 1, "Successfully win a round as Patient Zero.", "medium")
		sleep(300)
		world.log << "Rebooting due to end of game"
		world << "\red Rebooting due to end of game"
		finished = 1
		world.Reboot()
		return 1
	else if(zombies_left.len < 1)
		world << "<FONT size = 3>\blue <B>The humans have prevailed against the zombie threat</B></FONT>"
		sleep(300)
		world.log << "Rebooting due to end of game"
		world << "\red Rebooting due to end of game"
		finished = 1
		world.Reboot()
		return 1
	else if(zombiewin == 1)
		world << "<FONT size = 3>\red <B>Zombies are Victorious</B></FONT>"
//		ticker.killer.unlock_medal("Patient Zero", 1, "Successfully win a round as Patient Zero.", "medium")
		sleep(300)
		world.log << "Rebooting due to end of game"
		world << "\red Rebooting due to end of game"
		finished = 1
		world.Reboot()
		return 1
	else if(shuttleleft)
		for(var/mob/living/carbon/M in shuttle)
			if(M.zombie && M.becoming_zombie)
				zombieonshuttle += M
		if(zombieonshuttle.len >= 1)
			world << "<FONT size = 3>\red <B>You doomed the entire human race</B></FONT>"
			world << "<FONT size = 3>\red <B>Zombies are Victorious</B></FONT>"
//			ticker.killer.unlock_medal("Patient Zero", 1, "Successfully win a round as Patient Zero.", "medium")
			sleep(300)
			world.log << "Rebooting due to end of game"
			world << "\red Rebooting due to end of game"
			finished = 1
			world.Reboot()
			return 1
		else
			world << "<FONT size = 3>\blue <B>The humans have prevailed against the zombie threat</B></FONT>"
			sleep(300)
			world.log << "Rebooting due to end of game"
			world << "\red Rebooting due to end of game"
			finished = 1
			world.Reboot()
			return 1


	else
		return 0
*/


/*
/datum/game_mode/zombie/proc/get_human_list()
	var/list/human = list()
	for(var/mob/living/carbon/M in world)
		if (M.stat<2 && M.client && istype(M, /mob/living/carbon/human) && M.zombie == 0)
			human += M
	return human

/datum/game_mode/zombie/proc/get_zombies_list()
	var/list/zombies = list()
	for(var/mob/living/carbon/M in world)
		if (M.stat<2 && M.client && istype(M, /mob/living/carbon/human) && M.zombie == 1)
			zombies += M
	return zombies

/datum/game_mode/zombie/proc/get_mob_list()
	var/list/mobs = list()
	for(var/mob/living/carbon/M in world)
		if (M.stat<2 && M.client && istype(M, /mob/living/carbon/human))
			mobs += M
	return mobs
*/

/datum/objective/brainz
	explanation_text = "Braaiiinnns....(What do you think? Eat them all.)"

/datum/objective/zombie_infect
	explanation_text = "Turn all humans to zombies"

//Checks if the round is over//
/datum/game_mode/zombie/check_finished()
	if(finished != 0)
		return 1
	else
		return 0

// The CAST
/datum/game_mode/proc/auto_declare_completion_zombie()
	if( ticker && istype(ticker.mode,/datum/game_mode/zombie) )
		var/text = ""
		if( ticker.mode:patient_zero )
			text += "<FONT size = 2><B>The patient zero was:</B></FONT>"
			text += show_completion_role(ticker.mode:patient_zero)
			text += "<br>"
		if( zombies.len )
			text += "<FONT size = 2><B>The zombies were:</B></FONT>"
			for(var/datum/mind/Z in zombies)
				text += show_completion_role(Z)
		world << text

//The cast helper proc
/datum/game_mode/proc/show_completion_role(var/datum/mind/cultist)
	var/text = "<br>[cultist.key] was [cultist.name] ("
	if(cultist.current)
		if(cultist.current.stat == DEAD)
			text += "died"
		else
			text += "survived"
		if(cultist.current.real_name != cultist.name)
			text += " as [cultist.current.real_name]"
	else
		text += "body destroyed"
	text += ")"
	return(text)

//Announces the end of the game with all relavent information stated//
/datum/game_mode/zombie/declare_completion()
	if(finished == 1)
		feedback_set_details("round_end_result","win - zombies everyone")
		world << "\red <FONT size = 3><B> Zombies are Victorious!</B></FONT>"
	else if(finished == 2)
		feedback_set_details("round_end_result","loss - zombies killed")
		world << "\red <FONT size = 3><B>The humans have prevailed against the zombie threat!</B></FONT>"
	else if(finished == 3)
		feedback_set_details("round_end_result","draw - everyone dies")
		world << "\red <FONT size = 3><B>Everyone dies. What a pathetic.</B></FONT>"
	..()
	return 1

//Checks if the revs have won or not//
/datum/game_mode/zombie/check_win()
	//world << "DEBUG: Mode is uncomplete! check_win() occurs."

	var/alive = 0
	var/sick = 0
	for(var/mob/living/carbon/human/H in world)
		if(H.key && H.stat != 2)
			if(H.zombie == 0 && H.becoming_zombie == 0) alive++
			if(H.zombie == 1 || H.becoming_zombie == 1) sick++

	if(alive == 0)
		finished = 1 // Everyone are zombie
	if(sick == 0)
		finished = 2 // No more zombies
	if(sick == 0 && alive == 0)
		finished = 3 // Everybody dies
	return


/*
/datum/game_mode/zombie/proc/check_zombie_victory()

	return cult_fail //if any objectives aren't met, failure
*/
/*
/datum/game_mode/zombie/proc/check_survive()
	acolytes_survived = 0
	for(var/datum/mind/cult_mind in cult)
		if (cult_mind.current && cult_mind.current.stat!=2)
			var/area/A = get_area(cult_mind.current )
			if ( is_type_in_list(A, centcom_areas))
				acolytes_survived++
	if(acolytes_survived>=acolytes_needed)
		return 0
	else
		return 1*/

/*
/datum/game_mode/zombie/declare_completion()
	return // TODO

	if(0) //!check_zombie_victory())
		//feedback_set_details("round_end_result","win - zombie win")
		//feedback_set("round_end_result",acolytes_survived)
		world << "\red <FONT size = 3><B> The zombie wins! It has succeeded in serving its dark masters!</B></FONT>"
	else
		//feedback_set_details("round_end_result","loss - staff stopped the cult")
		//feedback_set("round_end_result",acolytes_survived)
		world << "\red <FONT size = 3><B> The staff managed to stop the zombies!</B></FONT>"
*/
/*
	var/text = "<b>Cultists escaped:</b> [acolytes_survived]"

	if(objectives.len)
		text += "<br><b>The cultists' objectives were:</b>"
		for(var/obj_count=1, obj_count <= objectives.len, obj_count++)
			var/explanation
			switch(objectives[obj_count])
				if("survive")
					if(!check_survive())
						explanation = "Make sure at least [acolytes_needed] acolytes escape on the shuttle. <font color='green'><B>Success!</B></font>"
						feedback_add_details("cult_objective","cult_survive|SUCCESS|[acolytes_needed]")
					else
						explanation = "Make sure at least [acolytes_needed] acolytes escape on the shuttle. <font color='red'>Fail.</font>"
						feedback_add_details("cult_objective","cult_survive|FAIL|[acolytes_needed]")
				if("sacrifice")
					if(sacrifice_target)
						if(sacrifice_target in sacrificed)
							explanation = "Sacrifice [sacrifice_target.name], the [sacrifice_target.assigned_role]. <font color='green'><B>Success!</B></font>"
							feedback_add_details("cult_objective","cult_sacrifice|SUCCESS")
						else if(sacrifice_target && sacrifice_target.current)
							explanation = "Sacrifice [sacrifice_target.name], the [sacrifice_target.assigned_role]. <font color='red'>Fail.</font>"
							feedback_add_details("cult_objective","cult_sacrifice|FAIL")
						else
							explanation = "Sacrifice [sacrifice_target.name], the [sacrifice_target.assigned_role]. <font color='red'>Fail (Gibbed).</font>"
							feedback_add_details("cult_objective","cult_sacrifice|FAIL|GIBBED")
				if("eldergod")
					if(!eldergod)
						explanation = "Summon Nar-Sie. <font color='green'><B>Success!</B></font>"
						feedback_add_details("cult_objective","cult_narsie|SUCCESS")
					else
						explanation = "Summon Nar-Sie. <font color='red'>Fail.</font>"
						feedback_add_details("cult_objective","cult_narsie|FAIL")
			text += "<br><B>Objective #[obj_count]</B>: [explanation]"

	world << text
	..()
	return 1*/





/datum/game_mode/zombie/process()
/*
	if(stage == 1 && cruiser_seconds() < 60 * 30)
		announce_to_kill_crew()
		stage = 2
	else if(stage == 2 && cruiser_seconds() <= 60 * 5)
		command_alert("Inbound cruiser detected on collision course. Scans indicate the ship to be armed and ready to fire. Estimated time of arrival: 5 minutes.", "[station_name()] Early Warning System")
		stage = 3
	else if(stage == 3 && cruiser_seconds() <= 0)
		crew_lose()
		stage = 4

	checkwin_counter++
	if(checkwin_counter >= 20)
		if(!finished)
			ticker.mode.check_win()
		checkwin_counter = 0*/
	return 0






///////////////////////////////////////////
///Handle crew failure(station explodes)///
///////////////////////////////////////////
/*
/datum/game_mode/zombie/proc/crew_lose()
	ticker.mode:explosion_in_progress = 1
	for(var/mob/M in world)
		if(M.client)
			M << 'Alarm.ogg'
	world << "\blue<b>Incoming missile detected.. Impact in 10..</b>"
	for (var/i=9 to 1 step -1)
		sleep(10)
		world << "\blue<b>[i]..</b>"
	sleep(10)
	enter_allowed = 0
	if(ticker)
		ticker.station_explosion_cinematic(0,null)
		if(ticker.mode)
			ticker.mode:station_was_nuked = 1
			ticker.mode:explosion_in_progress = 0
	finished = 2
	return*/


