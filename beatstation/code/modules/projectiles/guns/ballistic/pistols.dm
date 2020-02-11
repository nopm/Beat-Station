/obj/item/gun/ballistic/automatic/pistol/sec_glock
	name = "\improper Security Glock"
	desc = "A burst 9mm gun used by NanoTrasen security officers."
	icon = 'hippiestation/icons/obj/guns/projectile.dmi'
	icon_state = "glock17"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/sec_glock
	burst_size = 3
	fire_delay = 1
	actions_types = list(/datum/action/item_action/toggle_firemode)
	flight_x_offset = 18
	fire_sound = list('hippiestation/sound/weapons/pistol_glock17_1.ogg','hippiestation/sound/weapons/pistol_glock17_2.ogg')

