/obj/item/weapon/gun/projectile/automatic/c20r
	name = "\improper AK-331"
	desc = "Bad-ass Russkie's gun"
	icon = 'icons/nanotrasen/ntguns.dmi'
	icon_state = "ak331"
	item_state = "ak331"
	w_class = 3.0
	max_shells = 30
	caliber = "12mm"
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/a12mm"
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	load_method = 2


	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/a12mm/empty(src)
		update_icon()
		return


	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && empty_mag)
			empty_mag.loc = get_turf(src.loc)
			empty_mag = null
			playsound(user, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
			update_icon()
		return