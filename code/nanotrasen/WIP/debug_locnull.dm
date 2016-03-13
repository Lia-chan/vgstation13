/datum/admins/proc/find_atoms_in_null()
	set category = "Mapping"
	set name = "Find atoms in null(laggy)"

	if(!check_rights(R_DEBUG)) return
	var/msg
	spawn(0)
		for(var/atom/A)
			if(A.loc == null)
				msg += "\ref[A] [A.type] - [A]\n"
		world.log << msg
		usr << "Atoms collected, see world.log"