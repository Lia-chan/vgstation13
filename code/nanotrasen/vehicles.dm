/obj/structure/stool/bed/chair/vehicle
	name = "Military Segway"
	desc = "Military segway SS-12"
	icon = 'icons/nanotrasen/vehicles.dmi'
	icon_state = "segway"
	var/icon_state_moving = "segway"
	anchored = 1
	density = 1
	var/vehsize_h = 0 //Shift size in pixels while mob are on
	var/vehsize_v = 5


/obj/structure/stool/bed/chair/vehicle/New()
	handle_rotation()



/obj/structure/stool/bed/chair/vehicle/relaymove(mob/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
		return
	//if(istype(get_ranged_target_turf(src, direction, 0),/turf/space))
	if(istype(src.loc,/turf/space))
		unbuckle()
		return
	step(src, direction)
	icon_state = icon_state_moving
	update_mob()
	handle_rotation()

/obj/structure/stool/bed/chair/vehicle/Move()
	..()
	if(buckled_mob)
		if(buckled_mob.buckled == src)
			buckled_mob.loc = loc

/obj/structure/stool/bed/chair/vehicle/buckle_mob(mob/M, mob/user)
	if(M != user || !ismob(M) || get_dist(src, user) > 1 || user.restrained() || user.lying || user.stat || M.buckled || istype(user, /mob/living/silicon))
		return

	unbuckle()

	M.visible_message(\
		"<span class='notice'>[M] climbs onto the [src.name].</span>",\
		"<span class='notice'>You climb onto the [src.name].</span>")
	M.buckled = src
	M.loc = loc
	M.dir = dir
	M.update_canmove()
	buckled_mob = M
	update_mob()
	add_fingerprint(user)
	return

/obj/structure/stool/bed/chair/vehicle/unbuckle()
	if(buckled_mob)
		buckled_mob.pixel_x = 0
		buckled_mob.pixel_y = 0
	..()

/obj/structure/stool/bed/chair/vehicle/handle_rotation()
	if(dir == SOUTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER

	if(buckled_mob)
		if(buckled_mob.loc != loc)
			buckled_mob.buckled = null //Temporary, so Move() succeeds.
			buckled_mob.buckled = src //Restoring

	update_mob()

/obj/structure/stool/bed/chair/vehicle/proc/update_mob()
	if(buckled_mob)
		buckled_mob.dir = dir
		if(dir in cardinal)
			buckled_mob.pixel_x = vehsize_h
			buckled_mob.pixel_y = vehsize_v
		/*
		switch(dir)
			if(SOUTH)
				buckled_mob.pixel_x = vehsize_h
				buckled_mob.pixel_y = vehsize_v
			if(WEST)
				buckled_mob.pixel_x = vehsize_h
				buckled_mob.pixel_y = vehsize_v
			if(NORTH)
				buckled_mob.pixel_x = vehsize_h
				buckled_mob.pixel_y = vehsize_v
			if(EAST)
				buckled_mob.pixel_x = vehsize_h
				buckled_mob.pixel_y = vehsize_v
		*/

/obj/structure/stool/bed/chair/vehicle/bullet_act(var/obj/item/projectile/Proj)
	if(buckled_mob)
		if(prob(65))
			return buckled_mob.bullet_act(Proj)
		if(prob(20))
			unbuckle()
			visible_message("\red [buckled_mob.name] fell from [src.name] hit by [Proj]!")
			return buckled_mob.bullet_act(Proj)
	visible_message("<span class='warning'>[Proj] ricochets off the [src.name]!</span>")

// Vehicles definition //

/obj/structure/stool/bed/chair/vehicle/segway
	name = "Military Segway"
	desc = "Military Segway SS-12"
	icon_state = "segway"
	icon_state_moving = "segway"

/obj/structure/stool/bed/chair/vehicle/bluemobile
	name = "Blue Bike"
	desc = "It looks so speedy!"
	icon_state = "bluemobile"
	icon_state_moving = "bluemobile"

/obj/structure/stool/bed/chair/vehicle/redmobile
	name = "Red Bike"
	desc = "Red goes faster!"
	icon_state = "redmobile"
	icon_state_moving = "redmobile"
