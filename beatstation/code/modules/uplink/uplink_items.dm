/datum/uplink_item/stealthy_weapons/crossbow // wow op ebow 
	name = "Miniature Energy Crossbow"
	desc = "A short bow mounted across a tiller in miniature. Small enough to \
	fit into a pocket or slip into a bag unnoticed. It will synthesize \
	and fire bolts tipped with lethal toxins that will stun \
	targets. It can produce an infinite number of bolts \
	but takes time to automatically recharge after each shot."
	item = /obj/item/gun/energy/kinetic_accelerator/beat_ebow
	cost = 10 // costs 2 extra tc, should be a lil more balanced
	exclude_modes = list()

/datum/uplink_item/dangerous/powergloves
	name = "Power Gloves"
	desc = "Gloves with an integrated tesla power modulator, capable of taking \
	power from nearby power wires and discharging it into the world."
	item = /obj/item/clothing/gloves/color/yellow/palpatine
	cost = 15
	surplus = 20
	exclude_modes = list(/datum/game_mode/infiltration)

/datum/uplink_item/dangerous/butterfly
	cost = 15

/datum/uplink_item/dangerous/cxneb
	name = "Dragon's Tooth Non-Eutactic Blade"
	desc = "An illegal modification of a weapon that is functionally identical to the energy sword, \
			the Non-Eutactic Blade (NEB) forges a hardlight blade on-demand, \
			generating an extremely sharp, unbreakable edge that is guaranteed to satisfy your every need. \
			This particular model has a polychromic hardlight generator, allowing you to murder in style! \
			The illegal modifications bring this weapon up to par with the classic energy sword, and also gives it the energy sword's distinctive sounds."
	item = /obj/item/melee/transforming/energy/sword/cx/traitor
	cost = 15
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear, /datum/game_mode/infiltration, /datum/game_mode/traitor/kotd)
