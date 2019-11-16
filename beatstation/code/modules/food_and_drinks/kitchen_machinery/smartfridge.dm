// -------------------------
// Organ Surgery Smartfridge
// -------------------------
/obj/machinery/smartfridge/organ
	name = "smart organ storage"
	desc = "A useless refrigerated storage unit for organ storage."
	max_n_of_items = 20	//vastly lower to prevent processing too long
	//var/repair_rate = 0

/obj/machinery/smartfridge/organ/accept_check(obj/item/O)
	if(istype(O, /obj/item/organ) || istype(O, /obj/item/bodypart))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/organ/load(obj/item/O)
	. = ..()
	if(!.)	//if the item loads, clear can_decompose
		return

/obj/machinery/smartfridge/organ/RefreshParts()
	for(var/obj/item/stock_parts/matter_bin/B in component_parts)
		max_n_of_items = 20 * B.rating
