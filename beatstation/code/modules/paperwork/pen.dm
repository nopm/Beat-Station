/obj/item/pen/survival
	name = "survival pen"
	desc = "The latest in portable survival technology, this pen was designed as a miniature diamond pickaxe. Watchers find them very desirable for their diamond exterior."
	icon = 'beatstation/icons/obj/bureaucracy.dmi'
	icon_state = "digging_pen"
	item_state = "pen"
	force = 3
	w_class = WEIGHT_CLASS_TINY
	materials = list(MAT_METAL = 10, MAT_DIAMOND = 100, MAT_TITANIUM = 10)
	pressure_resistance = 2
	grind_results = list(/datum/reagent/iron = 2, /datum/reagent/iodine = 1)
	tool_behaviour = TOOL_MINING //For the classic "digging out of prison with a spoon but you're in space so this analogy doesn't work" situation.
	toolspeed = 10 //You will never willingly choose to use one of these over a shovel.
