/obj/structure/disposalpipe/wrapsortjunction/human
	desc = "An underfloor disposal pipe which sorts organic objects."

	transfer(var/obj/structure/disposalholder/H)
		var/nextdir = nextdir(H.dir, H.hasmob)
		H.dir = nextdir
		var/turf/T = H.nextloc()
		var/obj/structure/disposalpipe/P = H.findpipe(T)

		if(P)
			// find other holder in next loc, if inactive merge it with current
			var/obj/structure/disposalholder/H2 = locate() in P
			if(H2 && !H2.active)
				H.merge(H2)

			H.loc = P
		else			// if wasn't a pipe, then set loc to turf
			H.loc = T
			return null

		return P

/obj/machinery/gibber/autogibber/soylent
	name = "Organic materials processor"
	desc = "Some piece of secret Nanotrasen equipment"
	icon_state = "processor"

	Bumped(var/atom/A)
		if(!input_plate)
			world.log << "DEBUG: s/gibber without input plate at [src.x],[src.y],[src.z]"
			return

		if(ismob(A))
			var/mob/M = A

			if(M.loc == input_plate)
				put_in(M)
				sleep(3)
				startgibbing()
		else
			/*var/atom/movable/I = A
			var/turf/Txi = locate(src.x, src.y - 1, src.z)*/
			visible_message("\red You hear a loud metallic grinding sound.")
			del(A)
			//I.throw_at(Txi, 1, 1)

/obj/machinery/gibber/autogibber/soylent/relaymove(mob/user, direction)
	return

/obj/machinery/gibber/autogibber/soylent/proc/put_in(mob/G as mob)
	if(G.client)
		G.client.perspective = EYE_PERSPECTIVE
		G.client.eye = src
	G.loc = src
	src.occupant = G
	update_icon()

/obj/machinery/gibber/autogibber/soylent/startgibbing()
	if(src.operating)
		return
	if(!src.occupant)
		visible_message("\red You hear a loud metallic grinding sound.")
		return
	var/mob/victim = src.occupant
	use_power(1000)
	visible_message("\red You hear a loud squelchy grinding sound.")
	src.operating = 1
	update_icon()
//	var/sourcename = victim.real_name
//	var/sourcejob = victim.job
	var/sourcenutriment = victim.nutrition / 15
	var/sourcetotalreagents = 0
	if(victim.reagents)
		sourcetotalreagents = victim.reagents.total_volume
	var/totalslabs = 3

	var/obj/item/weapon/reagent_containers/food/snacks/soylentgreen/allmeat[totalslabs]
	for (var/i=1 to totalslabs)
		var/obj/item/weapon/reagent_containers/food/snacks/soylentgreen/newmeat = new
		//newmeat.name = sourcename + newmeat.name
		//newmeat.subjectname = sourcename
		//newmeat.subjectjob = sourcejob
		newmeat.reagents.add_reagent ("nutriment", sourcenutriment / totalslabs) // Thehehe. Fat guys go first
		if(victim.reagents)
			victim.reagents.trans_to (newmeat, round (sourcetotalreagents / totalslabs, 1)) // Transfer all the reagents from the
		allmeat[i] = newmeat

	victim.attack_log += "\[[time_stamp()]\] Was gibbed by autogibber" //One shall not simply gib a mob unnoticed!
	//user.attack_log += "\[[time_stamp()]\] Gibbed <b>[victim]/[victim.ckey]</b>"
	//log_attack("\[[time_stamp()]\] <b>[user]/[user.ckey]</b> gibbed <b>[victim]/[victim.ckey]</b>")
// /obj/item/weapon/reagent_containers/food/snacks/soylentgreen
	victim.death(1)
	victim.ghostize()
	if(victim.stat == CONSCIOUS)
		victim.emote("scream")
	del(victim)
	spawn(src.gibtime)
		playsound(src.loc, 'sound/effects/splat.ogg', 50, 1)
		operating = 0
		for (var/i=1 to totalslabs)
			var/obj/item/meatslab = allmeat[i]
			var/turf/Tx = locate(src.x, src.y - i, src.z)
			meatslab.loc = src.loc
			meatslab.throw_at(Tx,i,3)
			if (!Tx.density)
				new /obj/effect/decal/cleanable/blood/gibs(Tx,i)
		src.operating = 0
		update_icon()