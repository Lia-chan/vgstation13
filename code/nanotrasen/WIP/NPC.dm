/mob/living/simple_animal/npc
	name = "NPC Vendor"
	desc = "Judischen Geschaeftemacher"
	icon = 'icons/mob/NPC.dmi'
	icon_state = "barman"
	icon_living = "barman"
	icon_dead = "barman_dead"
//	icon_gib = "npc_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = -1
	stop_automated_movement = 0
	stop_automated_movement_when_pulled = 1
	maxHealth = 100
	health = 100
	var/target
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punches"
	a_intent = "harm"
//	var/corpse = /obj/effect/decal/remains/human
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15
	wall_smash = 0
	nopush = 0

	var/active = 1 //No sales pitches if off!
	var/vend_ready = 1 //Are we ready to vend?? Is it time??
	var/vend_delay = 10 //How long does it take to vend?
	var/product_paths = "" //String of product paths separated by semicolons. No spaces!
	var/product_amounts = "" //String of product amounts separated by semicolons, must have amount for every path in product_paths
	var/product_slogans = "" //String of slogans separated by semicolons, optional
	var/product_ads = "" //String of small ad messages in the vending screen - random chance
	var/product_hidden = "" //String of products that are hidden unless hacked.
	var/product_hideamt = "" //String of hidden product amounts, separated by semicolons. Exact same as amounts. Must be left blank if hidden is.
	var/product_coin = ""
	var/product_coin_amt = ""
	var/list/product_records = list()
	var/list/hidden_records = list()
	var/list/coin_records = list()
	var/list/slogan_list = list()
	var/list/small_ads = list() // small ad messages in the vending screen - random chance of popping up whenever you open it
	var/vend_reply //Thank you for shopping!
	var/last_reply = 0
	var/last_slogan = 0 //When did we last pitch?
	var/slogan_delay = 15 //How long until we can pitch again?
	var/shoot_inventory = 0 //Fire items at customers! We're broken!
	var/shut_up = 0 //Stop spouting those godawful pitches!
	var/extended_inventory = 0 //can we access the hidden inventory?
	var/obj/item/weapon/coin/coin

/mob/living/simple_animal/npc/New()
	..()
	spawn(4)
		src.slogan_list = text2list(src.product_slogans, ";")
		var/list/temp_paths = text2list(src.product_paths, ";")
		var/list/temp_amounts = text2list(src.product_amounts, ";")
		var/list/temp_hidden = text2list(src.product_hidden, ";")
		var/list/temp_hideamt = text2list(src.product_hideamt, ";")
		var/list/temp_coin = text2list(src.product_coin, ";")
		var/list/temp_coin_amt = text2list(src.product_coin_amt, ";")
		//Little sanity check here
		src.build_inventory(temp_paths,temp_amounts)
		 //Add hidden inventory
		src.build_inventory(temp_hidden,temp_hideamt, 1)
		src.build_inventory(temp_coin,temp_coin_amt, 0, 1)
		for(var/obj/structure/stool/S in loc)
			//if(istype(S, /obj/structure/stool))
			src.buckled = S
		return

	return

/mob/living/simple_animal/npc/proc/build_inventory(var/list/path_list,var/list/amt_list,hidden=0,req_coin=0)

	for(var/p=1, p <= path_list.len ,p++)
		var/checkpath = text2path(path_list[p])
		if (!checkpath)
			continue
		var/obj/temp = new checkpath(src)
		var/datum/data/vending_product/R = new /datum/data/vending_product(  )
		R.product_name = capitalize(temp.name)
		R.product_path = path_list[p]
		R.display_color = pick("red","blue","green")
//		R. = text2num(amt_list[p])
//		src.product_records += R

		if(hidden)
			R.amount = text2num(amt_list[p])
			src.hidden_records += R
		else if(req_coin)
			R.amount = text2num(amt_list[p])
			src.coin_records += R
		else
			R.amount = text2num(amt_list[p])
			src.product_records += R

		del(temp)

//			world << "Added: [R.product_name]] - [R.amount] - [R.product_path]"
		continue

/mob/living/simple_animal/npc/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/coin) && product_coin != "")
		user.drop_item()
		W.loc = src
		coin = W
		user << "\blue You give the [W] to the [src]"
		return
	else
		..()

/mob/living/simple_animal/npc/proc/updateUsrDialog()
	var/list/nearby = viewers(1, src)
	for(var/mob/M in nearby)
		if ((M.client && M.machine == src))
			src.attack_hand(M)
	if (istype(usr, /mob/living/silicon/ai) || istype(usr, /mob/living/silicon/robot))
		if (!(usr in nearby))
			if (usr.client && usr.machine==src) // && M.machine == src is omitted because if we triggered this by using the dialog, it doesn't matter if our machine changed in between triggering it and this - the dialog is probably still supposed to refresh.
				src.attack_ai(usr)

	// check for TK users

	if (istype(usr, /mob/living/carbon/human))
		if(istype(usr.l_hand, /obj/item/tk_grab) || istype(usr.r_hand, /obj/item/tk_grab/))
			if(!(usr in nearby))
				if(usr.client && usr.machine==src)
					src.attack_hand(usr)

/mob/living/simple_animal/npc/proc/updateDialog()
	var/list/nearby = viewers(1, src)
	for(var/mob/M in nearby)
		if ((M.client && M.machine == src))
			src.attack_hand(M)
	AutoUpdateAI(src)
/*
/mob/living/simple_animal/npc/process()
	if(!src.active)
		return

	//Pitch to the people!  Really sell it!
	if(((src.last_slogan + src.slogan_delay) <= world.time) && (src.slogan_list.len > 0) && (!src.shut_up) && prob(5))
		var/slogan = pick(src.slogan_list)
		src.speak(slogan)
		src.last_slogan = world.time

	if(src.shoot_inventory && prob(2))
		src.throw_item()

	return
*/
/mob/living/simple_animal/npc/proc/speak(var/message)

	if (!message)
		return

	for(var/mob/O in hearers(src, null))
		O.show_message("<span class='game say'><span class='name'>[src]</span> says, \"[message]\"",2)
	return

/mob/living/simple_animal/npc/Life()
	..()

	if(health < 1)
		Die()
		src.active = 0

	if(health > maxHealth)
		health = maxHealth

	if(!src.active)
		return

	//Pitch to the people!  Really sell it!
	if(((src.last_slogan + src.slogan_delay) <= world.time) && (src.slogan_list.len > 0) && (!src.shut_up) && prob(5))
		var/slogan = pick(src.slogan_list)
		src.speak(slogan)
		src.last_slogan = world.time

	if(src.shoot_inventory && prob(2))
		src.throw_item()

	if(!ckey && !stop_automated_movement)
		if(isturf(src.loc) && !resting && !buckled && canmove)		//This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				if(!(stop_automated_movement_when_pulled && pulledby))
					Move(get_step(src,pick(cardinal)))
					turns_since_move = 0


/mob/living/simple_animal/npc/attack_ai(mob/user as mob)
	if(isrobot(user))
		// For some reason attack_robot doesn't work
		// This is to stop robots from using cameras to remotely control machines.
		if(user.client && user.client.eye == user)
			return src.attack_hand(user)
	else
		return src.attack_hand(user)


/mob/living/simple_animal/npc/attack_paw(mob/user as mob)
	return attack_hand(user)

/mob/living/simple_animal/npc/attack_hand(mob/user as mob)
	switch(user.a_intent)
		if("grab")
			if (user == src)
				return
			if (nopush)
				return
			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab( user, user, src )

			user.put_in_active_hand(G)

			grabbed_by += G
			G.synch()

			LAssailant = user

			for(var/mob/O in viewers(src, null))
				if ((O.client && !( O.blinded )))
					O.show_message(text("\red [] has grabbed [] passively!", user, src), 1)
		else
			if (!src.active)
				return
			user.machine = src
			var/vendorname = (src.name)  //import the machine's name
			var/dat = "<TT><center><b>[vendorname]</b></center><hr /><br>" //display the name, and added a horizontal rule
			dat += "<b>Select an item: </b><br><br>" //the rest is just general spacing and bolding

			if (product_coin != "")
				dat += "<b>Coin slot:</b> [coin ? coin : "No coin inserted"] (<a href='byond://?src=\ref[src];remove_coin=1'>Remove</A>)<br><br>"

			if (src.product_records.len == 0)
				dat += "<font color = 'red'>No product loaded!</font>"
			else
				var/list/display_records = src.product_records
				if(src.extended_inventory)
					display_records = src.product_records + src.hidden_records
				if(src.coin)
					display_records = src.product_records + src.coin_records
				if(src.coin && src.extended_inventory)
					display_records = src.product_records + src.hidden_records + src.coin_records

				for (var/datum/data/vending_product/R in display_records)
					dat += "<FONT color = '[R.display_color]'><B>[R.product_name]</B>:"
					dat += " <b>[R.amount]</b> </font>"
					if (R.amount > 0)
						dat += "<a href='byond://?src=\ref[src];vend=\ref[R]'>(Vend)</A>"
					else
						dat += " <font color = 'red'>SOLD OUT</font>"
					dat += "<br>"

				dat += "</TT>"

				if (product_slogans != "")
					dat += "Shut the fuck up is [src.shut_up ? "on" : "off"]. <a href='?src=\ref[src];togglevoice=[1]'>Toggle</a>"

			user << browse(dat, "window=vending")
			onclose(user, "")
	return


/mob/living/simple_animal/npc/Bump(atom/movable/AM as mob|obj, yes)
	spawn( 0 )
		if ((!( yes ) || now_pushing))
			return
		now_pushing = 1
		if(ismob(AM))
			var/mob/tmob = AM
			if(istype(tmob, /mob/living/carbon/human) && (FAT in tmob.mutations))
				if(prob(5))
					src << "\red <B>You fail to push [tmob]'s fat ass out of the way.</B>"
					now_pushing = 0
					return
			if(tmob.nopush)
				now_pushing = 0
				return

			tmob.LAssailant = src
		now_pushing = 0
		..()
		if (!( istype(AM, /atom/movable) ))
			return
		if (!( now_pushing ))
			now_pushing = 1
			if (!( AM.anchored ))
				var/t = get_dir(src, AM)
				if (istype(AM, /obj/structure/window))
					if(AM:ini_dir == NORTHWEST || AM:ini_dir == NORTHEAST || AM:ini_dir == SOUTHWEST || AM:ini_dir == SOUTHEAST)
						for(var/obj/structure/window/win in get_step(AM,t))
							now_pushing = 0
							return
				step(AM, t)
			now_pushing = null
		return
	return

/mob/living/simple_animal/npc/proc/throw_item()
	var/obj/throw_item = null
	var/mob/living/target = locate() in view(7,src)
	if(!target)
		return 0

	for(var/datum/data/vending_product/R in src.product_records)
		if (R.amount <= 0) //Try to use a record that actually has something to dump.
			continue
		var/dump_path = text2path(R.product_path)
		if (!dump_path)
			continue

		R.amount--
		throw_item = new dump_path(src.loc)
		break
	if (!throw_item)
		return 0
	spawn(0)
		throw_item.throw_at(target, 16, 3)
	src.visible_message("\red <b>[src] launches [throw_item.name] at [target.name]!</b>")
	return 1



/mob/living/simple_animal/npc/Topic(href, href_list)
	if(usr.stat || usr.restrained())
		return

	if(istype(usr,/mob/living/silicon))
		if(istype(usr,/mob/living/silicon/robot))
			var/mob/living/silicon/robot/R = usr
			if(!(R.module && istype(R.module,/obj/item/weapon/robot_module/butler) ))
				usr << "\red The vendor refuses to interface with you, as you are not in its target demographic!"
				return
		else
			usr << "\red The vendor refuses to interface with you, as you are not in its target demographic!"
			return

	if(href_list["remove_coin"])
		if(!coin)
			usr << "There is no coin in this machine."
			return

		coin.loc = src.loc
		if(!usr.get_active_hand())
			usr.put_in_hands(coin)
		usr << "\blue You remove the [coin] from the [src]"
		coin = null


	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))))
		usr.machine = src
		if ((href_list["vend"]) && (src.vend_ready))

			src.vend_ready = 0 //One thing at a time!!

			var/datum/data/vending_product/R = locate(href_list["vend"])
			if (!R || !istype(R))
				src.vend_ready = 1
				return
			var/product_path = text2path(R.product_path)
			if (!product_path)
				src.vend_ready = 1
				return

			if (R.amount <= 0)
				src.vend_ready = 1
				return

			if (R in coin_records)
				if(!coin)
					usr << "\blue You need to insert a coin to get this item."
					return
				if(coin.string_attached)
					if(prob(50))
						usr << "\blue You successfully pull the coin out before the [src] could swallow it."
					else
						usr << "\blue You weren't able to pull the coin out fast enough, the machine ate it, string and all."
						del(coin)
				else
					del(coin)

			R.amount--

			if(((src.last_reply + (src.vend_delay + 200)) <= world.time) && src.vend_reply)
				spawn(0)
					src.speak(src.vend_reply)
					src.last_reply = world.time

//			if (src.icon_vend) //Show the vending animation if needed
//				flick(src.icon_vend,src)
			spawn(src.vend_delay)
				new product_path(get_turf(usr))
				src.vend_ready = 1
				return

			src.updateUsrDialog()
			return

		else if (href_list["togglevoice"])
			src.shut_up = !src.shut_up

		src.add_fingerprint(usr)
		src.updateUsrDialog()
	else
		usr << browse(null, "window=vending")
		return
	return

// AND NOW NPCS THEMSELF

/mob/living/simple_animal/npc/Barman
	melee_damage_lower = 20
	melee_damage_upper = 25
	icon_state = "barman"
	icon_living = "barman"
	icon_dead = "barman_dead"
	nopush = 0
	name = "Barman"
	desc = "Serves drinks"
	product_paths = "/obj/item/weapon/reagent_containers/food/drinks/bottle/gin;/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey;/obj/item/weapon/reagent_containers/food/drinks/bottle/tequilla;/obj/item/weapon/reagent_containers/food/drinks/bottle/vodka;/obj/item/weapon/reagent_containers/food/drinks/bottle/vermouth;/obj/item/weapon/reagent_containers/food/drinks/bottle/rum;/obj/item/weapon/reagent_containers/food/drinks/bottle/wine;/obj/item/weapon/reagent_containers/food/drinks/bottle/cognac;/obj/item/weapon/reagent_containers/food/drinks/bottle/kahlua;/obj/item/weapon/reagent_containers/food/drinks/beer;/obj/item/weapon/reagent_containers/food/drinks/ale;/obj/item/weapon/reagent_containers/food/drinks/bottle/orangejuice;/obj/item/weapon/reagent_containers/food/drinks/bottle/tomatojuice;/obj/item/weapon/reagent_containers/food/drinks/bottle/limejuice;/obj/item/weapon/reagent_containers/food/drinks/bottle/cream;/obj/item/weapon/reagent_containers/food/drinks/tonic;/obj/item/weapon/reagent_containers/food/drinks/cola;/obj/item/weapon/reagent_containers/food/drinks/sodawater;/obj/item/weapon/reagent_containers/food/drinks/drinkingglass;/obj/item/weapon/reagent_containers/food/drinks/ice"
	product_amounts = "5;5;5;5;5;5;5;5;5;6;6;4;4;4;4;8;8;15;30;9"
	vend_delay = 5
	product_hidden = "/obj/item/weapon/reagent_containers/food/drinks/tea"
	product_hideamt = "10"
	product_slogans = "I hope nobody asks me for a bloody cup o' tea...;Alcohol is humanity's friend. Would you abandon a friend?;Quite delighted to serve you!;Is nobody thirsty on this station?"
	product_ads = "Drink up!;Booze is good for you!;Alcohol is humanity's best friend.;Quite delighted to serve you!;Care for a nice, cold beer?;Nothing cures you like booze!;Have a sip!;Have a drink!;Have a beer!;Beer is good for you!;Only the finest alcohol!;Best quality booze since 2053!;Award-winning wine!;Maximum alcohol!;Man loves beer.;A toast for progress!"
//	product_coin = "/obj/item/weapon/storage/belt/utility"
//	product_coin_amt = "3"

/mob/living/simple_animal/npc/Luxury
	melee_damage_lower = 20
	melee_damage_upper = 25
	icon_state = "barman"
	icon_living = "barman"
	icon_dead = "barman_dead"
	nopush = 0
	name = "Luxury Vendor"
	desc = "Sells luxury things."
	product_paths = "/obj/item/clothing/glasses/fluff/uzenwa_sissra_1;/obj/item/clothing/glasses/welding/fluff/ian_colm_2;/obj/item/clothing/gloves/fluff/chal_appara_1;/obj/item/clothing/gloves/fluff/murad_hassim_1;/obj/item/clothing/gloves/fluff/walter_brooks_1;/obj/item/clothing/head/det_hat/fluff/retpolcap;/obj/item/clothing/head/flatcap;/obj/item/clothing/head/fluff/edvin_telephosphor_1;/obj/item/clothing/head/helmet/greenbandana/fluff/taryn_kifer_1;/obj/item/clothing/head/secsoft/fluff/swatcap;/obj/item/clothing/head/welding/fluff/alice_mccrea_1;/obj/item/clothing/head/welding/fluff/norah_briggs_1;/obj/item/clothing/head/welding/fluff/yuki_matsuda_1;/obj/item/clothing/mask/cigarette/pipe;/obj/item/clothing/mask/fluff/electriccig;/obj/item/clothing/mask/mara_kilpatrick_1;/obj/item/clothing/shoes/magboots/fluff/susan_harris_1;/obj/item/clothing/suit/armor/vest/fluff/deus_blueshield;/obj/item/clothing/suit/det_suit/fluff/graycoat;/obj/item/clothing/suit/det_suit/fluff/leatherjack;/obj/item/clothing/suit/det_suit/fluff/retpolcoat;/obj/item/clothing/suit/labcoat/fluff/burnt;/obj/item/clothing/under/det/fluff/retpoluniform;/obj/item/clothing/under/fluff/jumpsuitdown;/obj/item/clothing/under/fluff/olddressuniform;/obj/item/clothing/under/fluff/tian_dress;/obj/item/clothing/under/rank/bartender/fluff/classy;/obj/item/clothing/under/rank/security/fluff/jeremy_wolf_1;/obj/item/device/flashlight/fluff/thejesster14_1;/obj/item/fluff/angelo_wilkerson_1;/obj/item/fluff/david_fanning_1;/obj/item/fluff/ethan_way_1;/obj/item/fluff/maurice_bedford_1;/obj/item/fluff/sarah_calvera_1;/obj/item/fluff/sarah_carbrokes_1;/obj/item/fluff/steve_johnson_1;/obj/item/fluff/val_mcneil_1;/obj/item/fluff/victor_kaminsky_1;/obj/item/fluff/wes_solari_1;/obj/item/paper/fluff/john_mckeever_1;/obj/item/weapon/camera_test/fluff/orange;/obj/item/weapon/card/id/fluff/asher_spock_2;/obj/item/weapon/card/id/fluff/ian_colm_1;/obj/item/weapon/card/id/fluff/lifetime;/obj/item/weapon/clipboard/fluff/mcreary_journal;/obj/item/weapon/clipboard/fluff/smallnote;/obj/item/weapon/crowbar/fluff/zelda_creedy_1;/obj/item/weapon/fluff/cado_keppel_1;/obj/item/weapon/fluff/hugo_cinderbacth_1;/obj/item/weapon/lighter/zippo/fluff/executivekill_1;/obj/item/weapon/lighter/zippo/fluff/fay_sullivan_1;/obj/item/weapon/lighter/zippo/fluff/li_matsuda_1;/obj/item/weapon/lighter/zippo/fluff/naples_1;/obj/item/weapon/lighter/zippo/fluff/riley_rohtin_1;/obj/item/weapon/paper/certificate;/obj/item/weapon/pen/fluff/fancypen;/obj/item/weapon/pen/fluff/fountainpen;/obj/item/weapon/pen/fluff/multi;/obj/item/clothing/suit/labcoat/fluff/pink;/obj/item/weapon/reagent_containers/food/drinks/flask/fluff/johann_erzatz_1;/obj/item/weapon/reagent_containers/food/drinks/flask/fluff/lithiumflask;/obj/item/weapon/reagent_containers/food/drinks/flask/fluff/shinyflask;/obj/item/weapon/reagent_containers/glass/beaker/large/fluff/nashida_bishara_1;/obj/item/weapon/reagent_containers/hypospray/fluff/asher_spock_1;/obj/item/weapon/storage/bible/tajaran;/obj/item/weapon/storage/fluff/maye_daye_1;/obj/item/weapon/storage/pill_bottle/fluff/listermedbottle;/obj/item/weapon/wrapping_paper"
	product_amounts = "20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20;20"
	vend_delay = 5
//	product_hidden = "/obj/item/weapon/reagent_containers/food/drinks/tea"
//	product_hideamt = "10"
//	product_slogans = "I hope nobody asks me for a bloody cup o' tea...;Alcohol is humanity's friend. Would you abandon a friend?;Quite delighted to serve you!;Is nobody thirsty on this station?"
//	product_ads = "Drink up!;Booze is good for you!;Alcohol is humanity's best friend.;Quite delighted to serve you!;Care for a nice, cold beer?;Nothing cures you like booze!;Have a sip!;Have a drink!;Have a beer!;Beer is good for you!;Only the finest alcohol!;Best quality booze since 2053!;Award-winning wine!;Maximum alcohol!;Man loves beer.;A toast for progress!"
//	product_coin = "/obj/item/weapon/storage/belt/utility"
//	product_coin_amt = "3"