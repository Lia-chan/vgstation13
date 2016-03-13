///mob/living/carbon/human/var/being_strangled = 0
// TODO: convert to /obj/item/weapon/grab/G in usr.grabbed_by (allows resist)

#define STRANGLE_TIME 600 //Max strangle time in ticks

/obj/item/weapon/slipknot
	name = "slipknot"
	desc = "Can be used to strangle someone."
	throwforce = 10.0
	throw_speed = 2
	throw_range = 5
	w_class = 1.0
	flags = TABLEPASS | USEDELAY | FPRINT | CONDUCT
	slot_flags = SLOT_BELT
	var/state = 0 //Straingling states: 0 - idle, 1..3 - victim being strangled (different states)
	var/mob/living/carbon/human/victim = null
	var/mob/agressor = null
	var/releasetime = null
	// var/todead = 0 //Strangle to dead

/obj/item/weapon/slipknot/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/slipknot/Del()
	processing_objects.Remove(src)
	..()

/obj/item/weapon/slipknot/process()
	set background = 1

	if (state == 0) return 0

	if (!victim)
		release()
		return 0

	if(releasetime)
		if(world.timeofday >= releasetime)
			release()
			agressor << "\red You lose your grip. You cannot hold it any longer!"
			victim << "\red [agressor.name] loses his grip on you"
			return 0

	if (get_dist(agressor, victim) > 1)
		release()
		agressor << "\red You moved too far away from [victim] and [src] slipped off the neck!"
		return 0

	switch (state)
		if (1)
			strangle_victim(5)
		if (2)
			strangle_victim(7)
		if (3)
			strangle_victim(10)

	sleep(30)
	if(victim.stat != CONSCIOUS) //Todo: strangle to DEAD, based on intent?
		agressor << "You lose your grip. Your victim falls limp."
		release()

	return 1

/obj/item/weapon/slipknot/proc/release()
	state = 0
	releasetime = null

/obj/item/weapon/slipknot/proc/begin_strangle(var/mob/target, var/begin_state = 1)
	if ( !ishuman(target) ) return 0
	victim = target
	state = begin_state
	releasetime = world.timeofday + STRANGLE_TIME


/obj/item/weapon/slipknot/attack(mob/M as mob, mob/user as mob)
	if (!ishuman(M))
		user << "You cannot strangle non-human lifeforms!"
		return
	if (!(user.a_intent == "grab" || user.a_intent == "hurt"))
		user << "Try to be more aggressive while using [src] to strangle someone."
		return

	agressor = user
	var/mob/living/carbon/human/target = M

	switch (state)
		if (0) //If we at idle
			if (agressor.dir == target.dir) //Checking that we are in right direction
				if (prob(66))
					target.visible_message("<span class='danger'>[M] is being strangled with the [src] by [user]!</span>")
					user << "You begin to strangle [M] with your [src]!"
					begin_strangle (target, 1) // Start from state 1
					user.attack_log += "\[[time_stamp()]\] <font color='red'> ([user.ckey]) start strangling [target.real_name] ([target.ckey]) with [name] </font>"
					log_attack("<font color='red'> [user.real_name] ([user.ckey]) start strangling [target.real_name] ([target.ckey]) with [name] </font>")
				else
					target.visible_message("<span class='danger'>[user] is attempting to strangle [M] with the [src]!</span>")
					user << "\red You failed to strangle [M] with your [src]!"
			else
				user << "\red You should be behind of [M] to strangle him!"
			return //Not allowing tighten to 2 or 3 in one click

		if (1) //Trying to tighten grip
			if (prob(50))
				user << "\red You tighten your grip on [victim]'s neck!"
				state = 2
			return //Not allowing tighten to 3 in one click

		if (2) //Trying to tighten grip
			if (prob(33))
				user << "\red You tighten more your grip on [victim]'s neck!"
				state = 3
	return

/obj/item/weapon/slipknot/attack_self(mob/user as mob)
	if (ishuman(user) && (user.a_intent == "grab" || user.a_intent == "hurt"))
		if (state == 0) //If we at idle
			if (prob(20))
				user << "\red You begin to strangle yourself. There's no way out..."
				begin_strangle(user, 2) //Start from state 2
			else
				user << "You tried to strangle yourself, but with no success."
	return

/obj/item/weapon/slipknot/proc/strangle_victim(var/force)
	if (victim)
		if(prob(25)) return // Give a chance
		victim.AdjustStunned(3)
		var/datum/organ/external/head = victim.organs_by_name["head"]
		if(!head)
			agressor << "\red [victim.name] has no head!"
			release()
			return
		var/brutedmg = round(force/2)
		var/oxydmg = force*rand(1,2)
		head.createwound(BRUISE, brutedmg)
		victim.adjustOxyLoss(oxydmg)
		if(Debug2) agressor << "Damaging [victim.name] to DMG:[force] BRUTE:[brutedmg] OXY:[oxydmg] at [head] Time left: [releasetime - world.timeofday]"
	return

/obj/item/weapon/cable_coil/verb/make_slipknot()
	set name = "Make Cable Slipknot"
	set category = "Object"
	var/mob/M = usr

	if(ishuman(M) && !M.restrained() && !M.stat && !M.paralysis && ! M.stunned)
		if(!istype(usr.loc,/turf)) return
		if(src.amount <= 14)
			usr << "\red You need at least 15 lengths to make slipknot!"
			return
		var/obj/item/weapon/slipknot/cable/B = new /obj/item/weapon/slipknot/cable(usr.loc)
		B.icon_state = "cable_slipknot_[color]"
		usr << "\blue You wind some cable together to make deadly slipknot."
		src.use(15)
	else
		usr << "\blue You cannot do that."
	..()

/obj/item/weapon/slipknot/cable
	name = "cable slipknot"
	desc = "A slipknot made of cable wire. Can be used to grab and strangle someone."
	icon = 'icons/nanotrasen/slipknot.dmi'
	icon_state = "cable_slipknot_red"

#undef STRANGLE_TIME
