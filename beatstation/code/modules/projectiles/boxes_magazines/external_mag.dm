/obj/item/ammo_box/magazine/sec_glock
	name = "\improper Security Glock magazine (9mm)"
	desc = "A gun magazine."
	icon = 'beatstation/icons/obj/ammo/ammo.dmi'
	icon_state = "sec_g"
	ammo_type = /obj/item/ammo_casing/g9mm
	caliber = "9mm"
	max_ammo = 9

/obj/item/ammo_box/magazine/sec_glock/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(0)/9, 1)*9]"
