/obj/item/stack/rods/lava
	name = "heat resistant rod"
	desc = "Treated, specialized metal rods. When exposed to the vaccum of space their coating breaks off, but they can hold up against the extreme heat of active lava."
	singular_name = "heat resistant rod"
	icon_state = "rods"
	item_state = "rods"
	color = "#5286b9ff"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	materials = list(MAT_METAL = 1000, MAT_PLASMA = 500, MAT_TITANIUM = 2000)
	max_amount = 30
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/stack/rods/lava/thirty
	amount = 30
