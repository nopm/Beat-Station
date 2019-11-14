/obj/structure/closet/secure_closet/freezer/gulag_fridge
	name = "refrigerator"

/obj/structure/closet/secure_closet/freezer/gulag_fridge/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/food/drinks/beer/light(src)
