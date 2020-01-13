/obj/item/clothing/gloves/color/yellow/palpatine
	name = "power gloves"
	desc = "Gloves capable of giving people quite the shock. <b>DISARM</b> intent to stun, <b>HARM</b> intent to damage."
	special_name = "Powermaster"
	special_desc = "Drains more stamina and possibly causes burn damage the longer it is used."
	special_cost = 0
	actions_types = list(/datum/action/item_action/special_attack)
	var/next_shock = 0
	var/shock_delay = 40
	var/unlimited_power = FALSE
	var/specialing = FALSE

/obj/item/clothing/gloves/color/yellow/palpatine/do_special_attack(atom/target, mob/living/carbon/user)
	if(user.gloves != src || specialing)
		return FALSE
	var/obj/structure/cable/C
	for(var/turf/T in range(2, user))
		C = locate() in T
		if(C && istype(C))
			break
	if(!C || !istype(C))
		return FALSE
	. = ..()
	specialing = TRUE
	user.emote("scream")
	while(do_after_mob(user, user, 15, TRUE))
		if(user.incapacitated() || user.InCritical())
			break
		var/list/targets = list()
		for(var/mob/living/L in view(5, user))
			if(L == user || L.stat == DEAD)
				continue
			targets += L
		playsound(user, 'sound/magic/lightningbolt.ogg', 40, TRUE)	
		var/lt = length(targets)
		for(var/mob/living/L in targets)
			to_chat(L, "<span class='danger bold'>You're hit by lightning!</span>")
			user.Beam(L, icon_state="red_lightning", time=15)
			L.adjustFireLoss(16 / lt)
		if(!LAZYLEN(targets) || prob(30))
			var/list/machines = list()
			for(var/obj/machinery/M in view(world.view, user))
				machines += M
			for(var/i = 1 to rand(3, 7))
				if(!LAZYLEN(machines))
					break
				var/obj/machinery/M = pick_n_take(machines)
				user.Beam(M, icon_state="purple_lightning", time=15)
				M.emp_act(EMP_HEAVY)
		user.adjustStaminaLoss(15)
		if(prob(20))
			user.adjustFireLoss(4 * lt)
	specialing = FALSE
	special_attack = FALSE

/obj/item/clothing/gloves/color/yellow/palpatine/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_GLOVES)
		RegisterSignal(user, COMSIG_MOB_CLICKON, .proc/Zap)
		if(!unlimited_power)
			to_chat(user, "<span class='notice'>You feel electricity begin to build up in [src].</span>")
		else
			to_chat(user, "<span class='bigdanger'>You feel like you have UNLIMITED POWER!!</span>")

/obj/item/clothing/gloves/color/yellow/palpatine/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_CLICKON)

/obj/item/clothing/gloves/color/yellow/palpatine/proc/Zap(mob/user, atom/target, params)
	if(target == user || !iscarbon(user) || user.incapacitated(ignore_grab = TRUE) || specialing)
		return
	var/mob/living/carbon/CL = user
	if(CL.gloves != src)
		return
	if(special_attack)
		INVOKE_ASYNC(src, .proc/do_special_attack, target, user)
		return COMSIG_MOB_CANCEL_CLICKON
	if(!(user.a_intent in list(INTENT_HARM, INTENT_DISARM)) || !(target in view(world.view, user)) || !(isliving(target) || isobj(target)))
		return
	if(next_shock > world.time)
		to_chat(user, "<span class='warning'>You must wait [DisplayTimeText(next_shock - world.time)] until you can shock again.</span>")
		return
	var/turf/UT = get_turf(user)
	var/obj/structure/cable/C = locate() in UT
	if(!unlimited_power)
		if(!C || !istype(C))
			to_chat(user, "<span class='warning'>There is no cable here to power the gloves.</span>")
			return
	if(isliving(target))
		target.visible_message("<span class='danger'>A bolt of electricity erupts from [user]'s hands, electrocuting [target]!</span>", "<span class='userdanger'>A bolt of electricity erupts from [user]'s hands, electrocuting you!</span>", "<i>You hear a <b>ZAP!</b></i>")
		user.Beam(target, icon_state="red_lightning", time=10)
	else
		target.visible_message("<span class='danger'>A bolt of electricity erupts from [user]'s hands, zapping [target]!</span>")
		user.Beam(target, icon_state="purple_lightning", time=10)
	playsound(user, 'sound/magic/lightningbolt.ogg', 40, TRUE)	
	if(isliving(target))
		var/mob/living/L = target
		if(user.a_intent == INTENT_DISARM)
			L.Paralyze(50)
		else
			if(unlimited_power)
				if(iscarbon(L))
					var/mob/living/carbon/D = L
					D.electrocute_act(1000, src, safety = TRUE, override = TRUE) //Just kill them
				else
					L.adjustFireLoss(1000)
			else
				electrocute_mob(L, C, src)
				var/damage = get_damage_electrodo(C)
				L.adjustFireLoss(damage)
	else if(isobj(target))
		target.emp_act(EMP_HEAVY)
	next_shock = world.time + shock_delay
	return COMSIG_MOB_CANCEL_CLICKON

// /proc/electrocute_mob, but this one actually only calculate the damage according to the power of power_source
/proc/get_damage_electrodo(power_source)
	var/area/source_area
	if(istype(power_source, /area))
		source_area = power_source
		power_source = source_area.get_apc()
	if(istype(power_source, /obj/structure/cable))
		var/obj/structure/cable/Cable = power_source
		power_source = Cable.powernet

	var/datum/powernet/PN
	var/obj/item/stock_parts/cell/cell

	if(istype(power_source, /datum/powernet))
		PN = power_source
	else if(istype(power_source, /obj/item/stock_parts/cell))
		cell = power_source
	else if(istype(power_source, /obj/machinery/power/apc))
		var/obj/machinery/power/apc/apc = power_source
		cell = apc.cell
		if (apc.terminal)
			PN = apc.terminal.powernet
	else if (!power_source)
		return FALSE
	else
		log_admin("ERROR: /proc/get_damage_electrodo([power_source]) : wrong power_source")
		return FALSE
	if (!cell && !PN)
		return FALSE
	var/PN_damage = 0
	var/cell_damage = 0
	if (PN)
		PN_damage = PN.get_electrocute_damage()
	if (cell)
		cell_damage = cell.get_electrocute_damage()
	var/shock_damage = 0
	if (PN_damage>=cell_damage)
		power_source = PN
		shock_damage = PN_damage
	else
		power_source = cell
		shock_damage = cell_damage
	
	return shock_damage