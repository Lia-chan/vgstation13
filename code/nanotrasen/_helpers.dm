/proc/build_composite_icon_omnidir(atom/A)
        var/icon/composite = icon('icons/effects/effects.dmi', "icon_state"="nothing")
        for(var/O in A.underlays)
                var/image/I = O
                composite.Blend(new/icon(I.icon, I.icon_state), ICON_OVERLAY)
        var/icon/ico_omnidir = new(A.icon)
        if(A.icon_state in ico_omnidir.IconStates())
                composite.Blend(new/icon(ico_omnidir, A.icon_state), ICON_OVERLAY)
        else
                composite.Blend(new/icon(ico_omnidir, null), ICON_OVERLAY)
        for(var/O in A.overlays)
                var/image/I = O
                composite.Blend(new/icon(I.icon, I.icon_state), ICON_OVERLAY)
        return composite

/proc/leadingzero(num, placevalue = 2) //BYOND cannot output int with leading zeros. What a shame!
	var/leading_zeroes = "[num < 0 ? "-" : ""]";
	num = abs(num)

	while(num < (10**placevalue))
		placevalue -= 1
		leading_zeroes += "0"
	return "[leading_zeroes][num]"

/*
/datum/game_mode/proc/randomchems()
	//var/obj/item/weapon/chem/random1
	//var/obj/item/weapon/chem/random2
	//var/obj/item/weapon/chem/random3
	//var/obj/item/weapon/chem/random4
	var/deux
	var/tres
	var/quatre
//	restart
	var/home = rand(100,300) // picks the long range relays angle.
	var/random1 = pick("potassium","chlorine","oxygen","nitrogen","hydrogen","carbon","water","acid","phosphorus","sulfur","sugar","mercury", "lithium", "radium", "silicon")
	var/random2 = pick("potassium","chlorine","oxygen","nitrogen","hydrogen","carbon","water","acid","phosphorus","sulfur","sugar","mercury", "lithium", "radium", "silicon")
	var/random3 = pick("potassium","chlorine","oxygen","nitrogen","hydrogen","carbon","water","acid","phosphorus","sulfur","sugar","mercury", "lithium", "radium", "silicon")
	var/random4 = pick("potassium","chlorine","oxygen","nitrogen","hydrogen","carbon","water","acid","phosphorus","sulfur","sugar","mercury", "lithium", "radium", "silicon")
	deux = pick(34 ; random2, "potassium","chlorine","oxygen","nitrogen","hydrogen","carbon","water","acid","phosphorus","sulfur","sugar","mercury", "lithium", "radium", "silicon")
	tres = pick(34 ; random3, "potassium","chlorine","oxygen","nitrogen","hydrogen","carbon","water","acid","phosphorus","sulfur","sugar","mercury", "lithium", "radium", "silicon")
	quatre = pick(34 ; random4, "potassium","chlorine","oxygen","nitrogen","hydrogen","carbon","water","acid","phosphorus","sulfur","sugar","mercury", "lithium", "radium", "silicon")

//	if (deux == tres || deux == quatre || tres == quatre)
//		goto restart

	for (var/obj/item/weapon/reagent_containers/glass/beaker/B in world)
		B.reagents.add_reagent(random1, 30)
		B.reagents.add_reagent(random2, 30)
		B.reagents.add_reagent(random3, 30)
		B.reagents.add_reagent(random4, 30)
		B.update_icon()

	for (var/obj/item/weapon/paper/C in world)
		C.info = {" <B>Chemistry Information</B>

<B>Note:</B> Centcom reports on the strange results of combining the following chemicals:<BR>

[random1]
[deux]
[tres]
[quatre]

Further investigation and testing is warranted.
"}
*/