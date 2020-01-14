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
