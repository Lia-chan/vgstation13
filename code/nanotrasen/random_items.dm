// -------------------------------------
// Generates an innocuous toy
// -------------------------------------
/obj/item/toy/random
	name = "Random Toy"
	New()
		..()
		var/list/types = list(/obj/item/toy/crossbow,/obj/item/toy/balloon,/obj/item/toy/blink,/obj/item/toy/spinningtoy,/obj/item/toy/waterflower) + typesof(/obj/item/toy/prize) - /obj/item/toy/prize
		var/T = pick(types)
		new T(loc)
		spawn(1)
			del src

// -------------------------------------
//    Not yet identified chemical.
//        Could be anything!
// -------------------------------------

/obj/item/weapon/reagent_containers/glass/bottle/random_reagent
	name = "Unlabelled Bottle"
	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/bottle/B = new(loc)
		var/datum/reagent/R = pick(chemical_reagents_list)
		var/global/list/rare_chems = list("minttoxin","nanites","xenomicrobes","adminordrazine")
		if(R == "blood" && prob(50)) // in contrast to pills, it is entirely reasonable to have vials of virus-free blood lying around.
			var/datum/disease/advance/F = new(0) // By entirely reasonable I mean even odds.  Let's not get crazy, here.
			var/list/data = list("viruses"= list(F))
			B.reagents.add_reagent(R,B.volume,data)
		else
			if(rare_chems.Find(R))
				B.reagents.add_reagent(R,10)
			else
				B.reagents.add_reagent(R,rand(2,3)*10)
		B.name = "Unlabelled Bottle"
		B.identify_probability = 0
		B.pixel_x = rand(-10,10)
		B.pixel_y = rand(-10,10)
		spawn(1)
			del src

//Cuts out the food and drink reagents
/obj/item/weapon/reagent_containers/glass/bottle/random_chem
	name = "Unlabelled Chemical"
	New()
		var/global/list/chems_only = list("slimejelly","blood","water","lube","anti_toxin","toxin","cyanide","stoxin","stoxin2","inaprovaline","space_drugs","serotrotium","oxygen","copper","nitrogen","hydrogen","potassium","mercury","sulfur","carbon","chlorine","fluorine","sodium","phosphorus","lithium","sugar","sacid","pacid","glycerol","radium","ryetalyn","thermite","mutagen","virusfood","iron","gold","silver","uranium","aluminum","silicon","fuel","cleaner","plantbgone","plasma","leporazine","cryptobiolin","lexorin","kelotane","dermaline","dexalin","dexalinp","tricordrazine","synaptizine","impedrezene","hyronalin","arithrazine","alkysine","imidazoline","bicaridine","hyperzine","cryoxadone","clonexadone","spaceacillin","carpotoxin","zombiepowder","mindbreaker","fluorosurfactant","foaming_agent","nicotine","ethanol","ammonia","diethylamine","ethylredoxrazine","chloralhydrate","lipozine","condensedcapsaicin","frostoil","amatoxin","psilocybin","enzyme","nothing","doctorsdelight","antifreeze","neurotoxin")
		var/global/list/rare_chems = list("minttoxin","nanites","xenomicrobes","adminordrazine")

		var/obj/item/weapon/reagent_containers/glass/bottle/B = new(loc)
		var/datum/reagent/R = pick(chems_only + rare_chems)
		if(R == "blood" && prob(50))
			var/datum/disease/advance/F = new(0)
			var/list/data = list("viruses"= list(F))
			B.reagents.add_reagent(R,B.volume,data)
		else
			if(rare_chems.Find(R))
				B.reagents.add_reagent(R,10)
			else
				B.reagents.add_reagent(R,rand(2,3)*10)
		B.name = "Unlabelled Bottle"
		B.identify_probability = 0
		B.pixel_x = rand(-10,10)
		B.pixel_y = rand(-10,10)
		spawn(1)
			del src
/obj/item/weapon/reagent_containers/food/drinks/bottle/random_drink
	name = "Unlabelled Drink"
	New()
		var/list/drinks_only = list("beer2","hot_coco","orangejuice","tomatojuice","limejuice","carrotjuice","berryjuice","poisonberryjuice","watermelonjuice","lemonjuice","banana","nothing","potato","milk","soymilk","cream","coffee","tea","icecoffee","icetea","cola","nuka_cola","spacemountainwind","thirteenloko","dr_gibb","space_up","lemon_lime","beer","whiskey","specialwhiskey","gin","rum","vodka","holywater","tequilla","vermouth","wine","tonic","kahlua","cognac","hooch","ale","sodawater","ice","bilk","atomicbomb","threemileisland","goldschlager","patron","gintonic","cubalibre","whiskeycola","martini","vodkamartini","whiterussian","screwdrivercocktail","booger","bloodymary","gargleblaster","bravebull","tequillasunrise","toxinsspecial","beepskysmash","doctorsdelight","irishcream","manlydorf","longislandicedtea","moonshine","b52","irishcoffee","margarita","blackrussian","manhattan","manhattan_proj","whiskeysoda","antifreeze","barefoot","snowwhite","demonsblood","vodkatonic","ginfizz","bahama_mama","singulo","sbiten","devilskiss","red_mead","mead","iced_beer","grog","aloe","andalusia","alliescocktail","soy_latte","cafe_latte","acidspit","amasec","neurotoxin","hippiesdelight","bananahonk","silencer","changelingsting","irishcarbomb","syndicatebomb","erikasurprise","driestmartini")
		drinks_only += list("chloralhydrate","adminordrazine","mindbreaker","cyanide","tricordrazine","blood")

		var/obj/item/weapon/reagent_containers/food/drinks/bottle/B = new(loc)
		var/datum/reagent/R = pick(drinks_only)
		if(R == "blood" && prob(10)) // it's entirely natural for you to have blood in drinking bottles.
			var/datum/disease/advance/F = new(0) // it only rarely has to do with diseases.
			var/list/data = list("viruses"= list(F))
			B.reagents.add_reagent(R,B.volume,data)
		else
			B.reagents.add_reagent(R,B.volume)
		B.name = "Unlabelled Bottle"
		B.icon = 'icons/obj/drinks.dmi'
		B.icon_state = pick("alco-white","alco-green","alco-blue","alco-clear","alco-red")
		B.pixel_x = rand(-5,5)
		B.pixel_y = rand(-5,5)
		spawn(1)
			del src
/obj/item/weapon/reagent_containers/food/drinks/bottle/random_reagent // Same as the chembottle code except the container
	name = "Unlabelled Drink?"
	New()
		var/obj/item/weapon/reagent_containers/food/drinks/bottle/B = new(loc)
		var/datum/reagent/R = pick(chemical_reagents_list)
		var/global/list/rare_chems = list("minttoxin","nanites","xenomicrobes","adminordrazine")
		if(R == "blood" && prob(50))
			var/datum/disease/advance/F = new(0)
			var/list/data = list("viruses"= list(F))
			B.reagents.add_reagent(R,B.volume,data)
		else
			if(rare_chems.Find(R))
				B.reagents.add_reagent(R,10)
			else
				B.reagents.add_reagent(R,rand(3,10)*10)
		B.name = "Unlabelled Bottle"
		B.icon = 'icons/obj/drinks.dmi'
		B.icon_state = pick("alco-white","alco-green","alco-blue","alco-clear","alco-red")
		B.pixel_x = rand(-5,5)
		B.pixel_y = rand(-5,5)
		spawn(0)
			del src

/obj/item/weapon/storage/pill_bottle/random_meds
	name = "Unlabelled Pillbottle"
	desc = "The sheer recklessness of this bottle's existence astounds you."

	New()
		..()
		var/global/list/meds_only = list("blood","anti_toxin","toxin","cyanide","stoxin","stoxin2","inaprovaline","space_drugs","serotrotium","ryetalyn","mutagen","leporazine","cryptobiolin","lexorin","kelotane","dermaline","dexalin","dexalinp","tricordrazine","synaptizine","impedrezene","hyronalin","arithrazine","alkysine","imidazoline","bicaridine","hyperzine","spaceacillin","carpotoxin","zombiepowder","mindbreaker","nicotine","ethanol","ammonia","diethylamine","ethylredoxrazine","chloralhydrate","lipozine","condensedcapsaicin","frostoil","amatoxin","psilocybin","nothing","doctorsdelight","neurotoxin")
		var/global/list/rare_meds = list("nanites","xenomicrobes","minttoxin","adminordrazine")

		var/i = 1
		while(i < storage_slots)
			var/datum/reagent/R = pick(meds_only + rare_meds)
			var/obj/item/weapon/reagent_containers/pill/P = new(src)
			if(R == "blood") // 100% disease chance.  Why else would you make a blood pill?  I can think of nothing.
				var/datum/disease/advance/F = new(0)  // okay maybe vampires but that's about it
				var/list/data = list("viruses"= list(F))
				P.reagents.add_reagent(R,P.volume,data)
			else
				if(rare_meds.Find(R))
					P.reagents.add_reagent(R,10)
				else
					P.reagents.add_reagent(R,rand(2,5)*10)
			P.name = "Unlabelled Pill"
			P.desc = "Something about this pill entices you to try it, against your better judgement."
			i++
		pixel_x = rand(-10,10)
		pixel_y = rand(-10,10)
		return

// -------------------------------------
//    Containers full of unknown crap
// -------------------------------------

/obj/structure/closet/secure_closet/unknownchemicals
	name = "Unlabelled Chemical Closet"
	desc = "Potentially dangerous chemicals closet."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_broken = "medicalbroken"
	icon_off = "medicaloff"
	req_access = list(access_chemistry)

	New()
		..()
		sleep(2)
		new/obj/item/weapon/reagent_containers/glass/bottle/random_chem(src)
		new/obj/item/weapon/reagent_containers/glass/bottle/random_chem(src)
		new/obj/item/weapon/reagent_containers/glass/bottle/random_chem(src)
		new/obj/item/weapon/reagent_containers/glass/bottle/random_chem(src)
		new/obj/item/weapon/reagent_containers/glass/bottle/random_chem(src)
		while(prob(50))
			new/obj/item/weapon/reagent_containers/glass/bottle/random_reagent(src)

		new/obj/item/weapon/storage/pill_bottle/random_meds(src)
		while(prob(25))
			new/obj/item/weapon/storage/pill_bottle/random_meds(src)
		return

/obj/structure/closet/secure_closet/random_drinks
	name = "Unlabelled Booze"
	req_access = list(access_bar)
	icon_state = "cabinetdetective_locked"
	icon_closed = "cabinetdetective"
	icon_locked = "cabinetdetective_locked"
	icon_opened = "cabinetdetective_open"
	icon_broken = "cabinetdetective_broken"
	icon_off = "cabinetdetective_broken"

	New()
		..()
		sleep(2)
		new/obj/item/weapon/reagent_containers/food/drinks/bottle/random_drink(src)
		new/obj/item/weapon/reagent_containers/food/drinks/bottle/random_drink(src)
		new/obj/item/weapon/reagent_containers/food/drinks/bottle/random_drink(src)
		new/obj/item/weapon/reagent_containers/food/drinks/bottle/random_drink(src)
		new/obj/item/weapon/reagent_containers/food/drinks/bottle/random_drink(src)
		while(prob(25))
			new/obj/item/weapon/reagent_containers/food/drinks/bottle/random_reagent(src)
		return

/datum/supply_packs/randomised/chemicals
	name = "Grey-market Chemicals Grab Pack"
	num_contained = 6
	contains = list(/obj/item/weapon/reagent_containers/glass/bottle/random_reagent,
					/obj/item/weapon/reagent_containers/glass/bottle/random_chem,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/random_drink,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/random_reagent,
					/obj/item/weapon/storage/pill_bottle/random_meds)
	cost = 100
	containertype = /obj/structure/closet/crate/secure
	containername = "Unregulated Chemicals Crate"
	access = access_chemistry
	contraband = 1

	New()
		manifest += "<ul>"
		manifest += "<li> [num_contained] bottles of unregulated chemicals </li>"
		manifest += "</ul>"


// -------------------------------------
//          Do not order this.
//  If you order this, do not open it.
//        If you open this, run.
//       If you didn't run, pray.
// -------------------------------------

/obj/structure/largecrate/evil
	name = "\improper Mysterious Crate"
	desc = "What could it be?"

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/crowbar))
			var/list/menace = pick(	/mob/living/simple_animal/hostile/carp,/mob/living/simple_animal/hostile/faithless,/mob/living/simple_animal/hostile/pirate,
									/mob/living/simple_animal/hostile/creature,/mob/living/simple_animal/hostile/pirate/ranged,/mob/living/simple_animal/hostile/retaliate/clown,
									/mob/living/simple_animal/hostile/hivebot,/mob/living/simple_animal/hostile/viscerator,/mob/living/simple_animal/hostile/pirate)

			visible_message("\red Something falls out of the [src]!")
			var/obj/item/weapon/grenade/flashbang/clusterbang/C = new(src.loc)
			C.activate()
			spawn(10)
				new menace(src.loc)
				while(prob(15))
					new menace(get_step_rand(src.loc))
				..()
		else
			..()

/datum/supply_packs/evil
	name = "Evil Incorporated(R) Crate of Evil(TM)"
	contains = list()
	cost = 200
	containertype = /obj/structure/largecrate/evil
	containername = "large crate"
	hidden = 1
	New()
		manifest = "<ul><li>Love, sunshine, and perfect happiness.</li></ul>"


//
//
//                   ???
//
//

/obj/structure/largecrate/schrodinger
	name = "Schrodinger's Box"
	desc = "What happens if you open it?"

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/crowbar))
			var/mob/living/simple_animal/cat/Cat1 = new(src)
			Cat1.apply_damage(200)//,TOX)
			Cat1.name = "Schrodinger's Cat"
			Cat1.desc = "It seems it's been dead for a while."
			Cat1.loc = loc

			var/mob/living/simple_animal/cat/Cat2 = new(loc)
			Cat2.name = "Schrodinger's Cat"
			Cat2.desc = "It's was alive the whole time!"
			sleep(2)
			if(prob(50))
				del Cat1
			else
				del Cat2
		..()


/obj/effect/decal/cleanable/random
	name = "Random Mess"
	New()
		var/list = typesof(/obj/effect/decal/cleanable) - list(/obj/effect/decal/cleanable,/obj/effect/decal/cleanable/random,/obj/effect/decal/cleanable/cobweb,/obj/effect/decal/cleanable/cobweb2)
		var/T = pick(list)
		new T(loc)
		spawn(0)
			del src