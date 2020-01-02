GLOBAL_LIST_EMPTY(portais)

/* Ported from Paradise -- Neo */

// Used by /obj/effect/view_portal/visual
/obj/effect/portal_sensor
	invisibility = 101
	var/light_hash = -1
	var/triggered_this_tick = 0
	var/datum/owner			// owner that receive signals
	var/list/params[0]		// what to send to the main object to indicate which sensor
	var/trigger_limit = 5	// number of time we're allowed to trigger per ptick

/obj/effect/portal_sensor/New(loc, o, ...)
	..()
	owner = o
	if(args.len >= 3)
		params = args.Copy(3)
	START_PROCESSING(SSobj, src)
	trigger()

/obj/effect/portal_sensor/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/portal_sensor/Crossed(A, oldloc)
	trigger()

/obj/effect/portal_sensor/Uncrossed(A)
	trigger()

/obj/effect/portal_sensor/process()
	check_light()
	if(triggered_this_tick >= trigger_limit)
		call(owner, "trigger")(arglist(params))
	triggered_this_tick = 0

/obj/effect/portal_sensor/proc/trigger()
	triggered_this_tick++
	if(triggered_this_tick < trigger_limit)
		call(owner, "trigger")(arglist(params))

/obj/effect/portal_sensor/proc/check_light()
	var/turf/T = loc
	if(istype(T) && T.lighting_object && !T.lighting_object.needs_update)
		var/atom/movable/lighting_object/O = T.lighting_object
		var/hash = 0
		
		for(var/lighting_corner in O)
			var/datum/lighting_corner/C = lighting_corner
			hash = hash + C.lum_r + C.lum_g + C.lum_b
			
		if(hash != light_hash)
			light_hash = hash
			trigger()
	else
		if(light_hash != -1)
			light_hash = -1
			trigger()

// remote end of narnia portal
/obj/effect/view_portal
	name = "portal target"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x2"
	invisibility = 101
	anchored = 1

	var/id = null				// id of other portal turf we connect to

	var/obj/effect/view_portal/other = null
	//var/global/list/portais[0]

/obj/effect/view_portal/New()
	..()
	GLOB.portais += src

/obj/effect/view_portal/Initialize()
	..()
	if(id)
		for(var/obj/effect/view_portal/O in GLOB.portais)
			if(id == O.id && O != src && can_link(O))
				other = O
				O.other = src
				linkup()
				O.linkup()
				if(other)
					return

/obj/effect/view_portal/Destroy()
	GLOB.portais -= src
	return ..()

/obj/effect/view_portal/proc/can_link(obj/effect/view_portal/P)
	return P.type == /obj/effect/view_portal/visual && !P.other

/obj/effect/view_portal/proc/linkup()
	// allow it to link to multiple visual nodes
	other = null

// near end of nania portal
/obj/effect/view_portal/visual
	name = "???"
	desc = "You'll have to get closer to clearly see what this is."

	icon = 'beatstation/icons/turf/floors.dmi'
	icon_state = "loadingarea"
	opacity = 1
	density = 1
	invisibility = 0
	appearance_flags = TILE_BOUND | KEEP_TOGETHER
	var/dist = 6				// dist that we render out
	var/radius = 3				// dist we render on other axis, in each direction
	var/frustrum = 0			// if 1, get wider and wider at each step outward
	var/teleport = 1			// should teleport?

	var/list/render_block
	var/list/sensors[0]
	var/list/tiles[0]

	var/list/near_render_block
	var/turf/near_viewpoint

/obj/effect/view_portal/visual/Destroy()
	for(var/T in sensors)
		qdel(sensors[T])
	sensors.Cut()
	sensors = null
	for(var/T in tiles)
		qdel(tiles[T])
	tiles.Cut()
	tiles = null
	render_block = null
	near_render_block = null
	near_viewpoint = null
	return ..()

/obj/effect/view_portal/visual/can_link(obj/effect/view_portal/P)
	return P.type == /obj/effect/view_portal

/obj/effect/view_portal/visual/linkup()
	icon = null
	icon_state = null
	var/turf/Tloc = get_turf(loc)
	if(Tloc)
		Tloc.icon = null
		Tloc.icon_state = null
		Tloc.dynamic_lighting = 0
		layer = AREA_LAYER + 0.5

	// setup references
	var/crossdir = angle2dir((dir2angle(dir) + 90) % 360)
	near_viewpoint = get_step(get_turf(src), GetOppositeDir(dir))

	// setup far turfs
	var/turf/T1 = get_turf(other)
	var/turf/T2 = T1

	for(var/i in 1 to radius)
		T1 = get_step(T1, crossdir)
		T2 = get_step(T2, GetOppositeDir(crossdir))
	if(frustrum)
		// make a trapazoid, with length dist, short end radius*2 long,
		// and 45 degree angles
		render_block = block(T1, T2)
		for(var/i in 1 to dist)
			T1 = get_step(get_step(T1, dir), crossdir)
			T2 = get_step(get_step(T2, dir), GetOppositeDir(crossdir))
			render_block += block(T1, T2)
	else
		// else make a box dist x radius*2
		for(var/i in 1 to dist)
			T2 = get_step(T2, dir)
		render_block = block(T1, T2)
	for(var/turf/T in render_block)
		sensors[T] = new /obj/effect/portal_sensor(T, src, 0, T)

// setup turfs on this side of the portal to cover the map streaming
// has to be done later for view() to be correct (so it happens when the walls exist)
/obj/effect/view_portal/visual/proc/setup_near()
	var/nvs = dir & (EAST|WEST) ? near_viewpoint.x - x : near_viewpoint.y - y
	if(nvs)
		nvs = SIGN(nvs)
	// need a mob for view() to work correctly
	var/mob/M = new(near_viewpoint)
	M.see_invisible = SEE_INVISIBLE_LIVING
	near_render_block = view(M, world.view)
	qdel(M)
	for(var/A in near_render_block)
		var/turf/T = A
		if(istype(T))
			var/ts = dir & (EAST|WEST) ? T.x - x : T.y - y
			if(ts)
				ts = SIGN(ts)
			if(nvs == ts)
				sensors[T] = new /obj/effect/portal_sensor(T, src, 1, T)
			else
				near_render_block -= T
		else
			near_render_block -= T

/obj/effect/view_portal/visual/Bumped(atom/movable/thing)
	if((istype(thing, /obj) || isliving(thing)) && other && teleport)
		if(!near_render_block)
			setup_near()

		var/mob/living/M = thing
		// make the person glide onto the dest, giving a smooth transition
		var/ox = thing.x - x
		var/oy = thing.y - y
		if(istype(M) && M.client)
			M.notransform = 1
			// cover up client-side map loading
			M.screen_loc = "CENTER"
			M.client.screen += M
			for(var/T in tiles)
				M.client.screen += tiles[T]

		// wait a tick for the screen to replicate across network
		// or this whole exercise of covering the transition is pointless
		spawn(1)
			thing.forceMove(locate(other.x + ox, other.y + oy, other.z))
			sleep(1)
			if(istype(M) && M.client)
				for(var/T in tiles)
					M.client.screen -= tiles[T]
				M.client.screen -= M
				M.screen_loc = initial(M.screen_loc)
			thing.forceMove(get_turf(other.loc))
			if(istype(M) && M.client)
				M.notransform = 0

/obj/effect/view_portal/visual/attack_ghost(mob/user)
	user.forceMove(get_turf(other.loc))

/obj/effect/view_portal/visual/proc/trigger(near, turf/T)
	var/obj/effect/view_portal_dummy/D = tiles[T]
	if(D)
		D.overlays.Cut()
	else
		D = new(src, near, T)
		tiles[T] = D

	// render atoms to overlays of a dummy object
	if(D.name != T.name)
		D.name = T.name
		D.desc = T.desc
	for(var/AX in list(T) + T.contents)
		var/atom/A = AX
		if(A && A.invisibility <= SEE_INVISIBLE_LIVING)
			var/image/I = image(A, layer = D.layer + A.layer * 0.01, dir = A.dir)
			I.pixel_x = A.pixel_x
			I.pixel_y = A.pixel_y
			D.overlays += I

// tile of rendered other side for narnia portal
/obj/effect/view_portal_dummy
	var/obj/effect/view_portal/visual/owner

/obj/effect/view_portal_dummy/New(obj/effect/view_portal/visual/V, near, turf/T)
	..()
	if(!near)
		loc = V.loc
	owner = V

	var/ox
	var/oy
	if(near)
		ox = (T.x - V.near_viewpoint.x)
		oy = (T.y - V.near_viewpoint.y)
		layer = AREA_LAYER + 0.4
	else
		ox = T.x - V.other.x + V.x - V.near_viewpoint.x
		oy = T.y - V.other.y + V.y - V.near_viewpoint.y
		pixel_x = 32 * (T.x - V.other.x)
		pixel_y = 32 * (T.y - V.other.y)
		layer = AREA_LAYER + 0.5
	if(abs(ox) <= world.view && abs(oy) <= world.view)
		screen_loc = "CENTER[ox >= 0 ? "+" : ""][ox],CENTER[oy >= 0 ? "+" : ""][oy]"

/obj/effect/view_portal_dummy/attack_ghost(mob/user)
	owner.attack_ghost(user)

proc/GetOppositeDir(var/dir)
	switch(dir)
		if(NORTH)     return SOUTH
		if(SOUTH)     return NORTH
		if(EAST)      return WEST
		if(WEST)      return EAST
		if(SOUTHWEST) return NORTHEAST
		if(NORTHWEST) return SOUTHEAST
		if(NORTHEAST) return SOUTHWEST
		if(SOUTHEAST) return NORTHWEST
	return 0
