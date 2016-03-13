/obj/structure/plant
	name = "Plant"
	desc = "Just a plant in pot."
	icon = 'icons/obj/plants.dmi' //In BS12 merged at a2d11cf5c78b04150a174ca194349ecd6d984c9d and still unused
	icon_state = "applebush" //plant-01 to 25 and applebush
	anchored = 0
	density = 0 // You shall pass!
	var/health = 25.0
	var/maxhealth = 25.0

	New()
		..()
		if(icon_state=="applebush")
			var/numplant = leadingzero(rand(1,25),2) // Requires _helpers.dm
			icon_state="plant-[numplant]"

/obj/structure/plant/plant1
	name = "Monsterra plant"
	desc = "A plant with big, claw-like leaves."
	icon_state = "plant-01"

/obj/structure/plant/plant2
	name = "Diffenbachia plant"
	desc = "A plant with big white-striped leaves."
	icon_state = "plant-02"

/obj/structure/plant/plant3
	name = "Happiness plant"
	desc = "A tower-like plant with some leaves on top."
	icon_state = "plant-05"

/obj/structure/plant/plant4
	name = "Thuja tree"
	desc = "A little coniferous tree in pot."
	icon_state = "plant-22"

/obj/structure/plant/plant5
	name = "Lemontree plant"
	desc = "An ivy-like healing plant."
	icon_state = "plant-17"

//Anybody who can identify and describe the others - please help!