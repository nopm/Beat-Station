// a BEPIS reward
/obj/item/airlock_painter/decal
	name = "decal painter"
	desc = "An airlock painter, reprogramed to use a different style of paint in order to apply decals for floor tiles as well, in addition to repainting doors. Decals break when the floor tiles are removed. Alt-Click to change design."
	icon = 'beatstation/icons/obj/objects.dmi'
	icon_state = "decal_sprayer"
	item_state = "decalsprayer"
	materials = list(MAT_METAL = 2000, MAT_GLASS = 500)
	var/stored_dir = 2
	var/stored_color = ""
	var/stored_decal = "warningline"
	var/stored_decal_total = "warningline"
	var/color_list = list("","red","white")
	var/dir_list = list(1,2,4,8)
	var/decal_list = list(list("Warning Line","warningline"),
			list("Warning Line Corner","warninglinecorner"),
			list("Caution Label","caution"),
			list("Directional Arrows","arrows"),
			list("Stand Clear Label","stand_clear"),
			list("Box","box"),
			list("Box Corner","box_corners"),
			list("Delivery Marker","delivery"),
			list("Warning Box","warn_full"))

/obj/item/airlock_painter/decal/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/turf/open/floor/F = target
	if(!proximity)
		to_chat(user, "<span class='notice'>You need to get closer!</span>")
		return
	if(use_paint(user) && isturf(F))
		F.AddComponent(/datum/component/decal, 'icons/turf/decals.dmi', stored_decal_total, stored_dir, CLEAN_STRONG, color, null, null, alpha)

/obj/item/airlock_painter/decal/attack_self(mob/user)
	if((ink) && (ink.charges >= 1))
		to_chat(user, "<span class='notice'>[src] beeps to prevent you from removing the toner until out of charges.</span>")
		return
	. = ..()

/obj/item/airlock_painter/decal/AltClick(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/airlock_painter/decal/Initialize()
	. = ..()
	ink = new /obj/item/toner/large(src)

/obj/item/airlock_painter/decal/proc/update_decal_path()
	var/yellow_fix = "" //This will have to do until someone refactor's markings.dm
	if (stored_color)
		yellow_fix = "_"
	stored_decal_total = "[stored_decal][yellow_fix][stored_color]"
	return

/obj/item/airlock_painter/decal/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "decal_painter", name, 500, 400, master_ui, state)
		ui.open()

/obj/item/airlock_painter/decal/ui_data(mob/user)
	var/list/data = list()
	data["decal_direction"] = stored_dir
	data["decal_color"] = stored_color
	data["decal_style"] = stored_decal
	data["decal_list"] = list()
	data["color_list"] = list()
	data["dir_list"] = list()

	for(var/i in decal_list)
		data["decal_list"] += list(list(
			"name" = i[1],
			"decal" = i[2]
		))
	for(var/j in color_list)
		data["color_list"] += list(list(
			"colors" = j
		))
	for(var/k in dir_list)
		data["dir_list"] += list(list(
			"dirs" = k
		))
	return data

/obj/item/airlock_painter/decal/ui_act(action,list/params)
	if(..())
		return
	switch(action)
		//Lists of decals and designs
		if("select decal")
			var/selected_decal = params["decals"]
			stored_decal = selected_decal
		if("select color")
			var/selected_color = params["colors"]
			stored_color = selected_color
		if("selected direction")
			var/selected_direction = text2num(params["dirs"])
			stored_dir = selected_direction
	update_decal_path()
	. = TRUE

/obj/item/airlock_painter/decal/debug
	name = "extreme decal painter"
	icon_state = "decal_sprayer_ex"

/obj/item/airlock_painter/decal/debug/Initialize()
	. = ..()
	ink = new /obj/item/toner/extreme(src)
