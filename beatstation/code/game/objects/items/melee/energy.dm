//"The TRUE Energy Sword" ported from Citadel
/obj/item/melee/transforming/energy/sword/cx
	name = "non-eutactic blade"
	desc = "The Non-Eutactic Blade utilizes a hardlight blade that is dynamically 'forged' on demand to create a deadly sharp edge that is unbreakable."
	icon = 'beatstation/icons/obj/items_and_weapons.dmi'
	lefthand_file = 'beatstation/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'beatstation/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "cxsword_hilt"
	item_state = "cxsword"
	force = 3
	force_on = 21
	throwforce = 5
	throwforce_on = 20
	hitsound = "swing_hit" //it starts deactivated
	hitsound = 'beatstation/sound/weapons/nebhit.ogg'
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = IS_SHARP
	embedding = list("embedded_pain_multiplier" = 6, "embed_chance" = 20, "embedded_fall_chance" = 60)
	armour_penetration = 10
	block_chance = 35
	light_color = "#37FFF7"
	actions_types = list()

/obj/item/melee/transforming/energy/sword/cx/transform_weapon(mob/living/user, supress_message_text)
	active = !active				//I'd use a ..() here but it'd inherit from the regular esword's proc instead, so SPAGHETTI CODE
	if(active)						//also I'd need to rip out the iconstate changing bits
		force = force_on
		throwforce = throwforce_on
		hitsound = hitsound_on
		throw_speed = 4
		if(attack_verb_on.len)
			attack_verb = attack_verb_on
		w_class = w_class_on
		START_PROCESSING(SSobj, src)
		set_light(brightness_on)
		update_icon()
	else
		force = initial(force)
		throwforce = initial(throwforce)
		hitsound = initial(hitsound)
		throw_speed = initial(throw_speed)
		if(attack_verb_off.len)
			attack_verb = attack_verb_off
		w_class = initial(w_class)
		STOP_PROCESSING(SSobj, src)
		set_light(0)
		update_icon()
	transform_messages(user, supress_message_text)
	add_fingerprint(user)
	return TRUE

/obj/item/melee/transforming/energy/sword/cx/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'beatstation/sound/weapons/nebon.ogg' : 'beatstation/sound/weapons/neboff.ogg', 65, 1)
	if(!supress_message_text)
		to_chat(user, "<span class='notice'>[src] [active ? "is now active":"can now be concealed"].</span>")

/obj/item/melee/transforming/energy/sword/cx/update_icon()
	var/mutable_appearance/blade_overlay = mutable_appearance(icon, "cxsword_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance(icon, "cxsword_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other

	add_overlay(gem_overlay)

	if(active)
		add_overlay(blade_overlay)
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/melee/transforming/energy/sword/cx/AltClick(mob/living/user)
	. = ..()
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		return TRUE

	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"","Choose Energy Color",light_color) as color|null
		if(energy_color_input)
			light_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
		update_icon()
		update_light()
	return TRUE

/obj/item/melee/transforming/energy/sword/cx/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to recolor it.</span>"

/obj/item/melee/transforming/energy/sword/cx/worn_overlays(isinhands, icon_file, style_flags = NONE)
	. = ..()
	if(active)
		if(isinhands)
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "cxsword_blade")
			blade_inhand.color = light_color
			. += blade_inhand

//Broken version. Not a toy, but not as strong.
/obj/item/melee/transforming/energy/sword/cx/broken
	name = "misaligned non-eutactic blade"
	desc = "The Non-Eutactic Blade utilizes a hardlight blade that is dynamically 'forged' on demand to create a deadly sharp edge that is unbreakable. This one seems to have a damaged handle and misaligned components, causing the blade to be unstable at best"
	force_on = 15 //As strong a survival knife/bone dagger

/obj/item/melee/transforming/energy/sword/cx/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/melee/transforming/energy/sword/cx))
		if(HAS_TRAIT(W, TRAIT_NODROP) || HAS_TRAIT(src, TRAIT_NODROP))
			to_chat(user, "<span class='warning'>\the [HAS_TRAIT(src, TRAIT_NODROP) ? src : W] is stuck to your hand, you can't attach it to \the [HAS_TRAIT(src, TRAIT_NODROP) ? W : src]!</span>")
			return
		else
			to_chat(user, "<span class='notice'>You combine the two light swords, making a single supermassive blade! You're cool.</span>")
			new /obj/item/twohanded/dualsaber/hypereutactic(user.drop_location())
			qdel(W)
			qdel(src)
	else
		return ..()

////////		Tatortot NEB		/////////////// (same stats as regular esword)
/obj/item/melee/transforming/energy/sword/cx/traitor
	name = "\improper Dragon's Tooth Sword"
	desc = "The Dragon's Tooth sword is a blackmarket modification of a Non-Eutactic Blade, \
			which utilizes a hardlight blade that is dynamically 'forged' on demand to create a deadly sharp edge that is unbreakable. \
			It appears to have a wooden grip and a shaved down guard."
	icon_state = "cxsword_hilt_traitor"
	force_on = 25
	armour_penetration = 35
	embedding = list("embedded_pain_multiplier" = 10, "embed_chance" = 75, "embedded_fall_chance" = 0, "embedded_impact_pain_multiplier" = 10)
	block_chance = 40
	hitsound_on = 'sound/weapons/blade1.ogg'
	light_color = "#37F0FF"

/obj/item/melee/transforming/energy/sword/cx/traitor/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 35, 1)
	if(!supress_message_text)
		to_chat(user, "<span class='notice'>[src] [active ? "is now active":"can now be concealed"].</span>")
