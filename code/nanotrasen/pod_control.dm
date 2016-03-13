//
obj/machinery/pod_launch_button
	name = "Pod Launch Control"
	desc = "This device is used to launch escape pod"
	icon = 'icons/obj/monitors.dmi'
	icon_state = "auth_on"
	var/pod_id = 0

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(!pod_id) return
		if(istype(W,/obj/item/weapon/card/id))
			if(!emergency_shuttle.online || emergency_shuttle.direction==-1)
				var/confirm_early = alert("No saving party is inbound to pick you up, you'll end up in deep space and die of oxygen deprivation or starvation eventually.",,"Risk","Cancel")
				if(!confirm_early || confirm_early == "Cancel")
					return
			else
				var/confirm = alert("Confirm launch?",,"Launch","Cancel")
				if(!confirm || confirm == "Cancel")
					return
			switch(pod_id)
				if(1)
					emergency_shuttle.transit_pod_1()
				if(2)
					emergency_shuttle.transit_pod_2()
				if(3)
					emergency_shuttle.transit_pod_3()
				if(5)
					emergency_shuttle.transit_pod_5()
			pod_id = 0
			icon_state = "auth_off"
		else
			usr << "The pod control computer requires ID to confirm your identity"
