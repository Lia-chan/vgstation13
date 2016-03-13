
// Ass, masturbate and other stuff a-la D2K5

/obj/item/weapon/reagent_containers/food/snacks/human/ass //yes, this is the same as meat. I might do something different in future
	name = "ass"
	desc = "A human ass. Its made of meat."
	icon = 'icons/nanotrasen/ass_stuff.dmi'
	icon_state = "ass"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		src.bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/human/assburger
	name = "Assburger"
	desc = "A bloody assburger."
	icon = 'icons/nanotrasen/ass_stuff.dmi'
	icon_state = "assburger"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2

/datum/recipe/human/assburger
	reagents = list("flour" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/human/ass
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/human/assburger


/mob/var/masturbating = 0
/mob/var/has_ass = 1
/mob/living/carbon/human/verb/masturbate()
	set name = "Masturbate Onto"
	set category = "IC"
	set hidden = 0

	if (!src)
		world.log << "DEBUG: The VOID tried to masturbate!"
		return

	if (!ticker)
		src << "You canot masturbate before the game starts!"
		return

	if (!src.loc)
		src << "You are nowhere. You cannot masturbate."
		return

	if (!has_ass)
		src << "You already lost your ass doing this."
		return

	if (masturbating>0)
		src << "You're already masturbating! Be patient!"
		return

	src.masturbating = 1

	var/list/dest = list() //List of possible targets(mobs)
	var/target = null	   //Chosen target.

	for(var/mob/living/M in view(src.loc))
		dest += M

	if (dest.len<1)
		src << "There is no one here to masturbate." //Not happens - you can always masturbate to yourself!
		src.masturbating = 0
		return

	target = input("Please, select a target!", "Masturbate onto", null, null) as null|anything in dest

	if (!target)//Make sure we actually have a target
		src.masturbating = 0
		return
	else
		src.masturbating = 2
		src.visible_message("[src] just starts masturbating onto [target]!","You start masturbating onto [target].","You hear some cyclic noise around. It sounds like \"fap-fap-fap\"...")
		sleep(20)
		src << "Suddently your ass becomes loose..."
		sleep(20)
		src << "\red After another powerful friction, your ass fell apart from body!"
		src.visible_message("[src] just loses an ass!","\red After another powerful friction, your ass fell apart from body!")
		playsound(src.loc,'aargh.ogg',50,1)
		var/obj/item/yourass = new /obj/item/weapon/reagent_containers/food/snacks/human/ass(src.loc)
		if (!src.put_in_any_hand_if_possible(yourass,0))
			src << "Your hands are full, you can't hold your ass."
		src.has_ass = 0
		spawn(20)
			src.masturbating = 0
			playsound(src.loc,'sadtrombone.ogg',40,1)

