/datum/martial_art/krav_medical
	name = "Krav Medical"
	id = MARTIALART_KRAVMAGA
	var/datum/action/neck_chop/neckchop = new/datum/action/neck_chop()
	var/datum/action/leg_sweep/legsweep = new/datum/action/leg_sweep()
	var/just_a_med = FALSE
	var/static/list/areas_under_siege = typecacheof(list(/area/medical/medbay/central,
														 /area/medical/medbay/lobby,
														 /area/medical/medbay/aft,
														 /area/medical/medbay/zone2,
	                                                     /area/medical/chemistry,
														 /area/medical/sleeper,
														 /area/medical/morgue,
														 /area/medical/genetics,
														 /area/medical/genetics/cloning,
														 /area/medical/exam_room,
														 /area/medical/virology,
														 /area/medical/storage,
														 /area/medical/cryo,
														 /area/medical/patients_rooms,
														 /area/medical/patients_rooms/room_a,
														 /area/medical/patients_rooms/room_b,
														 /area/crew_quarters/heads/cmo))

/datum/martial_art/krav_medical/under_siege
	name = "MedMaga"
	just_a_med = TRUE

/datum/martial_art/proc/can_med(mob/living/carbon/human/H)
	return TRUE

/datum/martial_art/krav_medical/can_med(mob/living/carbon/human/H)
	var/area/A = get_area(H)
	if(just_a_med && !(is_type_in_typecache(A, areas_under_siege)))
		return FALSE
	return ..()

/datum/action/neck_chop
	name = "Neck Chop - Injures the neck, stopping the victim from speaking for a while."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "neckchop"

/datum/action/neck_chop/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't use [name] while you're incapacitated.</span>")
		return
	var/mob/living/carbon/human/H = owner
	if (H.mind.martial_art.streak == "neck_chop")
		owner.visible_message("<span class='danger'>[owner] assumes a neutral stance.</span>", "<b><i>Your next attack is cleared.</i></b>")
		H.mind.martial_art.streak = ""
	else
		owner.visible_message("<span class='danger'>[owner] assumes the Neck Chop stance!</span>", "<b><i>Your next attack will be a Neck Chop.</i></b>")
		H.mind.martial_art.streak = "neck_chop"

/datum/action/leg_sweep
	name = "Leg Sweep - Trips the victim, knocking them down for a brief moment."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "legsweep"

/datum/action/leg_sweep/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't use [name] while you're incapacitated.</span>")
		return
	var/mob/living/carbon/human/H = owner
	if (H.mind.martial_art.streak == "leg_sweep")
		owner.visible_message("<span class='danger'>[owner] assumes a neutral stance.</span>", "<b><i>Your next attack is cleared.</i></b>")
		H.mind.martial_art.streak = ""
	else
		owner.visible_message("<span class='danger'>[owner] assumes the Leg Sweep stance!</span>", "<b><i>Your next attack will be a Leg Sweep.</i></b>")
		H.mind.martial_art.streak = "leg_sweep"

/datum/martial_art/krav_medical/teach(mob/living/carbon/human/H,make_temporary=0)
	if(..())
		to_chat(H, "<span class = 'userdanger'>You know the arts of [name]!</span>")
		to_chat(H, "<span class = 'danger'>Place your cursor over a move at the top of the screen to see what it does.</span>")
		neckchop.Grant(H)
		legsweep.Grant(H)

/datum/martial_art/krav_medical/on_remove(mob/living/carbon/human/H)
	to_chat(H, "<span class = 'userdanger'>You suddenly forget the arts of [name]...</span>")
	neckchop.Remove(H)
	legsweep.Remove(H)

/datum/martial_art/krav_medical/proc/check_streak(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(!can_med(A))
		return FALSE
	switch(streak)
		if("neck_chop")
			streak = ""
			neck_chop(A,D)
			return 1
		if("leg_sweep")
			streak = ""
			leg_sweep(A,D)
			return 1
	return 0

/datum/martial_art/krav_medical/proc/leg_sweep(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(!can_med(A))
		return FALSE
	if(D.stat || D.IsParalyzed())
		return 0
	D.visible_message("<span class='warning'>[A] leg sweeps [D]!</span>", \
					  	"<span class='userdanger'>[A] leg sweeps you!</span>")
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, 1, -1)
	D.apply_damage(1.5, BRUTE)
	D.Paralyze(40)
	log_combat(A, D, "leg sweeped")
	return 1

/datum/martial_art/krav_medical/proc/neck_chop(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(!can_med(A))
		return FALSE
	D.visible_message("<span class='warning'>[A] karate chops [D]'s neck!</span>", \
				  	"<span class='userdanger'>[A] karate chops your neck, rendering you unable to speak!</span>")
	playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	D.apply_damage(1, A.dna.species.attack_type)
	if(D.silent <= 10)
		D.silent = CLAMP(D.silent + 10, 0, 10)
	log_combat(A, D, "neck chopped")
	return 1

/datum/martial_art/krav_medical/grab_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(!can_med(A))
		return FALSE
	if(check_streak(A,D))
		return 1
	log_combat(A, D, "grabbed (Krav Medical)")
	..()

/datum/martial_art/krav_medical/harm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(!can_med(A))
		return FALSE
	if(check_streak(A,D))
		return 1
	log_combat(A, D, "punched")
	var/picked_hit_type = pick("punches", "kicks")
	var/bonus_damage = 0
	if(!(D.mobility_flags & MOBILITY_STAND))
		bonus_damage += 2
		picked_hit_type = "stomps on"
	D.apply_damage(bonus_damage, A.dna.species.attack_type)
	if(picked_hit_type == "kicks" || picked_hit_type == "stomps on")
		A.do_attack_animation(D, ATTACK_EFFECT_KICK)
		playsound(get_turf(D), 'sound/effects/hit_kick.ogg', 50, 1, -1)
	else
		A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
		playsound(get_turf(D), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	D.visible_message("<span class='danger'>[A] [picked_hit_type] [D]!</span>", \
					  "<span class='userdanger'>[A] [picked_hit_type] you!</span>")
	log_combat(A, D, "[picked_hit_type] with [name]")
	return 1

/datum/martial_art/krav_medical/disarm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(!can_med(A))
		return FALSE
	if(check_streak(A,D))
		return 1
	var/obj/item/I = null
	if(prob(60))
		I = D.get_active_held_item()
		if(I)
			if(D.temporarilyRemoveItemFromInventory(I))
				A.put_in_hands(I)
		D.visible_message("<span class='danger'>[A] has disarmed [D]!</span>", \
							"<span class='userdanger'>[A] has disarmed [D]!</span>")
		playsound(D, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	else
		D.visible_message("<span class='danger'>[A] attempted to disarm [D]!</span>", \
							"<span class='userdanger'>[A] attempted to disarm [D]!</span>")
		playsound(D, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
	log_combat(A, D, "disarmed (Krav Medical)", "[I ? " removing \the [I]" : ""]")
	return 1

//Krav Medical Gloves

/obj/item/clothing/gloves/krav_medical
	var/datum/martial_art/krav_medical/style = new

/obj/item/clothing/gloves/krav_medical/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_GLOVES)
		var/mob/living/carbon/human/H = user
		style.teach(H,1)

/obj/item/clothing/gloves/krav_medical/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		style.remove(H)

/obj/item/clothing/gloves/krav_medical/med
	name = "krav medical gloves"
	desc = "These gloves can teach you to perform Krav Medical using nanochips."
	icon_state = "fightgloves"
	item_state = "fightgloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

//Krav Medical implant

/obj/item/implant/krav_medical
	name = "krav medical implant"
	desc = "Teaches you the arts of Krav Medical in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"
	activated = 1
	var/datum/martial_art/krav_medical/style = new

/obj/item/implant/krav_medical/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Krav Medical Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Krav Medical."}
	return dat

/obj/item/implant/krav_medical/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_KRAVMAGA))
		style.remove(H)
	else
		style.teach(H,1)

/obj/item/implanter/krav_medical
	name = "implanter (krav medical)"
	imp_type = /obj/item/implant/krav_medical

/obj/item/implantcase/krav_medical
	name = "implant case - 'Krav Medical'"
	desc = "A glass case containing an implant that can teach the user the arts of Krav Medical."
	imp_type = /obj/item/implant/krav_medical
