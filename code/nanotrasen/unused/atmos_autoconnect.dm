// Proc to autoconnect portable atmos staying on ports

/obj/machinery/portable_atmospherics
	proc/autoconnect()
		if(connected_port)
			return
		else
			var/obj/machinery/atmospherics/portables_connector/possible_port = locate(/obj/machinery/atmospherics/portables_connector/) in loc
			if(possible_port)
				if(connect(possible_port))
					update_icon()

/*
/client/verb/atmos_autoconnect()
	set category = "Mapping"
	set name = "nt_Atmos autoconnect"
	for (var/obj/machinery/portable_atmospherics/PA in world)
		usr << "Connecting [PA]"
		PA.autoconnect()
*/