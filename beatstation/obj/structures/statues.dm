/obj/structure/statue/sandstone/asstue
	name = "opao statue"
	desc = "THE GREAT PURGE - March 25, 2020."
	icon = 'beatstation/icons/obj/statueopao.dmi'
	icon_state = "opao"

/obj/structure/statue/sandstone/asstue/proc/toot()
	playsound(src, 'beatstation/sound/misc/opao.ogg', 100, 1)

/obj/structure/statue/sandstone/asstue/attackby(obj/item/W, mob/user, params)
	toot()
	return ..()

/obj/structure/statue/sandstone/asstue/attack_hand(mob/user)
	toot()
	. = ..()

/obj/structure/statue/sandstone/asstue/attack_paw(mob/user)
	toot()
	..()

/obj/structure/statue/sandstone/asstue/deconstruct(disassembled = TRUE)
	playsound(src, 'hippiestation/sound/effects/superfart.ogg', 200, 1)
	..()
