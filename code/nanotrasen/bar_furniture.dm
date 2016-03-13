/obj/structure/stool/stool_bar
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/nanotrasen/stool.dmi'
	icon_state = "bar_stool"
	anchored = 1.0
	flags = FPRINT
	pressure_resistance = 15


/obj/structure/stool/stool_bar/ex_act(severity)
	switch(severity)
		if(1.0 || (2.0 && prob(50)) || (3.0 && prob(5)))
			del(src)


/obj/structure/stool/stool_bar/blob_act()
	if(prob(75))
		new /obj/item/stack/sheet/metal(src.loc)
		del(src)


obj/structure/stool/stool_bar/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/stack/sheet/metal(src.loc)
		del(src)