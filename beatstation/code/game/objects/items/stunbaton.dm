/obj/item/melee/baton/boomerang
	name = "\improper OZtek Boomerang"
	desc = "A device invented in 2486 for the great Space Emu War by the confederacy of Australicus, these high-tech boomerangs also work exceptionally well at stunning crewmembers. Just be careful to catch it when thrown!"
	throw_speed = 1
	icon = 'beatstation/icons/obj/items_and_weapons.dmi'
	icon_state = "boomerang"
	item_state = "boomerang"
	lefthand_file = 'beatstation/icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'beatstation/icons/mob/inhands/equipment/security_righthand.dmi'
	
	force = 5
	throwforce = 5
	throw_range = 5
	hitcost = 2000
	throw_hit_chance = 99  //Have you prayed today?
	materials = list(MAT_METAL = 10000, MAT_GLASS = 4000, MAT_SILVER = 10000, MAT_GOLD = 2000)

/obj/item/melee/baton/boomerang/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force)
	if(status)
		if(ishuman(thrower))
			var/mob/living/carbon/human/H = thrower
			H.throw_mode_off() //so they can catch it on the return.
	return ..()

/obj/item/melee/baton/boomerang/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(status)
		var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
		if(ishuman(hit_atom) && !caught && prob(throw_hit_chance))//if they are a carbon and they didn't catch it
			baton_stun(hit_atom)
		if(thrownby && !caught)
			sleep(1)
			if(!QDELETED(src))
				throw_at(thrownby, throw_range+2, throw_speed, null, TRUE)
	else
		return ..()


/obj/item/melee/baton/boomerang/update_icon()
	if(status)
		icon_state = "[initial(icon_state)]_active"
	else if(!cell)
		icon_state = "[initial(icon_state)]_nocell"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/melee/baton/boomerang/loaded //Same as above, comes with a cell.
	preload_cell_type = /obj/item/stock_parts/cell/high
