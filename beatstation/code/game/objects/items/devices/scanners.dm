/obj/item/scanner_wand
	name = "kiosk scanner wand"
	icon = 'beatstation/icons/obj/device.dmi'
	icon_state = "scanner_wand"
	item_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "An wand for scanning someone else for a medical analysis. Insert into a kiosk is make the scanned patient the target of a health scan."
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	var/selected_target = null

/obj/item/scanner_wand/attack(mob/living/M, mob/living/carbon/human/user)
	flick("[icon_state]_active", src)	//nice little visual flash when scanning someone else.

	if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(25))
		user.visible_message("<span class='warning'>[user] targets himself for scanning.</span>", \
		to_chat(user, "<span class='info'>You try scanning [M], before realizing you're holding the scanner backwards. Whoops.</span>"))
		selected_target = user
		return

	if(!ishuman(M))
		to_chat(user, "<span class='info'>You can only scan human-like, non-robotic beings.</span>")
		selected_target = null
		return

	user.visible_message("<span class='notice'>[user] targets [M] for scanning.</span>", \
						"<span class='notice'>You target [M] vitals.</span>")
	selected_target = M
	return

/obj/item/scanner_wand/attack_self(mob/user)
	to_chat(user, "<span class='info'>You clear the scanner's target.</span>")
	selected_target = null

/obj/item/scanner_wand/proc/return_patient()
	var/returned_target = selected_target
	return returned_target
