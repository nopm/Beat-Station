/datum/mutation/human/exsweat
	name = "Explosive Sweat"
	desc = "The affected produces nitroglicerin whitin its sweat, causing explosions whenever swinging hands."
	quality = POSITIVE
	locked = TRUE
	difficulty = 12
	text_gain_indication = "<span class='notice'>You start to feel sweaty.</span>"
	text_lose_indication = "<span class='notice'>The heat dies down, and you stop sweating like before.</span>"
	power = /obj/effect/proc_holder/spell/aimed/fireball/exsweat
	instability = 60

/obj/effect/proc_holder/spell/aimed/fireball/exsweat
	name = "Explosive Sweat"
	desc = "Launch sweat mixed with nitroglycerin!"
	school = "evocation"
	charge_max = 500
	clothes_req = FALSE
	range = 20
	invocation = "TSAR ARMAGEDDON"
	invocation_type = "shout"
	projectile_type = /obj/projectile/magic/aoe/fireball/exsweat
	base_icon_state = "syndicate"
	action_icon_state = "syndicate_active"
	active_msg = "Your palms feel sweaty."
	deactive_msg = "You clean up your hands."
	var/strength = 1

/obj/effect/proc_holder/spell/aimed/fireball/exsweat/cast_check(skipcharge = 0,mob/user = usr)
	. = ..()
	var/mob/living/carbon/C = user
	if(C.get_item_by_slot(ITEM_SLOT_GLOVES))
		playsound(C,'sound/effects/explosion2.ogg', 200, TRUE)
		new /obj/effect/temp_visual/explosion(C)
		C.ex_act(EXPLODE_HEAVY)
		to_chat(C,"<span class='warning'>The gloves blocked your hands!</span>")
		return FALSE

/obj/projectile/magic/aoe/fireball/exsweat/on_hit(target)
	. = ..()
	if (ismob(target))
		var/mob/living/M = target
		M.take_overall_damage(0,15)
	var/turf/T = get_turf(target)
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire)

/obj/projectile/magic/aoe/fireball/exsweat
	name = "sweat"
	exp_heavy = 0
	exp_light = 4
	exp_flash = 3
	exp_fire = 0
