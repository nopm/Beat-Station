/obj/item/clothing/mask/stone
	name = "stone mask"
	desc = "A spooky stone mask. Something tells you wearing this is a horrible idea."
	icon_state = "stone_mask"
	item_state = "stone_mask"
	icon = 'beatstation/icons/obj/clothing/masks.dmi'
	alternate_worn_icon = 'beatstation/icons/mob/mask.dmi'
	var/datum/antagonist/vampire

/obj/item/clothing/mask/stone/equipped(mob/M, slot)
	. = ..()
	if(ishuman(M) && slot == ITEM_SLOT_MASK)
		if(M.mind?.has_antag_datum(/datum/antagonist/vampire))
			M.visible_message("<span class='hypnophrase big'>[src] falls off of [M]'s face!</span>")
			M.doUnEquip(src, TRUE)
			src.forceMove(get_turf(M))
			return
		if(M.stat)
			M.visible_message("<span class='hypnophrase big'>[src] falls off of [M]'s face, they don't have enough life force!</span>")
			M.doUnEquip(src, TRUE)
			src.forceMove(get_turf(M))
			return
		if(HAS_BLOOD_DNA(src))
			INVOKE_ASYNC(src, .proc/do_the_thing, M)
		else
			return
	return

/obj/item/clothing/mask/stone/worn_overlays(isinhands = FALSE)
	. = list()
	if(!isinhands)
		if(body_parts_covered & HEAD)
			if(damaged_clothes)
				. += mutable_appearance('icons/effects/item_damage.dmi', "damagedmask")
			if(HAS_BLOOD_DNA(src))
				. += mutable_appearance('icons/effects/blood.dmi', "maskblood")

/obj/item/clothing/mask/stone/update_clothes_damaged_state(damaging = TRUE)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_mask()

/obj/item/clothing/mask/stone/process()
	set_light(4, 10, rgb(rand(1, 127), rand(1, 127), rand(1, 127))) // random bright color?

/obj/item/clothing/mask/stone/proc/do_the_thing(mob/living/carbon/human/H)
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
	H.visible_message("<span class='hypnophrase big'>[src] sinks 6 needles into [H]'s head, and begins to glow a brilliant light!</span>")
	START_PROCESSING(SSobj, src)
	to_chat(H, "<span class='danger bold'>Everything... everything hurts</span>")
	H.SetStun(INFINITY)
	sleep(25)
	to_chat(H, "<span class='danger bold'>You feel kind of hungry...</span>")
	sleep(35)
	to_chat(H, "<span class='danger bold'>Must... consume... blood...</span>")
	sleep(45)
	H.SetStun(0)
	H.fully_heal()
	H.mind?.add_antag_datum(/datum/antagonist/vampire)
	log_admin("[key_name(H)] was made into a vampire by [src]")     //adds message to admins and a log
	message_admins("[key_name(H)] was made into a vampire by [src]")
	REMOVE_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
	STOP_PROCESSING(SSobj, src)
	set_light(0, 0)
	H.visible_message("<span class='hypnophrase'>[src] falls off of [H], it's needles retracting...</span>")
	H.doUnEquip(src, TRUE)
	src.forceMove(get_turf(H))
