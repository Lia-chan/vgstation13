/obj/structure/foamedliving // Used by effect_system.dm
	var/mob/living/inside

	proc/init(mob/living/A)
		name = "Bronzed [A.name]"
		var/holding
		var/missing
		var/t_He = "It"
		if(A.gender == MALE)
			t_He = "He"
		else if(A.gender == FEMALE)
			t_He = "She"
		if(A.l_hand || A.r_hand)
			if(A.l_hand) holding = " [t_He] is holding \a [A.l_hand]"
			if(A.r_hand)
				if(holding)
					holding += " and \a [A.r_hand]"
				else
					holding = " [t_He] is holding \a [A.r_hand]"
			if(holding) holding += "."
		if(istype(A,/mob/living/carbon/human))
			var/mob/living/carbon/human/H =A
			name += " the [H.get_assignment("Unknown","Unemployed")]"
			if(H.wear_suit)
				holding+= " [t_He] is wearing [H.wear_suit]."
			var/skipmask = 0
			for(var/datum/organ/external/E in H.organs)
				if(E.status&ORGAN_DESTROYED)
					if(!missing)
						missing+= " [t_He] is missing [E.display_name]"
					else
						missing+= " and [E.display_name]"
			if(missing) missing+="."
			if(H.head)
				holding+= " [t_He] is wearing [H.head]."
				skipmask = (H.head.flags_inv) & HIDEMASK
			if(H.wear_mask && !skipmask)
				holding+= " [t_He] is wearing [H.wear_mask] on his head."
			if(H.handcuffed)
				holding+= " [t_He] [H] is handcuffed."
		desc = "It is statue of [A.name].[missing][holding]"
		var/icon/ico = build_composite_icon_omnidir(A)
		var/icon/overl = new('icons/effects/effects.dmi',"ironfoam")
		overl.MapColors(1,0,0, 0,1,0, 0,0,1, 0.1,0.1,0.1)
		ico.GrayScale()
		ico.Blend(overl,ICON_MULTIPLY)
		icon = ico
		inside = A
		dir = A.dir
		if(A.buckled)
			A.buckled.buckled_mob = null
			A.buckled = null
		A.loc = src
		A.anchored = 0
		inside.Stun(50)
		if(!inside.lying)
			density = 1

	handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
//		var/mob/living/L = lifeform_inside_me
//		if(istype(L))
//			L.adjustOxyLoss(10)
		return null

	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if(istype(mover) && mover.checkpass(PASSGRILLE))
			return 1
		else if(istype(mover,/obj/structure/window))
			if(mover.dir == SOUTHWEST || mover.dir == SOUTHEAST || mover.dir == NORTHWEST || mover.dir == NORTHEAST)
				return 0
			return (get_dir(target,mover) != mover.dir)
		else return ..(mover,target,height,air_group)

	attackby(var/obj/item/I, var/mob/user)
		if(user!=inside && I.damtype=="brute" && I.force>=5)
			if(prob(20))
				inside.loc=loc
				if(isliving(inside))
					user.visible_message("\blue [user] breaks [inside] out of bronze with \the [I].", \
					"\blue You broke [inside] out of bronze with \the [I].",)
					inside.update_canmove()
				else
					user.visible_message("\blue [user] breaks \the [I].", \
					"\blue You broke \the [I].",)
				if (inside.client)
					inside.client.eye = inside.client.mob
					inside.client.perspective = MOB_PERSPECTIVE
				del(src)
				return
		return ..(I, user)

/obj/item/foameditem
	var/obj/item/inside

	proc/init(obj/item/A)
		name = "Bronzed [A.name]"
		desc = "It is [A.name], covered in bronze"
		var/icon/ico = build_composite_icon(A)
		var/icon/overl = new('icons/effects/effects.dmi',"ironfoam")
		ico.GrayScale()
		ico.Blend(overl,ICON_MULTIPLY)
		icon = ico
		inside = A
		A.loc = src
		w_class = A.w_class
		force = w_class

	attackby(var/obj/item/I, var/mob/user)
		if(I.damtype=="brute" && I.force>=5)
			if(prob(35))
				user.visible_message("\blue [user] breaks [inside] out of bronze with \the [I].", \
				"\blue You broke [inside] out of bronze with \the [I].",)
				inside.loc=loc
				del(src)
				return
		return ..(I, user)