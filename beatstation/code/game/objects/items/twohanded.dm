// HYPEREUTACTIC Blades - ported from Citadel
/obj/item/twohanded/dualsaber/hypereutactic
	icon = 'beatstation/icons/obj/1x2.dmi'
	icon_state = "hypereutactic"
	lefthand_file = 'beatstation/icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'beatstation/icons/mob/inhands/64x64_righthand.dmi'
	item_state = "hypereutactic"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	name = "hypereutactic blade"
	desc = "A supermassive weapon envisioned to cleave the very fabric of space and time itself in twain, the hypereutactic blade dynamically flash-forges a hypereutactic crystaline nanostructure capable of passing through most known forms of matter like a hot knife through butter."
	force = 7
	force_unwielded = 7
	force_wielded = 40
	wieldsound = 'beatstation/sound/weapons/nebon.ogg'
	unwieldsound = 'beatstation/sound/weapons/neboff.ogg'
	hitsound = 'beatstation/sound/weapons/nebhit.ogg'
	armour_penetration = 60
	light_color = "#37FFF7"
	var/rainbow_colors = list("#FF0000", "#FFFF00", "#00FF00", "#00FFFF", "#0000FF","#FF00FF", "#3399ff", "#ff9900", "#fb008b", "#9800ff", "#00ffa3", "#ccff00")
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "destroyed", "ripped", "devastated", "shredded")
	actions_types = null

/obj/item/twohanded/dualsaber/hypereutactic/chaplain
	name = "\improper divine lightblade"
	desc = "A giant blade of bright and holy light, said to cut down the wicked with ease."
	force = 5
	force_unwielded = 3
	force_wielded = 20
	block_chance = 20
	armour_penetration = 0
	var/reskinned = FALSE
	var/chaplain_spawnable = TRUE
	obj_flags = UNIQUE_RENAME

/obj/item/twohanded/dualsaber/hypereutactic/chaplain/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)

/obj/item/twohanded/dualsaber/hypereutactic/chaplain/IsReflect()
	return FALSE

/obj/item/twohanded/dualsaber/hypereutactic/update_icon()
	var/mutable_appearance/blade_overlay = mutable_appearance(icon, "hypereutactic_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance(icon, "hypereutactic_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other

	add_overlay(gem_overlay)

	if(wielded)
		add_overlay(blade_overlay)
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/twohanded/dualsaber/hypereutactic/AltClick(mob/living/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, FALSE) || hacked)
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		return
	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"","Choose Energy Color",light_color) as color|null
		if(!energy_color_input || !user.canUseTopic(src, BE_CLOSE, FALSE) || hacked)
			return
		light_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
		update_icon()
		update_light()
	return TRUE

/obj/item/twohanded/dualsaber/hypereutactic/worn_overlays(isinhands, icon_file, style_flags = NONE)
	. = ..()
	if(isinhands)
		var/mutable_appearance/gem_inhand = mutable_appearance(icon_file, "hypereutactic_gem")
		gem_inhand.color = light_color
		. += gem_inhand
		if(wielded)
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "hypereutactic_blade")
			blade_inhand.color = light_color
			. += blade_inhand

/obj/item/twohanded/dualsaber/hypereutactic/examine(mob/user)
	. = ..()
	if(!hacked)
		. += "<span class='notice'>Alt-click to recolor it.</span>"

/obj/item/twohanded/dualsaber/hypereutactic/process()
	if(wielded)
		if(hacked)
			rainbow_process()
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/twohanded/dualsaber/hypereutactic/proc/rainbow_process()
	light_color = pick(rainbow_colors)
	update_icon()
	update_light()
