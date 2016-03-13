//Prespawned supply crates
/obj/structure/closet/crate/prespawned_supply

/obj/structure/closet/crate/prespawned_supply/proc/populate(var/datum/supply_packs/SP = null)
	if(!SP)
		return

	//var/atom/A = new SP.containertype(src)
	var/atom/A = src
	A.name = "[SP.containername]"

	if(SP.access)
		A:req_access = list()
		A:req_access += text2num(SP.access)

	var/list/contains
	if(istype(SP,/datum/supply_packs/randomised))
		var/datum/supply_packs/randomised/SPR = SP
		contains = list()
		if(SPR.contains.len)
			for(var/j=1,j<=SPR.num_contained,j++)
				contains += pick(SPR.contains)
	else
		contains = SP.contains

	for(var/typepath in contains)
		if(!typepath)	continue
		var/atom/B2 = new typepath(A)
		if(SP.amount && B2:amount) B2:amount = SP.amount
		//slip.info += "<li>[B2.name]</li>" //add the item to the manifest

//Hydroponies!
/obj/structure/closet/crate/prespawned_supply/hydroponics
	name = "Hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon = 'icons/obj/storage.dmi'
	icon_state = "hydrocrate"
	icon_opened = "hydrocrateopen"
	icon_closed = "hydrocrate"
	density = 1

//Bee keeping
/obj/structure/closet/crate/prespawned_supply/hydroponics/bees
	New()
		..()
		populate(new /datum/supply_packs/bee_keeper)