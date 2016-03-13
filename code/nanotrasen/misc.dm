// -------------------------------------
//     Movable vending machines hack
// -------------------------------------

/obj/machinery/vending/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I,/obj/item/weapon/crowbar))
		if(istype(src,/obj/machinery/vending/wallmed1) || istype(src,/obj/machinery/vending/wallmed2))
			..()
			return
		if(anchored)
			playsound(src.loc, 'sound/items/Crowbar.ogg', 80, 1)
			user << "You struggle to pry the vending machine up off the floor."
			if(do_after(user, 40))
				user.visible_message( \
					"[user] lifts \the [src], which clicks.", \
					"\blue You have lifted \the [src], and wheels dropped into place underneath. Now you can pull it safely.", \
					"You hear a scraping noise and a click.")
				anchored = 0
		else
			user.visible_message( \
					"[user] pokes \his crowbar under \the [src], which settles with a loud bang", \
					"\blue You poke the crowbar at \the [src]'s wheels, and they retract.", \
					"You hear a scraping noise and a loud bang.")
			anchored = 1
			power_change()
		return
	..()

/obj/machinery/vending/attack_hand(mob/user as mob)
	if(!anchored)
		power_change()
	..()
/obj/machinery/vending/Topic(href, href_list)
	if(!anchored)
		power_change()
	..()



// -------------------------------------
//			Lizard pet
// -------------------------------------
/mob/living/simple_animal/lizard/professor
	name = "The Professor"
	desc = "A remarkably booksmart reptile."
	gender = "male"
	melee_damage_upper = 0
	friendly = "flicks his tongue at"
	emote_see = list("looks around slowly","takes stock of the bookshelves","tastes the air","sits placidly", "judges you silently")

// -------------------------------------
//			False walls hide doors
// -------------------------------------
/obj/structure/falserwall
	layer = 3.2
/obj/structure/falsewall
	layer = 3.2

// -------------------------------------
//			Soapmaking
// See also:
//  game/objects/weapons/clown_items.dm
// -------------------------------------

/datum/chemical_reaction/soap
	name = "Soap"
	id = "soap"
	result = null
	required_reagents = list("ammonia" = 5, "cornoil" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10
	on_reaction(var/datum/reagents/holder, var/created_volume)
		var/location = get_turf(holder.my_atom)
		var/number_of_bars = rand(1,round(created_volume / 10))
		var/average_volume = round(created_volume / number_of_bars)
		while(number_of_bars>0)
			var/obj/item/weapon/soap/S = new(location)
			S.uses = average_volume
			S.pixel_x = rand(-10,10)
			S.pixel_y = rand(-10,10)
			number_of_bars--
		return

/obj/item/weapon/storage/pill_bottle/methylphenidate
	name = "Methylphenidate pills"
	desc = "Improves the ability to concentrate."

/obj/item/weapon/storage/pill_bottle/methylphenidate/New()
	..()
	new /obj/item/weapon/reagent_containers/pill/methylphenidate( src )
	new /obj/item/weapon/reagent_containers/pill/methylphenidate( src )
	new /obj/item/weapon/reagent_containers/pill/methylphenidate( src )
	new /obj/item/weapon/reagent_containers/pill/methylphenidate( src )
	new /obj/item/weapon/reagent_containers/pill/methylphenidate( src )
	new /obj/item/weapon/reagent_containers/pill/methylphenidate( src )
	new /obj/item/weapon/reagent_containers/pill/methylphenidate( src )


/obj/item/weapon/storage/pill_bottle/citalopram
	name = "Citalopram pills"
	desc = "Mild anti-depressant."

/obj/item/weapon/storage/pill_bottle/citalopram/New()
	..()
	new /obj/item/weapon/reagent_containers/pill/citalopram( src )
	new /obj/item/weapon/reagent_containers/pill/citalopram( src )
	new /obj/item/weapon/reagent_containers/pill/citalopram( src )
	new /obj/item/weapon/reagent_containers/pill/citalopram( src )
	new /obj/item/weapon/reagent_containers/pill/citalopram( src )
	new /obj/item/weapon/reagent_containers/pill/citalopram( src )
	new /obj/item/weapon/reagent_containers/pill/citalopram( src )