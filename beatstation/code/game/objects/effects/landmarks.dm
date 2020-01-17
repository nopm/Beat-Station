/obj/effect/landmark/stationroom
	var/list/template_names = list()
	layer = BULLET_HOLE_LAYER

/obj/effect/landmark/stationroom/New()
	..()
	GLOB.stationroom_landmarks += src

/obj/effect/landmark/stationroom/Destroy()
	if(src in GLOB.stationroom_landmarks)
		GLOB.stationroom_landmarks -= src
	return ..()

/obj/effect/landmark/stationroom/proc/load(template_name)
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	if(!template_name)
		for(var/t in template_names)
			if(!SSmapping.station_room_templates[t])
				log_world("Station room spawner placed at ([T.x], [T.y], [T.z]) has invalid ruin name of \"[t]\" in its list")
				template_names -= t
		template_name = safepick(template_names)
	if(!template_name)
		GLOB.stationroom_landmarks -= src
		qdel(src)
		return FALSE
	var/datum/map_template/template = SSmapping.station_room_templates[template_name]
	if(!template)
		return FALSE
	testing("Ruin \"[template_name]\" placed at ([T.x], [T.y], [T.z])")
	template.load(T, centered = FALSE)
	template.loaded++
	GLOB.stationroom_landmarks -= src
	qdel(src)
	return TRUE


/obj/effect/landmark/stationroom/box/bar
	template_names = list("Bar Trek", "Bar Spacious", "Bar Default", "Bar Casino", "Bar Conveyor", "Bar Diner", "Bar Disco", "Bar Purple", "Bar Box")
	icon = 'beatstation/icons/rooms/bar.dmi'
	icon_state = "bar_box"

/obj/effect/landmark/stationroom/box/xenobridge
	template_names = list("Xenobiology Bridge", "Xenobiology Lattice")
	icon = 'beatstation/icons/rooms/maint_xenobio.dmi'
	icon_state = "xenobio_maint_default"

/obj/effect/landmark/stationroom/box/telescience
	template_names = list("Telescience Lab", "Experimentor Lab", "Circuitry Lab")
	icon = 'beatstation/icons/rooms/sci_telescience.dmi'
	icon_state = "telescience"

/*
/obj/effect/landmark/stationroom/box/foreportmaint1
	template_names = list("Maintenance Surgery")

/obj/effect/landmark/stationroom/box/engine
	template_names = list("Engine SM", "Engine Singulo And Tesla")
	icon = 'yogstation/icons/rooms/engine.dmi'
*/
