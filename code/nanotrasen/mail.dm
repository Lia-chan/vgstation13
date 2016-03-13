//TODO: Extract items forcibly from the mail hub
//TODO: Construction
//TODO: Pipes?
//TODO: Sprites
//TODO: Format menus so they aren't ugly as sin
//TODO: Improve the "send to department" function.  Pickup should probably be access, not job title.
//TODO: Find something interesting for traitors / emag
//TODO: AI, Cyborg
//TODO: Take care of people going out of range properly
//TODO: Mail access needs its own ID.  HOP (QM access) probably doesn't need it.

/var/list/mailsystem = list()

//I don't want to modify other .dms, but this would go in jobs/jobs.dm
/var/list/cargo_positions = list("Quartermaster","Cargo Technician")

/obj/item/mail_holder
	icon = 'icons/obj/storage.dmi'
	icon_state = "deliverycrateSmall"
	name = "Package"
	desc = "Double-wrapped for your protection."

	var/label = ""
	var/to_person = 1
	var/dest = null
	var/sender = null

	attack_self(mob/user as mob)
		for(var/obj/O in contents)	// but I'll leave it just in case
			O.loc = get_turf(loc)
		del src

/obj/machinery/mail // todo: connect to each other in a way that traitors can suborn
	name = "Mail station"
	icon = 'icons/nanotrasen/mail.dmi'
	icon_state = "mailstation" // TODO: mailoff. mail-broken
	anchored = 1
	density = 1
	use_power = 1

	var/screen = 0
	var/packages = 0
	var/obj/item/mail_holder/selected_package = null
	var/obj/item/weapon/card/id/ID = null
	var/obj/machinery/message_server/linkedServer = null
	var/const/mail_delay = 25
	var/global/icon/pack_in = new('icons/nanotrasen/mail.dmi',"mailpackage")
	var/global/icon/id_in =   new('icons/nanotrasen/mail.dmi',"mailid")

	New()
		..()
		mailsystem += src

	Del()
		mailsystem -= src
		..()

	update_icon()

		overlays.Cut()
		if(packages>0)
			overlays += pack_in
		if(ID != null)
			overlays += id_in

	//Ways to get large deliveries into the system
	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		//if(target != loc) return 1
		if(istype(mover,/obj/item/smallDelivery) || istype(mover,/obj/structure/bigDelivery))
			return 1
		if(istype(mover,/obj/structure/closet))
			visible_message("\blue The [src] refuses the unwrapped [mover].")
			return 0
		return ..(mover,target,height,air_group)
	Crossed(var/obj/A as obj)
		if(istype(A,/obj/item/smallDelivery) || istype(A,/obj/structure/bigDelivery))
			//var/obj/O = A
			var/obj/item/mail_holder/M = new(src)
			A.loc = M
			M.name = "[A.name]"
			packages++
			update_icon()
			return
		return ..()
	MouseDrop_T(obj/S as obj,mob/user as mob)
		if(istype(S,/obj/item/smallDelivery) || istype(S,/obj/structure/bigDelivery))
			var/obj/item/mail_holder/M = new(src)
			S.loc = M
			M.name = "[S.name]"
			packages++
			update_icon()
		else
			user << "\blue The [src] refuses the unwrapped [S]."

	proc/Send(var/obj/item/mail_holder/mail, var/obj/machinery/mail/dest,var/vend)
		if(stat || !dest || dest.stat || !(mail in contents))
			FailedSend()
			return

		if(dest == src) // happens when the hub is being used
			dest.Recieve(mail,vend)
			return
		visible_message("A package disapepars into the [src].")
		playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
		spawn(mail_delay)
			if(stat || !dest || dest.stat || !(mail in contents))
				FailedSend(mail)
				return
			mail.loc = dest
			dest.Recieve(mail,vend)
		return

	proc/FailedSend(var/obj/item/mail_holder/M)
		visible_message("\red The [src] failed to send package '[M]'!")
		if(M in contents)
			M.sender = ""
			packages++
			update_icon()
		return

	proc/Recieve(var/obj/item/mail_holder/M,var/vend)
		if(vend)
			visible_message("A package appears out of the [src].")
			for(var/obj/O in M.contents)
				if(istype(O,/obj/item/smallDelivery) && !usr.get_active_hand())
					usr.put_in_hands(O)
				else
					O.loc = loc
			del M
		else // Hub messaging service
			packages++
			if(M.to_person && M.dest != null)
				MessagePersonnel(M.dest, "You have recieved a package from <i>[M.sender]</i>.")
			else if(!M.to_person && M.dest != null)
				for(var/name in PersonnelList(M.dest))
					MessagePersonnel(name,"The <i>[M.dest] staff</i> has recieved mail from <i>[M.sender]</i>.")
			visible_message("The [src] recieves a package.")
			playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)//Whiff is a nice sound for the mail system to make


	//returns a list of personnel as known by the records computers
	proc/PersonnelList(var/department = null)
		var/list/results = list()
		if(isnull(data_core.general))
			return results

		for(var/datum/data/record/R in sortRecord(data_core.general, "name", 1))
			var/name = R.fields["name"]
			var/job = R.fields["rank"]
			switch(department)
				if(null)
					results[name] = job
				if("command")
					if(job in command_positions) // game/jobs/jobs.dm
						results[name] = job
				if("engineering")
					if(job in engineering_positions)
						results[name] = job
				if("medical")
					if(job in medical_positions)
						results[name] = job
				if("science")
					if(job in science_positions)
						results[name] = job
				if("security")
					if(job in security_positions)
						results[name] = job
				if("cargo")
					if(job in cargo_positions)
						results[name] = job
		return results
	proc/PackageList(var/obj/item/weapon/card/id/user = null)
		var/list/results = list()
		for(var/obj/machinery/mail/hub/H in mailsystem)
			if(!istype(H) || H.stat) continue
			results += H.contents
		for(var/obj/item/mail_holder/H in results)
			if(!istype(H))
				results -= H
				continue

			if(!user)
				continue
			if(access_qm in user.access || emagged)
				continue // Quartermaster access can see and recieve all packages, emags can too
			else if(!H.dest)
				results -= H
			else if(H.to_person && H.dest != user.registered_name)
				results -= H
			else if(!H.to_person) // todo: access instead?
				if(!(user.registered_name in PersonnelList(H.dest)))
					results -= H

		return results

	proc/MessagePersonnel(var/user,var/message = null)
		if(!message)
			message = "A package has been sent to you.  You may pick it up at any mail station."
		if(!linkedServer)
			if(message_servers && message_servers.len > 0)
				linkedServer = message_servers[1]
		var/sender = "Mailer Daemon"
		linkedServer.send_pda_message("[user]", "[sender]","[message]")
		var/obj/item/device/pda/reciever = null
		for (var/obj/item/device/pda/P in PDAs)
			if (!P.owner || P.toff || P.hidden)	continue
			if(P.owner == user)
				reciever = P
		if(!reciever) return

		reciever.tnote += "<i><b>&larr; From [sender]:</b></i><br>[message]<br>"
		if (!reciever.silent)
			playsound(reciever.loc, 'sound/machines/twobeep.ogg', 50, 1)
			for (var/mob/O in hearers(3, reciever.loc))
				O.show_message(text("\icon[reciever] *[reciever.ttone]*"))
			if( reciever.loc && ishuman(reciever.loc) )
				var/mob/living/carbon/human/H = reciever.loc
				H << "\icon[reciever] <b>Message from [sender], </b>\"[message]\""
			log_pda("[usr] (PDA: [sender]) sent \"[message]\" to [reciever.owner]")
			reciever.overlays = null
			reciever.overlays += image('icons/obj/pda.dmi', "pda-r")

	proc/buildMenu()
		var/dat = ""
		if(!ID)
			dat += "ID: <A href='?src=\ref[src];operation=insertcard'>--------</A><br>"
		else
			var/quickicon = ""
			if(emagged || (access_qm in ID.access)) quickicon = "(Mail Admin)"
			dat += "ID: <A href='?src=\ref[src];operation=returncard'>[ID]</A> [quickicon]<br>"
		dat += "<hr>"
		if(selected_package)
			dat += "Package: [selected_package]<br>"
		dat += "<br>"
		switch(screen)
			if(0)	// Main menu
				dat += "<A href='?src=\ref[src];operation=sendmenu'>Send Mail</A><br>"
				dat += "<A href='?src=\ref[src];operation=getmenu'>Check Mail</A><br>"
				if(packages)
					dat += "There are unsent packages in this machine."
				return dat
			if(10)	// Send mail
				if(!ID)
					dat += "An ID is required."
					dat += "<hr><a href='?src=\ref[src];operation=mainmenu'>Back</a>"
					return dat
				if(packages == 0)
					dat += "No packages loaded.  You can wrap small items in package wrap, or wrap a closet or crate and move it into the machine."
				else
					for(var/obj/O in contents) //todo: eject package option
						if(istype(O,/obj/item/mail_holder))
							var/obj/item/mail_holder/MH = O
							if(MH.sender)
								if(!emagged && !(access_qm in ID.access))
									continue // The hub contents includes sent packages, don't include them normally
								else
									dat += "<A href='?src=\ref[src];operation=senddetails&object=\ref[MH]'>[MH]</A> (Waiting for retrieval: <i>[MH.dest]</i>)<br>"
							else
								dat += "<A href='?src=\ref[src];operation=senddetails&object=\ref[O]'>[O]</A><br>"
				dat += "<hr><a href='?src=\ref[src];operation=mainmenu'>Back</a>"
				return dat
			if(11) // Send mail - package menu
				if(!selected_package)
					screen = 10
					return buildMenu()
				dat += "Package details:<br>"
				dat += "Name: <a href='?src=\ref[src];operation=setname'>[selected_package]</a><br>"
				dat += "Destination: <i>"
				if(!selected_package.dest)
					dat += "None"
				else if(selected_package.to_person)
					dat += "Crewmember [selected_package.dest]</i>"
				else
					dat += "[selected_package.dest] Department</i>"

				if(selected_package.sender)
					dat += "<br> Sent by <i>[selected_package.sender]</i>.  (<a href='?src=\ref[src];operation=returntosender'>Return to Sender</a>)<br>"
				else
					dat += "<br> Send to:(<a href='?src=\ref[src];operation=setperson'>one person</a>) (<a href='?src=\ref[src];operation=setdept'>a department</a>)<br>"
				dat += "<hr> <a href='?src=\ref[src];operation=returnpkg'>Clear all and eject package</a><br>"
				dat += "<a href='?src=\ref[src];operation=send'>Send</a><br> <a href='?src=\ref[src];operation=sendmenu'>Go Back</a>"

			if(12) // Send - set recipient - department
				if(!selected_package)
					screen = 10
					return buildMenu()
				dat += "Current destination: <i>"
				if(!selected_package.dest)
					dat += "None"
				else if(selected_package.to_person)
					dat += "Crewmember [selected_package.dest]"
				else
					dat += "[selected_package.dest] Department"
				dat += "</i><br><br>"

				for(var/dept in list("command","engineering","medical","science","security","cargo"))
					dat += "<a href='?src=\ref[src];operation=do_setdept&name=[dept]'>[dept]</a><br>"
				dat += "<br><a href='?src=\ref[src];operation=senddetails'>Return</a><hr><br>"

			if(13) // Send - set recipient - person
				if(!selected_package)
					screen = 10
					return buildMenu()
				dat += "Current destination: <i>"
				if(!selected_package.dest)
					dat += "None"
				else if(selected_package.to_person)
					dat += "Crewmember [selected_package.dest]"
				else
					dat += "[selected_package.dest] Department"
				dat += "</i><br><br>"
				var/list/L = PersonnelList()
				for(var/person in L)
					dat += "<a href='?src=\ref[src];operation=do_setperson&name=[person]'>[person] ([L[person]])</a><br>"
				dat += "<br><a href='?src=\ref[src];operation=senddetails'>Return</a><hr>"
			if(20) // Get mail
				if(!ID)
					dat += "An ID is required."
					dat += "<hr><a href='?src=\ref[src];operation=mainmenu'>Back</a>"
					return dat
				var/list/L = PackageList(ID)
				if(!L.len)
					dat += "There are no packages for pickup."
				else
					if(access_qm in ID.access)
						dat += "<i>You have priviledged access to the mail system.  Please do not take packages that do not belong to you.</i><br><br>"
					for(var/obj/item/mail_holder/H in L)
						if(!H.sender)
							continue // don't list unsent packages here
						dat += "<A href='?src=\ref[src];operation=getpackage&object=\ref[H]'>[H]</a> (sent to [H.dest]"
						if(!H.to_person) dat += " staff"
						dat += " by [H.sender])<br>"
				dat += "<hr><a href='?src=\ref[src];operation=mainmenu'>Back</a>"
		return dat

	proc/getHub(var/obj/item/mail_holder/requested_package = null)
		if(requested_package != null)
			return requested_package.loc
		for(var/obj/machinery/mail/hub/H in mailsystem)
			if(!istype(H)) continue
			if(H.stat) continue
			return H
		return null

	Topic(var/href,var/list/href_list)
		if(!(usr in view(1)) && !istype(usr,/mob/living/silicon))
			return
		switch(href_list["operation"])
			if("insertcard")
				var/obj/item/I = usr.get_active_hand()
				if (istype(I, /obj/item/weapon/card/id))
					usr.drop_item()
					I.loc = src
					ID = I
				update_icon()
			if("returncard")
				if(ID)
					if(ishuman(usr))
						ID.loc = loc
						if(!usr.get_active_hand())
							usr.put_in_hands(ID)
						ID = null
					else
						ID = null
				selected_package = null
				screen = 0
				update_icon()
			if("mainmenu")
				screen = 0
			if("sendmenu")
				screen = 10
				selected_package = null
			if("senddetails")
				selected_package = locate(href_list["object"])
				screen = 11
			if("setdept")
				screen = 12
			if("do_setdept")
				screen = 11
				selected_package.to_person = 0
				selected_package.dest = href_list["name"]
			if("setperson")
				screen = 13
			if("do_setperson")
				screen = 11
				selected_package.to_person = 1
				selected_package.dest = href_list["name"]
			if("setname")
				selected_package.label = input(usr,"Enter a label for this package:","Relabel Package",selected_package.label)
				var/obj/O = selected_package.contents[1]
				selected_package.name = "[selected_package.label] ([O.name])"
			if("send")
				if(!selected_package || !ID)
					screen = 10
					selected_package = null
				else
					if(selected_package.dest)
						var/obj/machinery/mail/hub/H = getHub()
						if(H != null)
							selected_package.sender = "[ID.registered_name] ([ID.assignment])"
							Send(selected_package,H,0)
							packages--
							update_icon()
							screen = 10
							selected_package = null
							sleep(mail_delay+1)
			if("returntosender")
				var/sender = selected_package.sender
				sender = copytext(sender,1,findtextEx(sender,"(")-1)
				selected_package.dest = sender
				selected_package.to_person = 1
				Recieve(selected_package,0)

			if("returnpkg") // cancel send
				Recieve(selected_package,1)
				packages--
				update_icon()
				selected_package = null
				screen = 10

			if("getmenu")
				screen = 20

			if("getpackage")
				var/obj/item/mail_holder/M = locate(href_list["object"]) in PackageList()
				var/obj/machinery/mail/hub/H = getHub(M)
				if(M && H)
					H.Send(M,src,1)
					sleep(mail_delay+1)
				interact()
				return

		interact()
		return


	interact()
		if(!(usr in view(1)) && !istype(usr,/mob/living/silicon))
			return
		usr << browse("<HEAD><TITLE>[name]</TITLE></HEAD>[buildMenu()]", "window=mailstat;size=600x500")
		return

	attack_hand(mob/user as mob)
		interact()

	attackby(obj/item/P as obj, mob/user as mob)
		if(istype(P,/obj/item/smallDelivery))
			usr.drop_item()
			var/obj/item/mail_holder/M = new(src)
			P.loc = M
			M.name = "[P.name]"
			packages++
			update_icon()
		else if(istype(P,/obj/item/weapon/card/id))
			if(ID)
				user << "There is already an ID in the machine."
			else
				usr.drop_item()
				P.loc = src
				ID = P
				update_icon()
		else
			user << "\blue The [src] refuses the unwrapped [P]."


/obj/machinery/mail/hub
	name = "Mail Hub"
	icon = 'icons/nanotrasen/mail.dmi'
	icon_state = "mailhub"

	update_icon()
		return
	attackby(obj/item/P as obj, mob/user as mob)
		if(istype(P,/obj/item/weapon/card/emag)) // mail stations cannot be emagged, but the hub can
			user << "The mail hub doesn't seem to like the [P], but yields after a moment."
			playsound(src.loc, 'sound/machines/twobeep.ogg', 50, 0)
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(2, 1, src)
			s.start()
			emagged = 1
			return
		..(P,user)