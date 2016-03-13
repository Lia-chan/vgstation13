/obj/item/weapon/storage/box/seedbox
	name = "Seed bag"
	desc = "A biodegradable seed bag."
	var/obj/item/seeds/seedtype = null
	foldable = /obj/effect/decal/cleanable/dirt // wait what?
	can_hold = list("/obj/item/seeds") //When the bag has a kind of seed, this gets narrowed down to only that.
	icon = 'icons/obj/storage.dmi'
	icon_state = "evidence"

	New()
		..()
		pixel_x = rand(-10,10)
		pixel_y = rand(-10,0)

	update_icon()
		overlays = null
		if(contents.len)
			var/obj/item/seeds/S = contents[1]
			icon_state = "evidenceobj"
			overlays += image('icons/obj/seeds.dmi', icon_state=S.icon_state)
			seedtype = S.type
			can_hold = list("[S.type]")
			name = "Seed Bag ([S.plantname])"
		else
			icon_state = "evidence"
			name = "Seed Bag (Empty)"
			seedtype = null
			can_hold = list("/obj/item/seeds")