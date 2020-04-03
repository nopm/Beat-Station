<<<<<<< HEAD
/*/obj/machinery/smartfridge/drying_rack // beat
	icon_hippie = 'hippiestation/icons/obj/hydroponics/equipment.dmi'*/ // beat end
=======
/obj/machinery/smartfridge/drying_rack
	icon_hippie = 'hippiestation/icons/obj/hydroponics/equipment.dmi'

/obj/machinery/smartfridge/drying_rack/update_icon()
	..()
	cut_overlays()
	if(drying)
		icon_state = "drying_rack_on"
	else
		icon_state = initial(icon_state)
>>>>>>> e75a4166c4... Nice (#12695)
