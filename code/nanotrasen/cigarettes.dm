/obj/item/weapon/storage/fancy/cigarettes/vogue
	name = "Vogue Menthe"
	desc = "A packet of six imported Vogue Menthe cigarettes. A label on the packaging reads, \"Wouldn't a slow death make a change?\""
	icon = 'icons/nanotrasen/ncigarettes.dmi'
	icon_state = "vogue"
	item_state = "vogue"

/*

/obj/item/weapon/storage/fancy/cigarettes/deluxe
	name = "Ultra-Deluxe Cigar Packet"
	desc = "A packet of six Ultra-Deluxe Cigars"
	icon = 'icons/nanotrasen/ncigarettes.dmi'
	icon_state = "cigarpacket"
	item_state = "cigarpacket"
	can_hold = list("/obj/item/clothing/mask/cigarette/cigar/deluxe")

/obj/item/weapon/storage/fancy/cigarettes/deluxe/New()
	flags |= NOREACT
	for(var/i = 1 to storage_slots)
		new /obj/item/clothing/mask/cigarette/cigar/deluxe(src)
	create_reagents(15 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one

/obj/item/clothing/mask/cigarette/cigar/deluxe
	name = "Ultra-Deluxe Cigar"
	desc = "Best tobacco, at least on this station"
//	icon = 'icons/nanotrasen/ncigarettes.dmi'
	icon_state = "cigar3off"
	icon_on = "cigar3on"
	icon_off = "cigar3off"
	smoketime = 7200
	chem_volume = 30
*/