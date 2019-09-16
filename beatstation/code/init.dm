/proc/beat_initialize()
	// Init stuff here, perhaps?
	set_up_dynamic_gm()
	
// Customizes the dynamic gamemode to our needs.
// This needs to be modularized badly, but it will do for now.
// -- Nopm
/proc/set_up_dynamic_gm()
	GLOB.dynamic_no_stacking = FALSE
	GLOB.dynamic_curve_centre = 5
	GLOB.dynamic_curve_width = 4
	GLOB.dynamic_high_pop_limit = 25 // 25 is considered high pop for us