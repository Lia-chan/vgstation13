/atom/proc/add_poo_floor(mob/living/carbon/M as mob)
	if( istype(src, /turf/simulated) )
		var/obj/effect/decal/cleanable/poo/this = new /obj/effect/decal/cleanable/poo(src)
		new /obj/item/stack/sheet/mineral/solidshit(src)
		for(var/datum/disease/D in M.viruses)
			var/datum/disease/newDisease = D.Copy(1)
			this.viruses += newDisease
			newDisease.holder = this

/mob/living/carbon/var/lastshit = 0

/mob/living/carbon/human/proc/poo()
	if(lastshit<2 &&  (nutrition > 301))
		lastshit = 2
		Stun(5)
		var/turf/location = loc

		var/Ft = null
		if(src.loc && isturf(src.loc))
			for(var/obj/structure/toilet/T in src.loc)
				src.visible_message("<spawn class='warning'>[src] shits into toilet.","<spawn class='warning'>You just laid a larva into toilet.")
				Ft = T
		if(!Ft)
			src.visible_message("<spawn class='warning'>[src] shits up!","<spawn class='warning'>You shit!")
			if (istype(location, /turf/simulated))
				location.add_poo_floor(src)
		playsound(loc, 'sound/effects/splat.ogg', 50, 1)

		nutrition -= 25
		adjustToxLoss(-3)
		spawn(1200)	//wait 120 seconds before next volley
			lastshit = 0

/mob/living/carbon/human/proc/want_to_poo(var/want as num)
	switch(want)
		if (0)
			src.verbs -= /mob/living/carbon/human/proc/manual_poo
			return
		if (1)
			if (lastshit>0) return
			lastshit = 1
			src << "<spawn class='warning'>You feel like you wanna shit..."
			src.verbs += /mob/living/carbon/human/proc/manual_poo
			spawn(300)	//30 seconds until second warning
				want_to_poo(2)
		if (2)
			if (lastshit>1) return
			src << "<spawn class='warning'>You feel like you are about to shit!"
			spawn(250)	//and you have 25 more for mad dash to the bucket
				want_to_poo(3)
		else
			poo()
			want_to_poo(0)

/mob/living/carbon/human/proc/manual_poo()
	set name = "Shit here!"
	set category = "IC"
	poo()
	want_to_poo(0)

/obj/effect/decal/cleanable/poo
	name = "poo"
	desc = "It's brown and gooey."
	gender = PLURAL
	density = 0
	anchored = 1
	layer = 2
	icon = 'icons/nanotrasen/misc.dmi'
	icon_state = "poo1"
	random_icon_states = list("poo1", "poo2", "poo3", "poo4", "poo5", "poo6")
	var/list/viruses = list()
	blood_DNA = list()
	var/datum/disease2/disease/virus2 = null

/datum/symptom/poo
	name = "Poo"
	stealth = -2
	resistance = -1
	stage_speed = 0
	transmittable = 1
	level = 3

/datum/symptom/poo/Activate(var/datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB / 2))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(1, 2, 3, 4)
				M << "<span class='notice'>[pick("You feel like you wanna shit.", "You feel like you're going to shit up!")]</span>"
			else
				poo(M)

	return

/datum/symptom/poo/proc/poo(var/mob/living/M)
	M.visible_message("<B>[M]</B> shits on the floor!")

	M.nutrition -= 25
	M.adjustToxLoss(-3)

	var/turf/pos = get_turf(M)
	pos.add_poo_floor(M)
	playsound(pos, 'sound/effects/splat.ogg', 50, 1)
