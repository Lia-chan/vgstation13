/mob/living/carbon/human/proc/brain_explode()
        var/datum/organ/external/head/H = get_organ("head")
        H.brain_explode()

/datum/organ/external/head/var/obj/item/brain

/datum/organ/external/head/proc/brain_explode()
	..()
	if(!destspawn && !(status&ORGAN_DESTROYED))
		playsound(get_turf_loc(owner), 'sound/effects/fuckmoimozg.wav', 50, 0, 0)
		status |= ORGAN_DESTROYED
		destspawn = 1
		//brain_explode = 0

		var/atom/movable/overlay/animation = null
		animation = new(owner.loc)
		animation.icon_state = "blank"
		animation.icon = 'icons/mob/mob.dmi'
		animation.master = src
		flick("gibbed-h", animation)

		spawn(15)
			if(animation)   del(animation)

		owner.u_equip(owner.glasses)
		owner.u_equip(owner.head)
		owner.u_equip(owner.ears)
		owner.u_equip(owner.wear_mask)
		owner.regenerate_icons()

		spawn(10)
			owner << "Your brain decides it has had enough of you and leaves."
			var/obj/effect/decal/cleanable/blood/Bl = new(owner.loc)
			if(!Bl.blood_DNA) Bl.blood_DNA = list()
			if(owner && owner.dna)
				Bl.blood_DNA[owner.dna.unique_enzymes] = owner.dna.b_type
			if(brain)
				brain.loc = owner.loc
				var/obj/item/device/mmi/MMI = brain
				//add_to_mob_list(MMI.brainmob)
				mob_list += MMI.brainmob
				if(owner.mind)  owner.mind.transfer_to(MMI.brainmob)
			else
				var/obj/item/brain/B = new(owner.loc)
				B.transfer_identity(owner)
				brain = B
			step(brain,pick(cardinal))
			brain = null

		spawn(60)
			if(owner) owner.death()
