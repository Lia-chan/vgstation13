//Mon^W PONY Overlays Indexes////////
#define M_MASK_LAYER			1
#define M_BACK_LAYER			2
#define M_HANDCUFF_LAYER		3
#define M_L_HAND_LAYER			4
#define M_R_HAND_LAYER			5
#define M_TOTAL_LAYERS			5
/////////////////////////////////

//#define ui_pony_mask "5:14,1:5"
//#define ui_pony_back "6:14,1:5"
//#define ui_monkey_mask "5:14,1:5"	//monkey
//#define ui_monkey_back "6:14,1:5"	//monkey
//#define ui_rhand "7:16,1:5"
//#define ui_lhand "8:16,1:5"

/mob/living/carbon/monkey/pony
	name = "Pony"
	desc = "Known for their friendliness"
	voice_message = "neighs"
	say_message = "neighs"
	icon_state = "twilight"
	icon = 'icons/nanotrasen/mlp.dmi'
	see_in_dark = 6
	var/datum/reagents/udder = null
	var/backbag = 1
	gender = FEMALE

/mob/living/carbon/monkey/pony/New()
	udder = new(50)
	udder.my_atom = src
	..()

/mob/living/carbon/monkey/pony/update_icons()
	update_hud()
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again
	overlays.Cut()
	//var/icon/O = new(initial(icon), initial(icon_state))
	if(lying)
		icon_state = initial(icon_state)
		for(var/image/I in overlays_lying)
			overlays += I
	else
		icon_state = initial(icon_state)
		for(var/image/I in overlays_standing)
			overlays += I

/mob/living/carbon/monkey/pony/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(stat == CONSCIOUS && istype(O, /obj/item/weapon/reagent_containers/glass))
		user.visible_message("<span class='notice'>[user] milks [src] using \the [O].</span>")
		var/obj/item/weapon/reagent_containers/glass/G = O
		var/transfered = udder.trans_id_to(G, "milk", rand(5,10))
		if(G.reagents.total_volume >= G.volume)
			user << "\red The [O] is full."
		if(!transfered)
			user << "\red The udder is dry. Wait a bit longer..."
	else
		..()


/mob/living/carbon/monkey/pony/update_inv_wear_mask(var/update_icons=1)
	if( wear_mask && istype(wear_mask, /obj/item/clothing/mask) )
		overlays_lying[M_MASK_LAYER]	= image("icon" = 'icons/nanotrasen/mlp.dmi', "icon_state" = "pony_breathmask")
		overlays_standing[M_MASK_LAYER]	= image("icon" = 'icons/nanotrasen/mlp.dmi', "icon_state" = "pony_breathmask")
		wear_mask.screen_loc = ui_monkey_mask
	else
		overlays_lying[M_MASK_LAYER]	= null
		overlays_standing[M_MASK_LAYER]	= null
	if(update_icons)		update_icons()


/mob/living/carbon/monkey/pony/update_inv_back(var/update_icons=1)
	if(back)
		var/back_icon
		if( istype(back, /obj/item/weapon/storage/backpack) )
			if( backbag>=3 ) // 3 and 4 - satchel and satchel alt
				back_icon = "pony_satchel"
			else
				back_icon = "pony_blackpack"
		else if( istype(back, /obj/item/weapon/tank/oxygen/red) )
			back_icon = "pony_oxyfire"
		else if( istype(back, /obj/item/weapon/tank/air) || istype(back, /obj/item/weapon/tank/oxygen))
			back_icon = "pony_oxygen"
		else if( istype(back, /obj/item/weapon/tank/jetpack) )
			back_icon = "pony_jetpack"
		overlays_lying[M_BACK_LAYER]	= image("icon" = 'icons/nanotrasen/mlp.dmi', "icon_state" = back_icon)
		overlays_standing[M_BACK_LAYER]	= image("icon" = 'icons/nanotrasen/mlp.dmi', "icon_state" = back_icon)
		back.screen_loc = ui_monkey_back
	else
		overlays_lying[M_BACK_LAYER]	= null
		overlays_standing[M_BACK_LAYER]	= null
	if(update_icons)		update_icons()

/mob/living/carbon/monkey/pony/update_inv_r_hand(var/update_icons=1)
	if(r_hand)
		r_hand.screen_loc = ui_rhand
		if (handcuffed) drop_r_hand()
	if(update_icons)		update_icons()

/mob/living/carbon/monkey/pony/update_inv_l_hand(var/update_icons=1)
	if(l_hand)
		l_hand.screen_loc = ui_lhand
		if (handcuffed) drop_l_hand()
	if(update_icons)		update_icons()

/mob/living/carbon/monkey/pony/update_inv_handcuffed(var/update_icons=1)
	if(handcuffed)
		drop_r_hand()
		drop_l_hand()
		stop_pulling()
	if(update_icons)		update_icons()


/mob/living/carbon/monkey/pony/Life()
	. = ..()
	if(stat == CONSCIOUS)
		if(udder && prob(5))
			udder.add_reagent("milk", rand(5, 10))

/mob/living/carbon/monkey/pony/twilight
	name = "Twilight Sparkle"
	icon_state = "twilight"
/mob/living/carbon/monkey/pony/pinkie
	name = "Pinkie Pie"
	icon_state = "pinkie"
/mob/living/carbon/monkey/pony/rainbow
	name = "Rainbow Dash"
	icon_state = "rainbow"
/mob/living/carbon/monkey/pony/fluttershy
	name = "Fluttershy"
	icon_state = "fluttershy"
/mob/living/carbon/monkey/pony/applejack
	name = "Applejack"
	icon_state = "applejack"
/mob/living/carbon/monkey/pony/lyra
	name = "Lyra Heartstrings"
	icon_state = "lyra"
/mob/living/carbon/monkey/pony/vinyl
	name = "Vinyl Scratch"
	icon_state = "vinyl"
/mob/living/carbon/monkey/pony/rarity
	name = "Rarity"
	icon_state = "rarity"
/mob/living/carbon/monkey/pony/whooves
	name = "Time Turner"
	icon_state = "whooves"
/mob/living/carbon/monkey/pony/fleur
	name = "Fleur"
	icon_state = "fleur"
/mob/living/carbon/monkey/pony/mac
	name = "Big Mac"
	icon_state = "mac"
/mob/living/carbon/monkey/pony/princess/tia
	name = "Princess Celestia"
	icon_state = "tia"
/mob/living/carbon/monkey/pony/princess/luna
	name = "Princess Luna"
	icon_state = "luna"

/mob/living/carbon/monkey/pony/scroll
	name = "Scroll Deliever"
	icon_state = "scroll"

/mob/living/carbon/human/var/ponyizing = 0
/mob/living/carbon/human/proc/ponyize()
	if (ponyizing)
		return
	for(var/obj/item/W in src)
		if (W==w_uniform) // will be torn
			continue
		drop_from_inventory(W)
	invisibility = INVISIBILITY_MAXIMUM
	regenerate_icons()
	ponyizing = 1
	canmove = 0
	stunned = 1
	//icon = null


	var/atom/movable/overlay/animation = new /atom/movable/overlay( loc )
	animation.icon_state = "blank"
	animation.icon = 'icons/mob/mob.dmi'
	animation.master = src
	flick("dust-h", animation)
	sleep(48)
	//animation = null
	var/newpony = pick(/mob/living/carbon/monkey/pony/twilight, /mob/living/carbon/monkey/pony/pinkie, /mob/living/carbon/monkey/pony/rainbow, /mob/living/carbon/monkey/pony/princess/luna, /mob/living/carbon/monkey/pony/fluttershy, /mob/living/carbon/monkey/pony/princess/tia, /mob/living/carbon/monkey/pony/applejack, /mob/living/carbon/monkey/pony/lyra, /mob/living/carbon/monkey/pony/vinyl, /mob/living/carbon/monkey/pony/rarity, /mob/living/carbon/monkey/pony/whooves, /mob/living/carbon/monkey/pony/fleur, /mob/living/carbon/monkey/pony/mac)
	var/mob/living/carbon/monkey/pony/O = new newpony(loc)
	del(animation)

	//O.name = "monkey"
	O.backbag = backbag //Backpack type preference
	O.dna = dna
	dna = null
	O.dna.uni_identity = "00600200A00E0110148FC01300B009000"
	O.dna.struc_enzymes = "[copytext(O.dna.struc_enzymes,1,1+3*(STRUCDNASIZE-1))]FD6"
	O.loc = loc
	O.viruses = viruses
	viruses = list()
	for(var/datum/disease/D in O.viruses)
		D.affected_mob = O

	if (client)
		client.mob = O
	if(mind)
		mind.transfer_to(O)
	O.a_intent = "help" //Friendship is magic!
	O << "<B>You are now a pony!</B>"

	for(var/t in src.organs)
		del(t)
	spawn(0)//To prevent the proc from returning null.
		del(src)
	return O

/proc/ispony(A)
	if(istype(A, /mob/living/carbon/monkey/pony))
		return 1
	return 0