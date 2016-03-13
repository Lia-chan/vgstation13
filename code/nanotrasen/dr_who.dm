/obj/structure/closet/tardis
	name = "TARDIS"
	desc = "It looks alien!"
	icon = 'icons/nanotrasen/tardis.dmi'
	icon_state = "tardis_closed"
	icon_closed = "tardis_closed"
	icon_opened = "tardis_open"

	New()
		..()
		icon_state = "tardis_phase"
		spawn(30)
			if(opened)
				icon_state = icon_opened
			else
				icon_state = icon_closed


// icon = 'icons/nanotrasen/doctorsstuff.dmi'