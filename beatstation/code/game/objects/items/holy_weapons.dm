/obj/item/nullrod/gohei
	name = "gohei"
	desc = "A wooden stick with white streamers at the end. Originally used by shrine maidens to purify things. Now used by people with a thing for armpits."
	w_class = WEIGHT_CLASS_NORMAL
	force = 5
	block_chance = 60
	sharpness = IS_BLUNT
	hitsound = "swing_hit"
	attack_verb = list("whacked", "thwacked", "walloped", "socked")
	icon = 'beatstation/icons/obj/items_and_weapons.dmi'
	icon_state = "gohei"
	item_state = "gohei"
	lefthand_file = 'beatstation/icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'beatstation/icons/mob/inhands/weapons/staves_righthand.dmi'

/obj/item/nullrod/gohei/afterattack(atom/A, mob/user, proximity) //gives the gohei purification properties; code copied from the bible
	. = ..()
	if(!proximity)
		return
	if(isfloorturf(A))
		to_chat(user, "<span class='notice'>You waggle your gohei over the floor.</span>")
		if(user.mind && (user.mind.isholy))
			for(var/obj/effect/rune/R in orange(2,user))
				R.invisibility = 0
	if(user.mind && (user.mind.isholy))
		if(A.reagents && A.reagents.has_reagent(/datum/reagent/water)) // blesses all the water in the holder
			to_chat(user, "<span class='notice'>You bless [A].</span>")
			var/water2holy = A.reagents.get_reagent_amount(/datum/reagent/water)
			A.reagents.del_reagent(/datum/reagent/water)
			A.reagents.add_reagent(/datum/reagent/water/holywater,water2holy)
		if(A.reagents && A.reagents.has_reagent(/datum/reagent/fuel/unholywater)) // yeah yeah, copy pasted copy pasted code - sue me twice
			to_chat(user, "<span class='notice'>You purify [A].</span>")
			var/unholy2clean = A.reagents.get_reagent_amount(/datum/reagent/fuel/unholywater)
			A.reagents.del_reagent(/datum/reagent/fuel/unholywater)
			A.reagents.add_reagent(/datum/reagent/water/holywater,unholy2clean)
	if(istype(A, /obj/item/twohanded/required/cult_bastard) && !iscultist(user))
		var/obj/item/twohanded/required/cult_bastard/sword = A
		to_chat(user, "<span class='notice'>You begin to purify [sword].</span>")
		playsound(src,'sound/hallucinations/veryfar_noise.ogg',40,TRUE)
		if(do_after(user, 40, target = sword))
			playsound(src,'sound/effects/pray_chaplain.ogg',60,TRUE)
			for(var/obj/item/soulstone/SS in sword.contents)
				SS.usability = TRUE
				for(var/mob/living/simple_animal/shade/EX in SS)
					SSticker.mode.remove_cultist(EX.mind, 1, 0)
					EX.icon_state = "ghost1"
					EX.name = "Purified [EX.name]"
				SS.release_shades(user)
				qdel(SS)
			new /obj/item/nullrod/claymore(get_turf(sword))
			user.visible_message("<span class='notice'>[user] has purified [sword]!</span>")
			qdel(sword)

	else if(istype(A, /obj/item/soulstone) && !iscultist(user))
		var/obj/item/soulstone/SS = A
		if(SS.purified)
			return
		to_chat(user, "<span class='notice'>You begin to purify [SS].</span>")
		playsound(src,'sound/hallucinations/veryfar_noise.ogg',40,TRUE)
		if(do_after(user, 40, target = SS))
			playsound(src,'sound/effects/pray_chaplain.ogg',60,TRUE)
			SS.usability = TRUE
			SS.purified = TRUE
			SS.icon_state = "purified_soulstone"
			for(var/mob/M in SS.contents)
				if(M.mind)
					SS.icon_state = "purified_soulstone2"
					if(iscultist(M))
						SSticker.mode.remove_cultist(M.mind, FALSE, FALSE)
			for(var/mob/living/simple_animal/shade/EX in SS)
				EX.icon_state = "ghost1"
				EX.name = "Purified [initial(EX.name)]"
			user.visible_message("<span class='notice'>[user] has purified [SS]!</span>")