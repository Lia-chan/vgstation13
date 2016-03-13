/obj/machinery/vending/omskvend
	name = "Omsk-o-mat"
	desc = "Drug dispenser."
	icon = 'icons/nanotrasen/omskvend.dmi'
	icon_state = "omskvend"
	product_ads = "NORKOMAN SUKA SHTOLE?;STOP NARTCOTICS!; so i heard u liek mudkipz; METRO ZATOPEELO"
	products = list(/obj/item/device/healthanalyzer = 5, /obj/item/weapon/reagent_containers/pill/fluff/listermed = 20, /obj/item/weapon/reagent_containers/pill/tramadol = 20, /obj/item/weapon/reagent_containers/pill/happy = 20, /obj/item/weapon/reagent_containers/pill/zoom = 20, /obj/item/weapon/reagent_containers/glass/beaker/LSD = 20, /obj/item/weapon/reagent_containers/pill/LSD = 20, /obj/item/clothing/mask/cigarette/samokrutka = 20)
	contraband = list(/obj/item/weapon/reagent_containers/glass/bottle/antitoxin = 4)

/obj/item/weapon/reagent_containers/pill/LSD
	name = "LSD"
	desc = "Ahaha oh wow."
	icon_state = "pill9"
	New()
		..()
		reagents.add_reagent("mindbreaker", 50)

/obj/item/weapon/reagent_containers/glass/beaker/LSD
	name = "LSD IV"
	desc = "Ahaha oh wow."
	New()
		..()
		reagents.add_reagent("mindbreaker", 30)
		update_icon()
