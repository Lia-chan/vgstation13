/obj/item/weapon/weed_paper
	name = "Weed Paper"
	desc = "Paper with some weed poured on it."
	icon = 'icons/nanotrasen/joint.dmi'
	icon_state = "weed_paper"
	item_state = "paper"

	New()
		create_reagents(10)

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/reagent_containers/food/snacks/grown))
			var/obj/item/weapon/reagent_containers/food/snacks/grown/G = W
			if(G.reagents && (G.reagents.has_reagent("space_drugs") || G.reagents.has_reagent("psilocybin")))
				G.reagents.del_reagent("nutriment")
				if(G.reagents.has_reagent("toxin"))
					G.reagents.remove_reagent("toxin",G.reagents.get_reagent_amount("toxin")*0.6)
				if(G.reagents.has_reagent("synaptizine"))
					G.reagents.remove_reagent("synaptizine",G.reagents.get_reagent_amount("synaptizine")*0.6)
				if(reagents.maximum_volume-reagents.total_volume<G.reagents.total_volume)
					reagents.maximum_volume = reagents.total_volume + G.reagents.total_volume
				G.reagents.trans_to(src,G.reagents.total_volume)
				desc = initial(desc)+" There are [reagents.total_volume] units of stuff."
				user.u_equip(W)
				del(W)

	attack_self(mob/user as mob)
		if(reagents.total_volume>0)
			var/obj/item/clothing/mask/cigarette/samokrutka/S = new(src.loc)
			user << "You roll an [S] from the paper."
			reagents.my_atom = S
			S.reagents = reagents
			S.chem_volume = reagents.total_volume
			reagents = null
			user.u_equip(src)
			user.put_in_hands(S)
			del(src)

/obj/item/clothing/mask/cigarette/samokrutka
	name = "Amp joint"
	desc = "Hand rolled weed 'cigar'."
	icon = 'icons/nanotrasen/joint.dmi'
	var/item_icon = 'icons/nanotrasen/joint.dmi'
	icon_state = "samokrutkaoff"
	icon_on = "samokrutkaon"
	smoketime = 120

	proc/put_out()
		if(istype(loc,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = loc
			H.u_equip(src)
			H.update_inv_l_hand()
			H.update_inv_r_hand()
			H.update_inv_wear_mask()
		del(src)

	process()
		if(reagents.total_volume > 24 && prob(20))
			var/datum/effect/effect/system/chem_smoke_spread/smoke = new
			var/num = 0
			var/amnt = reagents.total_volume
			while(amnt>24 && prob(80))
				amnt -= 15
				num++
			var/datum/reagents/tosmoke = new(num*5)
			reagents.trans_to(tosmoke,num*2,5)
			smoke.set_up(tosmoke,min(1,num),0,get_turf(src),0,1)
			smoke.start()
		..()
