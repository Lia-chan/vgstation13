/mob/living/var/zombieleader = 0
/mob/living/var/zombieimmune = 0
/mob/living/var/zombie = 0
/mob/living/var/becoming_zombie = 0

/mob/living/proc/zombify()
	if (zombie == 1)
		return
	var/mob/living/carbon/human/zombified = src
	stat &= 1
	health = 100
	oxyloss = 0
	toxloss = 0
	becoming_zombie = 0
	fireloss = 0
	bruteloss = 0
	zombie = 1
	bodytemperature = 310.055
	see_in_dark = 8
	src.sight = 38
	faction = "zombie" // Zombie zombini zombi est!
	src.verbs += /mob/living/proc/supersuicide
	if(zombieleader)
		src.verbs -= /mob/living/proc/zombierelease
	visible_message("[real_name] seizes up, his eyes dead and lifeless...");
	zombified.MakeZombie() // Here is the magic
	if(ticker && istype(ticker.mode,/datum/game_mode/zombie))
		if(zombified.mind)
			ticker.mode.zombies += zombified.mind
			ticker.mode:equip_zombie(zombified.mind)
			ticker.mode:greet_zombie(zombified.mind)
		ticker.mode.check_win()
	else
		src << "\red<font size=3> You have become a zombie!"
		// not adding to ticker.mode.zombies, it is pointless.

/mob/living/proc/unzombify()
	zombie = 0
	see_in_dark = 2
	update_icons()
	src << "You have been cured from being a zombie!"

/mob/living/proc/zombie_bit(var/mob/biter) //occurs in biten mob (src)
	var/mob/living/carbon/human/biten = src
	if(zombie || becoming_zombie || !istype(src,/mob/living/carbon))
		return
	if(stat > 1)//dead: it takes time to reverse death, but there is no chance of failure
		becoming_zombie = 1
		spawn(50)
			zombify()
		return
	var/wears_suit = istype(biten.wear_suit, /obj/item/clothing/suit/bio_suit)
	var/wears_hood = istype(biten.head, /obj/item/clothing/head/bio_hood)
	if( wears_suit || wears_hood ) // suit OR hood
		if( wears_suit && wears_hood ) // suit AND hood
			if(prob(50))
				src.visible_message("[biter.name] fails to bite [name]")
				return
		else if(prob(25))
			src.visible_message("[biter.name] fails to bite [name]")
			return
	src.visible_message("[biter.name] bites [name]!")
	if(zombieimmune)
		return
	if(prob(7))
		becoming_zombie = 1
		zombify()
	else if(prob(10))
		becoming_zombie = 1
		src << "You feel a strange itch"
		spawn(300)
			if(becoming_zombie)
				zombify()
	else if(prob(30))
		becoming_zombie = 1
		src << "You faintly feel a strange itch"
		spawn(800)
			if(becoming_zombie)
				src << "You feel a strange itch, stronger this time"
				sleep(400)
				if(becoming_zombie)
					zombify()

/mob/living/proc/zombie_infect()
	if (zombie == 1 || becoming_zombie == 1)
		return
	becoming_zombie = 1
	src << "You feel a strange itch"
	spawn(200)
		if(becoming_zombie)
			zombify()

/mob/living/proc/traitor_infect()
	becoming_zombie = 1
	zombieleader = 1
	src.verbs += /mob/living/proc/zombierelease
	src << "\red You have been implanted with a chemical canister contains the Necrovirus. You can either release it yourself or wait until it activates."
	spawn(3000)
		if(becoming_zombie)
			zombify()

/mob/living/proc/admin_infect()
	becoming_zombie = 1
	src << "You faintly feel a strange itch"
	spawn(800)
		if(becoming_zombie)
			src << "You feel a strange itch, stronger this time"
			sleep(400)
			if(becoming_zombie)
				zombify()

/mob/living/proc/supersuicide()
	set name = "Zombie suicide"
	set category = "Zombie!"
	set hidden = 0
	if(zombie == 1)
		switch(alert(usr,"Are you sure you wanna die?",,"Yes","No"))
			if("Yes")
				adjustFireLoss(999)
				src << "You died suprised?"
				return
			else
				src << "You live to see another day."
				return
	else
		src << "Only for zombies."

/mob/living/proc/zombierelease()
	set name = "Zombify"
	set desc = "Turns you into a zombie"
	set category = "Zombie!"
	if(zombieleader)
		zombify()

/client/proc/zombie_infect(var/mob/living/carbon/human/M in mob_list)
///datum/admins/proc/zombie_infect(var/mob/living/carbon/human/M in mob_list)
	set category = "Fun"
	set name = "Zombie infection"

	if(!ishuman(M))
		alert("Invalid mob")
		return
	if(!check_rights(R_FUN))	return
	if(alert("Are you sure? This will slowly turn mob into zombie! Should only be used during debug!",,"Yes","No") != "Yes")
		return
	message_admins("[key_name_admin(src)] has infected [M.key] with a zombie virus")
	M.admin_infect()

/mob/living/carbon/human/proc/MakeZombie()
	//if(HUSK in mutations)	return // DERP

	if(f_style)
		f_style = "Shaved"		//we only change the icon_state of the hair datum, so it doesn't mess up their UI/UE
	if(h_style)
		h_style = "Bald"
	update_hair(0)

	//mutations.Add(HUSK) // DERP
	for(var/datum/organ/external/part in src.organs)
		part.status |= ORGAN_DEAD
	status_flags |= DISFIGURED	//makes them unknown without fucking up other stuff like admintools
	status_flags &= ~CANSTUN
	status_flags &= ~CANPARALYSE
	mutations.Add(mNobreath)
	name = "Zombie"
	real_name = "Zombie"
	sdisabilities |= MUTE
	update_body(0) //1 to update dead overlays
	dna.mutantrace = "zombie"
	update_mutantrace()
	return