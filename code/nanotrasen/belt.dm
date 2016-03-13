// -------------------------------------
//     Bluespace Belt
// -------------------------------------


/obj/item/weapon/storage/belt/utility/bluespace
	name = "Tool-belt of Holding"
	desc = "The greatest in pants-supporting technology."
	storage_slots = 14
	max_w_class = 3
	max_combined_w_class = 28 // = 14 * 2, not 14 * 3.  This is deliberate
	origin_tech = "bluespace=4"
	can_hold = list(
		"/obj/item/weapon/crowbar",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/weldingtool",
		"/obj/item/weapon/wirecutters",
		"/obj/item/weapon/wrench",
		"/obj/item/weapon/cable_coil",
		"/obj/item/weapon/gun",
		"/obj/item/weapon/handcuffs",
		"/obj/item/weapon/reagent_containers/spray",
		"/obj/item/weapon/reagent_containers/hypospray",
		"/obj/item/weapon/storage/pill_bottle",
		"/obj/item/stack/medical",
		"/obj/item/device/multitool",
		"/obj/item/device/flashlight",
		"/obj/item/device/t_scanner",
		"/obj/item/device/analyzer",
		"/obj/item/device/healthanalyzer",
		"/obj/item/device/mass_spectrometer",
		"/obj/item/device/radio",
		"/obj/item/device/taperecorder")
	New()
		if(prob(5))
			//Sometimes people choose justice.
			//Sometimes justice chooses you.
			visible_message("That doesn't look like a normal Toolbelt of Holding...")
			new /obj/item/weapon/storage/belt/utility/bluespace/owlman(loc)
			del src
			return
		..()

	proc/failcheck(mob/user as mob)
		if (prob(src.reliability)) return 1 //No failure
		if (prob(src.reliability))
			user << "\red The Bluespace portal resists your attempt to add another item." //light failure
		else
			user << "\red The Bluespace generator malfunctions!"
			for (var/obj/O in src.contents) //it broke, delete what was in it
				del(O)
			crit_fail = 1

/obj/item/weapon/storage/belt/utility/bluespace/owlman
	name = "Owlman's tool-belt"
	desc = "Sometimes people choose justice.  Sometimes, justice chooses you..."
	storage_slots = 21
	max_w_class = 3
	max_combined_w_class = 42 //I don't think any of the below are actually weight class (3), and in any case, there shouldn't be room for lots of those
	origin_tech = "bluespace=4;syndicate=2"
	allow_quick_empty = 1
	can_hold = list(
		"/obj/item/weapon/crowbar",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/weldingtool",
		"/obj/item/weapon/wirecutters",
		"/obj/item/weapon/wrench",
		"/obj/item/device/multitool",
		"/obj/item/device/flashlight",
		"/obj/item/weapon/cable_coil",
		"/obj/item/device/t_scanner",
		"/obj/item/device/analyzer",
		"/obj/item/device/healthanalyzer",
		"/obj/item/device/mass_spectrometer",
		"/obj/item/device/pda",
		"/obj/item/weapon/dice",
		"/obj/item/weapon/gun",
		"/obj/item/weapon/extinguisher",
		"/obj/item/device/flash",
		"/obj/item/weapon/handcuffs",
		"/obj/item/weapon/reagent_containers/spray",
		"/obj/item/weapon/grenade",
		"/obj/item/weapon/reagent_containers/hypospray",
		"/obj/item/weapon/reagent_containers/bottle",
		"/obj/item/weapon/reagent_containers/glass/bottle",
		"/obj/item/weapon/reagent_containers/food/drinks/bottle/holywater",
		"/obj/item/weapon/storage/pill_bottle",
		"/obj/item/stack/medical",
		"/obj/item/device/radio",
		"/obj/item/clothing/mask", // Never be without it
		"/obj/item/clothing/under",
		"/obj/item/clothing/gloves",
		"/obj/item/weapon/hand_labeler", //FOR JUSTICE USE ONLY
		"/obj/item/device/taperecorder",
		"/obj/item/device/chameleon")
	New()
		..()
		new /obj/item/clothing/mask/gas/owl_mask(src)
		new /obj/item/clothing/under/owl(src)
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)



 // As a last resort, the belt can be used as a plastic explosive with a fixed timer (15 seconds).  Naturally, you'll lose all your gear...
 // Of course, it could be worse.  It could spawn a singularity!
/obj/item/weapon/storage/belt/utility/bluespace/owlman/afterattack(atom/target as obj|turf, mob/user as mob, flag)
	if (!flag)
		return
	if (istype(target, /turf/unsimulated) || istype(target, /turf/simulated/shuttle) || istype(target, /obj/item/weapon/storage) || istype(target, /obj/structure/table) || istype(target, /obj/structure/closet))
		return
	user << "Planting explosives..."
	user.visible_message("[user.name] is fiddling with their toolbelt.")
	if(ismob(target))
		user.attack_log += "\[[time_stamp()]\] <font color='red'> [user.real_name] tried planting [name] on [target:real_name] ([target:ckey])</font>"
		log_attack("<font color='red'> [user.real_name] ([user.ckey]) tried planting [name] on [target:real_name] ([target:ckey])</font>")
		user.visible_message("\red [user.name] is trying to strap a belt to [target.name]!")


	if(do_after(user, 50) && in_range(user, target))
		user.drop_item()
		target = target
		loc = null
		var/location
		if (isturf(target)) location = target
		if (ismob(target))
			target:attack_log += "\[[time_stamp()]\]<font color='orange'> Had the [name] planted on them by [user.real_name] ([user.ckey])</font>"
			user.visible_message("\red [user.name] finished planting an explosive on [target.name]!")
		target.overlays += image('icons/obj/assemblies.dmi', "plastic-explosive2")
		user << "You sacrifice your belt for the sake of justice. Timer counting down from 15."
		spawn(150)
			if(target)
				if(ismob(target) || isobj(target))
					location = target.loc // These things can move
				explosion(location, -1, -1, 2, 3)
				if (istype(target, /turf/simulated/wall)) target:dismantle_wall(1)
				else target.ex_act(1)
				if (isobj(target))
					if (target)
						del(target)
				if (src)
					del(src)
/obj/item/weapon/storage/belt/utility/bluespace/attack(mob/M as mob, mob/user as mob, def_zone)
	return

/obj/item/weapon/storage/belt/utility/bluespace/admin
	name = "Admin's Tool-belt"
	desc = "Because I'm not hunting through the damn station for this shit."
	storage_slots = 21
	max_w_class = 3
	max_combined_w_class = 63
	can_hold = list() // if there's no list it default to everything

	New()
		..()
		new /obj/item/weapon/crowbar(src)
		new /obj/item/weapon/screwdriver(src)
		new /obj/item/weapon/weldingtool/hugetank(src)
		new /obj/item/weapon/wirecutters(src)
		new /obj/item/weapon/wrench(src)
		new /obj/item/device/multitool(src)
		new /obj/item/weapon/cable_coil(src)

		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/dnainjector/xraymut(src)
		new /obj/item/weapon/dnainjector/firemut(src)
		new /obj/item/weapon/dnainjector/telemut(src)
		new /obj/item/weapon/dnainjector/hulkmut(src)
		new /obj/item/weapon/spellbook(src) // for smoke effects, door openings, etc

		var/obj/item/weapon/reagent_containers/hypospray/H = new(src)
		H.reagents.clear_reagents()
		H.reagents.add_reagent("adminordrazine",30)

//Research for the Bluespace Belt
datum/design/bluespace_belt
	name = "Experimental Bluespace Belt"
	desc = "An astonishingly complex belt popularized by a rich blue-space technology magnate."
	id = "bluespace_belt"
	req_tech = list("bluespace" = 4, "materials" = 6)
	build_type = PROTOLATHE
	materials = list("$gold" = 1500, "$diamond" = 3000, "$uranium" = 1000)
	reliability_base = 80
	build_path = "/obj/item/weapon/storage/belt/utility/bluespace"