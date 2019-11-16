/obj/structure/table_frame/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, "<span class='notice'>You start disassembling [src]...</span>")
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 30))
			playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
			deconstruct(TRUE)
	else if(istype(I, /obj/item/stack/sheet/plasteel))
		var/obj/item/stack/sheet/plasteel/P = I
		if(P.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one plasteel sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [P] to [src]...</span>")
		if(do_after(user, 50, target = src) && P.use(1))
			make_new_table(/obj/structure/table/reinforced)
	else if(istype(I, /obj/item/stack/sheet/metal))
		var/obj/item/stack/sheet/metal/M = I
		if(M.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one metal sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [M] to [src]...</span>")
		if(do_after(user, 20, target = src) && M.use(1))
			make_new_table(/obj/structure/table)
	else if(istype(I, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/G = I
		if(G.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one glass sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [G] to [src]...</span>")
		if(do_after(user, 20, target = src) && G.use(1))
			make_new_table(/obj/structure/table/glass)
	else if(istype(I, /obj/item/stack/sheet/mineral/silver))
		var/obj/item/stack/sheet/mineral/silver/S = I
		if(S.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one silver sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [S] to [src]...</span>")
		if(do_after(user, 20, target = src) && S.use(1))
			make_new_table(/obj/structure/table/optable)
	else if(istype(I, /obj/item/stack/tile/carpet/black))
		var/obj/item/stack/tile/carpet/black/C = I
		if(C.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one  black carpet sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [C] to [src]...</span>")
		if(do_after(user, 20, target = src) && C.use(1))
			make_new_table(/obj/structure/table/wood/fancy/black)
	else if(istype(I, /obj/item/stack/tile/carpet))
		var/obj/item/stack/tile/carpet/C = I
		if(C.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one carpet sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [C] to [src]...</span>")
		if(do_after(user, 20, target = src) && C.use(1))
			make_new_table(/obj/structure/table/wood/fancy)
	else if(istype(I, /obj/item/stack/tile/bronze))
		var/obj/item/stack/tile/bronze/B = I
		if(B.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one bronze sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [B] to [src]...</span>")
		if(do_after(user, 20, target = src) && B.use(1))
			make_new_table(/obj/structure/table/bronze)
	
	//new carpets and tables
	var/obj/item/stack/material = I
	if(istype(I, /obj/item/stack) && material?.tableVariant)
		if(material.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one [material.name] sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [material] to [src]...</span>")
		if(do_after(user, 20, target = src) && material.use(1))
			make_new_table(material.tableVariant)

	else
		return ..()
