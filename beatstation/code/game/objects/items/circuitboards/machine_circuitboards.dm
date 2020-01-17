/obj/item/circuitboard/machine/medical_kiosk
	name = "Medical Kiosk (Machine Board)"
	//icon_state = "medical"
	build_path = /obj/machinery/medical_kiosk
	var/custom_cost = 10
	req_components = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/stock_parts/scanning_module = 1)

/obj/item/circuitboard/machine/medical_kiosk/multitool_act(mob/living/user)
	. = ..()
	var/new_cost = input("Set a new cost for using this medical kiosk.","New cost", custom_cost) as num|null
	if(new_cost == null && (src.loc == user))
		return
	custom_cost = CLAMP(round(new_cost, 1), 10, 1000)
	to_chat(user, "<span class='notice'>The cost is now set to [custom_cost].</span>")

/obj/item/circuitboard/machine/medical_kiosk/examine(mob/user)
	. = ..()
	. += "The cost to use this kiosk is set to [custom_cost]."

// BEPIS
/obj/item/circuitboard/machine/bepis
	name = "BEPIS Chamber (Machine Board)"
	//icon_state = "science"
	build_path = /obj/machinery/rnd/bepis
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/scanning_module = 1)
