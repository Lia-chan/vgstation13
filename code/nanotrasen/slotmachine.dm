/obj/machinery/vending/slot_machine
	name = "Slot Machine"
	desc = "Gambling for the antisocial."
	icon = 'icon/nanotrasen/slots.dmi'
	icon_state = "slots-off"
	anchored = 1
	density = 1
	mats = 10
	var/money = 2500000
	var/plays = 0
	var/working = 0
	var/obj/item/weapon/card/id/scan = null

	attackby(var/obj/item/I as obj, user as mob)
/*		if(istype(I, /obj/item/weapon/card/id))
			if(src.scan)
				user << "\red There is a card already in the slot machine."
			else
				user << "\blue You insert your ID card."
				usr.drop_item()
				I.loc = src
				src.scan = I
		else src.attack_hand(user)*/
		if(istype(W, /obj/item/weapon/card) && currently_vending)
			//attempt to connect to a new db, and if that doesn't work then fail
			if(!linked_db)
				reconnect_database()
			if(linked_db)
				if(linked_account)
					var/obj/item/weapon/card/I = W
					scan_card(I)
				else
					usr << "\icon[src]<span class='warning'>Unable to connect to linked account.</span>"
			else
				usr << "\icon[src]<span class='warning'>Unable to connect to accounts database.</span>"
		return

	attack_hand(var/mob/user as mob)
		user.machine = src
		if (!src.scan)
			var/dat = {"<B>Slot Machine</B><BR>
			<HR><BR>
			<B>Please insert card!</B><BR>"}
			user << browse(dat, "window=slotmachine;size=450x500")
			onclose(user, "slotmachine")
		else if (src.working)
			var/dat = {"<B>Slot Machine</B><BR>
			<HR><BR>
			<B>Please wait!</B><BR>"}
			user << browse(dat, "window=slotmachine;size=450x500")
			onclose(user, "slotmachine")
		else
			var/dat = {"<B>Slot Machine</B><BR>
			<HR><BR>
			Five credits to play!<BR>
			<B>Prize Money Available:</B> [src.scan.money]<BR>
			<B>Your Card:</B> [src.scan]<BR>
			<B>Credits Remaining:</B> [src.scan.money]<BR>
			[src.plays] players have tried their luck today!<BR>
			<HR><BR>
			<A href='?src=\ref[src];ops=1'>Play!<BR>
			<A href='?src=\ref[src];ops=2'>Eject card"}
			user << browse(dat, "window=slotmachine;size=400x500")
			onclose(user, "slotmachine")

	Topic(href, href_list)
		if(href_list["ops"])
			var/operation = text2num(href_list["ops"])
			if(operation == 1) // Play
				if (src.scan.money < 5)
					for(var/mob/O in hearers(src, null))
						O.show_message(text("<b>[]</b> says, 'Insufficient money to play!'", src), 1)
					return
				src.scan.money -= 5
				src.money += 5
				src.plays += 1
				src.working = 1
				src.icon_state = "slots-on"
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, 'Let's roll!'", src), 1)
				var/roll = rand(1,10000)
				spawn(100)
					if (roll == 1)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'JACKPOT! You win [src.money]!'", src), 1)
						command_alert("Congratulations [src.scan.registered] on winning the Jackpot!", "Jackpot Winner")
						src.scan.money += src.money
						src.money = 0
					else if (roll > 1 && roll <= 10)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Big Winner! You win five thousand credits!'", src), 1)
						src.scan.money += 5000
						src.money -= 5000
					else if (roll > 10 && roll <= 100)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Winner! You win five hundred credits!'", src), 1)
						src.scan.money += 500
						src.money -= 500
					else if (roll > 100 && roll <= 1000)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'You win a free game!'", src), 1)
						src.scan.money += 5
						src.money -= 5
					else
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'No luck!'", src), 1)
					src.working = 0
					src.icon_state = "slots-off"
			if(operation == 2) // Eject Card
				src.scan.loc = src.loc
				src.scan = null
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, 'Thank you for playing!'", src), 1)
		src.add_fingerprint(usr)
		src.updateUsrDialog()
		return