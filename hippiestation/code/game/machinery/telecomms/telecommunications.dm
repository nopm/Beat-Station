/*/obj/machinery/telecomms // beat start
	icon_hippie = 'hippiestation/icons/obj/machines/telecomms.dmi'*/ // beat end

/obj/machinery/telecomms/ui_interact(mob/user)
	if(is_ganymede(user))
		to_chat(user, "<span class='warning'>Your enormous hands can't possibly fiddle with that!</span>")
		return
	return ..()
