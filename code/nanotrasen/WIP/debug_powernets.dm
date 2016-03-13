
/datum/admins/proc/powernets_debug()
	set category = "Mapping"
	set name = "nt_Powernets debug"
//	if(!holder)	return
	if(!check_rights(R_DEBUG)) return
	var/ref_holder = "\ref[usr]"
	for(var/i=1,i<=powernets.len,i++)
		src << "<a href='?[ref_holder];adminplayervars=\ref[powernets[i]]'>[copytext("\ref[powernets[i]]",8,12)]</A>"


/datum/admins/proc/powernet_overlays()
	set category = "Mapping"
	set name = "nt_Powernets overlays"
	if(!check_rights(R_DEBUG)) return
	for(var/obj/structure/cable/C in cable_list)
		C.maptext = "<font color='white'>[copytext("\ref[C.powernet]",8,12)]</font>"
	for(var/obj/machinery/power/M in machines)
		M.maptext = "<font color='white'>[copytext("\ref[M.powernet]",8,12)]</font>"

