/datum/config_entry/number/vote_autotransfer_initial	// Length of time before the first autotransfer vote is call
	config_entry_value = 108000 // 180 minutes
	integer = FALSE
	min_val = 6000 // 10 minutes

/datum/config_entry/number/vote_autotransfer_interval	// length of time before next sequential autotransfer vote
	config_entry_value = 36000 // 60 minutes
	integer = FALSE
	min_val = 6000 // 10 minutes

/datum/config_entry/flag/auto_crew_transfer

/client/verb/teste()
	to_chat(world, "<span class='boldannounce'>[CONFIG_GET(number/vote_autotransfer_initial)]</span>")
