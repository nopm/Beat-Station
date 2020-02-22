/datum/config_entry/number/vote_autotransfer_initial	// Length of time before the first autotransfer vote is call (deciseconds, default 2 hours)
	config_entry_value = 72000
	integer = FALSE
	min_val = 6000 // 10 minutes

/datum/config_entry/number/vote_autotransfer_interval	// length of time before next sequential autotransfer vote (deciseconds, default 30 minutes)
	config_entry_value = 18000
	integer = FALSE
	min_val = 6000 // 10 minutes

/datum/config_entry/flag/auto_crew_transfer
