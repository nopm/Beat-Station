/****************HECK Suit & Helmet****************/

/obj/item/clothing/suit/space/hostile_environment
	name = "H.E.C.K. suit"
	desc = "Hostile Environment Cross-Kinetic Suit: A suit designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	item_state = "hostile_env"
	clothing_flags = THICKMATERIAL | STOPSPRESSUREDAMAGE //IS spaceproof
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	slowdown = 0
	armor = list("melee" = 75, "bullet" = 40, "laser" = 10, "energy" = 10, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)

/obj/item/clothing/head/helmet/space/hostile_environment
	name = "H.E.C.K. helmet"
	desc = "Hostile Environiment Cross-Kinetic Helmet: A helmet designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	item_state = "hostile_env"
	w_class = WEIGHT_CLASS_NORMAL
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	clothing_flags = THICKMATERIAL | STOPSPRESSUREDAMAGE// YES space protection
	armor = list("melee" = 75, "bullet" = 40, "laser" = 10, "energy" = 10, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/****************SEVA Suit and Mask****************/

/obj/item/clothing/suit/hooded/explorer/seva
	name = "SEVA Suit"
	desc = "A fire-proof suit for exploring hot environments."
	icon = 'beatstation/icons/obj/clothing/suits.dmi'
	icon_state = "seva"
	alternate_worn_icon = 'beatstation/icons/mob/suit.dmi'
	item_state = "seva"
	w_class = WEIGHT_CLASS_BULKY
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/explorer/seva
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 25, "bio" = 50, "rad" = 25, "fire" = 100, "acid" = 25)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/hooded/explorer/seva
	name = "SEVA Hood"
	desc = "A fire-proof hood for exploring hot environments."
	icon = 'beatstation/icons/obj/clothing/hats.dmi'
	icon_state = "seva"
	alternate_worn_icon = 'beatstation/icons/mob/head.dmi'
	item_state = "seva"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 25, "bio" = 50, "rad" = 25, "fire" = 100, "acid" = 25)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/hooded/explorer/seva/Initialize()
	..()
	var/datum/component/armor_plate/A = GetComponent(/datum/component/armor_plate)
	qdel(A)

/obj/item/clothing/head/hooded/explorer/seva/Initialize()
	..()
	var/datum/component/armor_plate/A = GetComponent(/datum/component/armor_plate)
	qdel(A)

/obj/item/clothing/mask/gas/seva
	name = "SEVA Mask"
	desc = "A face-covering plate that can be connected to an air supply. Intended for use with the SEVA Suit."
	icon = 'beatstation/icons/obj/clothing/masks.dmi'
	icon_state = "seva"
	alternate_worn_icon = 'beatstation/icons/mob/mask.dmi'
	item_state = "seva"
	resistance_flags = FIRE_PROOF

/****************Exo-Suit and Mask****************/

/obj/item/clothing/suit/hooded/explorer/exo
	name = "Exo-suit"
	desc = "A robust suit for exploring dangerous environments."
	icon = 'beatstation/icons/obj/clothing/suits.dmi'
	icon_state = "exo"
	alternate_worn_icon = 'beatstation/icons/mob/suit.dmi'
	item_state = "exo"
	w_class = WEIGHT_CLASS_BULKY
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/explorer/exo
	armor = list("melee" = 65, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 60, "bio" = 25, "rad" = 10, "fire" = 0, "acid" = 0)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/hooded/explorer/exo
	name = "Exo-hood"
	desc = "A robust helmet for exploring dangerous environments."
	icon = 'beatstation/icons/obj/clothing/hats.dmi'
	icon_state = "exo"
	alternate_worn_icon = 'beatstation/icons/mob/head.dmi'
	item_state = "exo"
	armor = list("melee" = 65, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 60, "bio" = 25, "rad" = 10, "fire" = 0, "acid" = 0)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/hooded/explorer/exo/Initialize()
	..()
	var/datum/component/armor_plate/A = GetComponent(/datum/component/armor_plate)
	qdel(A)

/obj/item/clothing/head/hooded/explorer/exo/Initialize()
	..()
	var/datum/component/armor_plate/A = GetComponent(/datum/component/armor_plate)
	qdel(A)

/obj/item/clothing/mask/gas/exo
	name = "Exosuit Mask"
	desc = "A face-covering mask that can be connected to an air supply. Intended for use with the Exosuit."
	icon = 'beatstation/icons/obj/clothing/masks.dmi'
	icon_state = "exo"
	alternate_worn_icon = 'beatstation/icons/mob/mask.dmi'
	item_state = "exo"
	resistance_flags = FIRE_PROOF
