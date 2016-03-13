// TODO: Move to food/snacks/sliceable
/obj/item/weapon/reagent_containers/food/snacks/nyancake
	name = "Nyancake"
	desc = "A rainbow cake with nekomimi on top. It looks so delicious and kawaii! :3"
	icon = 'icons/nanotrasen/ntfood.dmi'
	icon_state = "nyancake"
	//slice_path = /obj/item/weapon/reagent_containers/food/snacks/nyancakeslice //TODO
	//slices_num = 5
	trash = /obj/item/trash/plate
	New()
		..()
		reagents.add_reagent("nutriment", 20)
		reagents.add_reagent("sprinkles", 2)
		reagents.add_reagent("nyan_concentrate", 20)
		bitesize = 2

/*
TODO: Add 6 color slices
/obj/item/weapon/reagent_containers/food/snacks/nyancakeslice
	name = "NyanCake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon = 'icons/nanotrasen/ntfood.dmi'
	icon_state = "nyancake_slice"
	trash = /obj/item/trash/plate
	bitesize = 2
*/
/datum/recipe/nyancake
	reagents = list("milk" = 5, "flour" = 15)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/clothing/head/kitty,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/nyancake


/datum/reagent/nyan
	name = "Nyan concentrate"
	id = "nyan_concentrate"
	description = "Essence of kawaii and nyan~"
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132

	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		if(isturf(M.loc)) //&& !istype(M.loc, /turf/space)
			if(M.canmove)
				var/turf/location = M.loc
				if (istype(location, /turf/simulated))
					location.add_nyan_floor(src)
				//M << ":3"
				//playsound(location,'nyantune.ogg',50,1) //TODO: make not repeatable
		//if(prob(7)) M.emote("nyan")

		//holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
		..()
		return

/obj/effect/decal/cleanable/nyanrainbow
	name = "nyan"
	desc = "It's rainbow and nyan."
	gender = PLURAL
	density = 0
	anchored = 1
	layer = 2
	icon = 'icons/nanotrasen/ntdecals.dmi'
	icon_state = "nyan"
	//random_icon_states = list("nyan1", "nyan2")

/obj/effect/decal/cleanable/nyanrainbow/Del()
	..()

/obj/effect/decal/cleanable/nyanrainbow/New()
	..()
	if(src.type == /obj/effect/decal/cleanable/nyanrainbow)
		if(src.loc && isturf(src.loc))
			for(var/obj/effect/decal/cleanable/nyanrainbow/B in src.loc)
				if(B != src)
					del(B)

/atom/proc/add_nyan_floor(mob/living/carbon/M as mob)
	if(istype(src, /turf/simulated))
		new /obj/effect/decal/cleanable/nyanrainbow(src)