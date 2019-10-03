/obj/item/gun/energy/kinetic_accelerator/premiumka
	name = "premium accelerator"
	desc = "A premium kinetic accelerator fitted with an extended barrel and increased pressure tank."
	icon = 'beatstation/icons/obj/guns/energy.dmi'
	icon_state = "premiumgun"
	item_state = "premiumgun"
	lefthand_file = 'beatstation/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'beatstation/icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium)
	max_mod_capacity = 120

/obj/item/gun/energy/kinetic_accelerator/premiumka/adminka
	name = "administration accelerator"
	desc = "A premium kinetic accelerator infused with a bluespace mod chamber."
	icon = 'beatstation/icons/obj/guns/energy.dmi'
	icon_state = "premiumgun"
	item_state = "premiumgun"
	lefthand_file = 'beatstation/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'beatstation/icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium)
	max_mod_capacity = 1000

/obj/item/gun/energy/kinetic_accelerator/premiumka/dropped()
	. = ..()
	if(!QDELING(src) && !holds_charge)
		// Put it on a delay because moving item from slot to hand
		// calls dropped().
		addtimer(CALLBACK(src, .proc/empty_if_not_held), 1.60)

/obj/item/ammo_casing/energy/kinetic/premium
	projectile_type = /obj/item/projectile/kinetic/premium

/obj/item/projectile/kinetic/premium
	name = "kinetic force"
	icon_state = null
	damage = 50
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	log_override = TRUE

/obj/item/gun/energy/kinetic_accelerator/premiumka/update_icon()
	..()
	if(!can_shoot())
		add_overlay("[icon_state]_empty")
	else
		cut_overlays()
