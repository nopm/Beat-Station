//Used for all kinds of weather, ex. lavaland ash storms.
SUBSYSTEM_DEF(weather)
	name = "Weather"
	flags = SS_BACKGROUND
	wait = 10
	runlevels = RUNLEVEL_GAME
	var/list/processing = list()
	var/list/existing_weather = list()
	var/list/eligible_zlevels = list(ZLEVEL_LAVALAND)

/datum/controller/subsystem/weather/fire()
	for(var/V in processing)
		var/datum/weather/W = V
		if(W.aesthetic)
			continue
		for(var/i in GLOB.mob_living_list)
			var/mob/living/L = i
			if(W.can_weather_act(L))
				W.weather_act(L)
	for(var/Z in eligible_zlevels)
		var/list/possible_weather_for_this_z = list()
		for(var/V in existing_weather)
			var/datum/weather/WE = V
			if(WE.target_z == Z && WE.probability) //Another check so that it doesn't run extra weather
				possible_weather_for_this_z[WE] = WE.probability
		var/datum/weather/W = pickweight(possible_weather_for_this_z)
		run_weather(W.name, Z)
		eligible_zlevels -= Z
		addtimer(CALLBACK(src, .proc/make_z_eligible, Z), rand(3000, 6000) + W.weather_duration_upper, TIMER_UNIQUE) //Around 5-10 minutes between weathers

/datum/controller/subsystem/weather/Initialize(start_timeofday)
	..()
	for(var/V in subtypesof(/datum/weather))
		new V //Weather's New() will handle adding stuff to the list

/datum/controller/subsystem/weather/proc/run_weather(weather_name, Z)
	if(!weather_name)
		return
	for(var/V in existing_weather)
		var/datum/weather/W = V
		if(W.name == weather_name && W.target_z == Z)
			W.telegraph()

/datum/controller/subsystem/weather/proc/is_weather_affecting_area(area/A, weather_datum_type)
	for(var/V in processing)
		var/datum/weather/W = V
		if(!istype(W, weather_datum_type))
			continue
		if(A in W.impacted_areas)
			return TRUE
	return FALSE

/datum/controller/subsystem/weather/proc/make_z_eligible(zlevel)
	eligible_zlevels |= zlevel
