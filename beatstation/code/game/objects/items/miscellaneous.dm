//Botanical Voucher!
/obj/item/botanical_voucher
	name = "botanical voucher"
	desc = "A token to call in a botanical chem dispenser via bluespace means."
	icon = 'icons/obj/mining.dmi'
	icon_state = "mining_voucher"
	w_class = WEIGHT_CLASS_TINY


/obj/item/botanical_voucher/attack_self(mob/user)
	if(do_after(user, 25, target = src))
		playsound(get_turf(user),'sound/machines/click.ogg',50,1)
		to_chat(user, "<span class='warning'>A chemical dispenser suddenly appears on your feet!</span>")
		new /obj/machinery/chem_dispenser/mutagensaltpeter(get_turf(user))
		qdel(src)
	else
		return
