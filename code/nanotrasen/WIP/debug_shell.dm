/mob/living/carbon/human/verb/test_shell()
	set category = "Debug"
	set name = "nt_test os shell"

	if(!check_rights(R_DEBUG)) return

	switch(world.system_type)
		if(MS_WINDOWS)
			usr << "Windows!"
		if(UNIX)
			usr << "Unix!"
	usr << "We are at [__FILE__]" //code/nanotrasen/WIP/debug_shell.dm
	if(shell()) usr << "\green Shell allowed!"

	myshell("pwd")
	myshell("cmd /D /C dir")
	myshell("cmd /C dir")



/proc/myshell(var/command)
	var/errorlevel = shell("[command] > file1.tmp")
	usr << "Errorlevel: [errorlevel]"
	usr << file2text("file1.tmp")
