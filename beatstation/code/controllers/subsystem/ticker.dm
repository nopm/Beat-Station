/datum/controller/subsystem/ticker/proc/votetimer()
	var/timerbuffer = 0
	if(initialtpass == 0)
		timerbuffer = CONFIG_GET(number/vote_autotransfer_initial)
	else
		timerbuffer = CONFIG_GET(number/vote_autotransfer_interval)
	spawn(timerbuffer)
		SSvote.autotransfer()
		initialtpass = 1
		votetimer()
