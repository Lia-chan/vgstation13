/obj/item/weapon/grenade/chem_grenade/meat
	name = "Meat Grenade"
	desc = "Not always as messy as the name implies."
	stage = 2
	path = 1

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("blood",60)
		if(prob(5))
			B1.reagents.add_reagent("blood",1) // Quality control problems, causes a big mess
		B2.reagents.add_reagent("clonexadone",30)

		beakers += B1
		beakers += B2
		icon_state = "grenade"

//Adapted from grenade/flashbang/clusterbang
/obj/item/weapon/grenade/clusterbuster
	desc = "This highly intimidating bunch of hardware seems eager to be let loose."
	name = "Clusterbang"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "clusterbang"
	var/payload = /obj/item/weapon/grenade/flashbang


// Subtypes

/obj/item/weapon/grenade/clusterbuster/meat
	name = "Mega Meat Grenade"
	payload = /obj/item/weapon/grenade/chem_grenade/meat

/obj/item/weapon/grenade/clusterbuster/activate()
	var/numspawned = rand(4,8)
	var/again = 0
	for(var/more = numspawned,more > 0,more--)
		if(prob(35))
			again++
			numspawned --

	for(,numspawned > 0, numspawned--)
		spawn(0)
			new /obj/item/weapon/grenade/clusterbuster/node(src.loc,payload)//Launches payload
			playsound(src.loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)

	for(,again > 0, again--)
		spawn(0)
			new /obj/item/weapon/grenade/clusterbuster/segment(src.loc,payload)//Creates a 'segment' that launches more payloads
			playsound(src.loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)
	spawn(0)
		del(src)
		return

/obj/item/weapon/grenade/clusterbuster/segment
	desc = "What's happening? Aaah!"
	name = "clusterbuster segment"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "clusterbang_segment"

/obj/item/weapon/grenade/clusterbuster/segment/New(var/turf/newloc,var/T)//Segments should never exist except part of the clusterbang, since these immediately 'do their thing' and asplode
	icon_state = "clusterbang_segment_active"
	active = 1
	payload = T
	var/stepdist = rand(1,4)		//How far to step
	var/temploc = src.loc			//Saves the current location to know where to step away from
	walk_away(src,temploc,stepdist)	//I must go, my people need me
	var/dettime = rand(15,60)
	spawn(dettime)
		activate()
	..()

/obj/item/weapon/grenade/clusterbuster/segment/activate()
	var/numspawned = rand(4,8)
	for(var/more = numspawned,more > 0,more--)
		if(prob(35))
			numspawned --

	for(,numspawned > 0, numspawned--)
		spawn(0)
			new /obj/item/weapon/grenade/clusterbuster/node(src.loc,payload)
			playsound(src.loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)
	spawn(0)
		del(src)
		return

/obj/item/weapon/grenade/clusterbuster/node/New(var/turf/newloc,var/T)
	spawn(0)
		icon_state = "flashbang_active"
		active = 1
		payload = T
		var/stepdist = rand(1,3)
		var/temploc = src.loc
		walk_away(src,temploc,stepdist)
		var/dettime = rand(15,60)
		spawn(dettime)
			var/atom/A = new payload(loc)
			if(istype(A,/obj/item/weapon/grenade))
				A:activate()
			del src
	..()