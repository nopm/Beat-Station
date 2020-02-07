/obj/item/assembly/flash/synthetic
	name = "synthetic flash"
	desc = "When a problem arises, SCIENCE is the solution."
	icon = 'beatstation/icons/obj/device.dmi'
	icon_state = "sflash"
	flashing_overlay = "sflash2"

/obj/item/assembly/flash/synthetic/flash_carbon(mob/living/carbon/M, mob/user, power = 10, targeted = TRUE, generic_message = FALSE)
	if(!istype(M))
		return
	if(user)
		log_combat(user, M, "[targeted? "flashed(targeted)" : "flashed(AOE)"]", src)
	else
		M.log_message("was [targeted? "flashed(targeted)" : "flashed(AOE)"]",LOG_ATTACK)
	if(generic_message && M != user)
		to_chat(M, "<span class='disarm'>[src] emits a blinding light!</span>")
	if(targeted)
		if(M.flash_act(1, 1))
			if(M.confused < power)
				var/diff = power * CONFUSION_STACK_MAX_MULTIPLIER - M.confused
				M.confused += min(power, diff)
			if(user)
				terrible_conversion_proc(M, user)
				visible_message("<span class='disarm'>[user] blinds [M] with the flash!</span>")
				to_chat(user, "<span class='danger'>You blind [M] with the flash!</span>")
				to_chat(M, "<span class='userdanger'>[user] blinds you with the flash!</span>")
			else
				to_chat(M, "<span class='userdanger'>You are blinded by [src]!</span>")
		else if(user)
			visible_message("<span class='disarm'>[user] fails to blind [M] with the flash!</span>")
			to_chat(user, "<span class='warning'>You fail to blind [M] with the flash!</span>")
			to_chat(M, "<span class='danger'>[user] fails to blind you with the flash!</span>")
		else
			to_chat(M, "<span class='danger'>[src] fails to blind you!</span>")
	else
		if(M.flash_act())
			var/diff = power * CONFUSION_STACK_MAX_MULTIPLIER - M.confused
			M.confused += min(power, diff)

/obj/item/assembly/flash/synthetic/attack(mob/living/M, mob/user)
	if(!try_use_flash(user))
		return FALSE
	if(iscarbon(M))
		flash_carbon(M, user, 5, 1)
		burn_out()
		return TRUE
	else if(issilicon(M))
		var/mob/living/silicon/robot/R = M
		log_combat(user, R, "flashed", src)
		update_icon(1)
		R.Paralyze(rand(25))
		var/diff = 5 * CONFUSION_STACK_MAX_MULTIPLIER - M.confused
		R.confused += min(5, diff)
		R.flash_act(affect_silicon = 1)
		user.visible_message("<span class='disarm'>[user] overloads [R]'s sensors with the flash!</span>", "<span class='danger'>You overload [R]'s sensors with the flash!</span>")
		burn_out()
		return TRUE
	if(!burnt_out)
		burn_out()
	user.visible_message("<span class='disarm'>[user] fails to blind [M] with the flash!</span>", "<span class='warning'>You fail to blind [M] with the flash!</span>")

/obj/item/assembly/flash/synthetic/attack_self(mob/living/carbon/user, flag = 0, emp = 0)
	..()
	if(!burnt_out)
		burn_out()
