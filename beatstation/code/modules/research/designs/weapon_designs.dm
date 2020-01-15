/datum/design/xcomrifle
	build_path = /obj/item/gun/ballistic/automatic/xcomrifle/nopin

/datum/design/pin_explorer
	name = "Outback Firing Pin"
	desc = "This firing pin only shoots while ya ain't on station, fair dinkum!"
	id = "pin_explorer"
	build_type = PROTOLATHE
	materials = list(MAT_SILVER = 1000, MAT_GOLD = 1000, MAT_METAL = 500)
	build_path = /obj/item/firing_pin/explorer
	category = list("Firing Pins")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/stun_boomerang
	name = "OZtek Boomerang"
	desc = "Uses reverse flow gravitodynamics to flip its personal gravity back to the thrower mid-flight. Also functions similar to a stun baton."
	id = "stun_boomerang"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_GLASS = 4000, MAT_SILVER = 10000, MAT_GOLD = 2000)
	build_path = /obj/item/melee/baton/boomerang
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
