/proc/nt_notify(var/action = "")
	var/serverinfo = config.server_name
	var/command = "/usr/local/bin/notify.sh \"[action]\" \"[serverinfo]\""
	if (world.system_type==UNIX)
		shell (command)
	else
		world.log << "DEBUG: Not executing [command] because of WINDOWS"