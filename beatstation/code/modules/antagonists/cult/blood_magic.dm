/datum/action/innate/cult/blood_spell/manipulation
	name = "Blood Rites"
	desc = "Empowers your hand to absorb blood to be used for advanced rites, or heal a cultist on contact. Use the spell in-hand to cast advanced rites."
	invocation = "Fel'th Dol Ab'orod!"
	button_icon_state = "manip"
	charges = 5
	magic_path = "/obj/item/melee/blood_magic/manipulator/beat"

/obj/item/melee/blood_magic/manipulator/beat
	name = "Blood Rite Aura"
	desc = "Absorbs blood from anything you touch. Touching cultists and constructs can heal them. Use in-hand to cast an advanced rite."
	color = "#7D1717"

/obj/item/melee/blood_magic/manipulator/beat/examine(mob/user)
	. = ..()
	. += "Blood spear, blood bolt barrage, and blood beam cost [BLOOD_SPEAR_COST], [BLOOD_BARRAGE_COST], and [BLOOD_BEAM_COST] charges respectively."

/obj/item/melee/blood_magic/manipulator/beat/afterattack(atom/target, mob/living/carbon/human/user, proximity)
	if(proximity)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(NOBLOOD in H.dna.species.species_traits)
				to_chat(user,"<span class='warning'>Blood rites do not work on species with no blood!</span>")
				return
			if(iscultist(H))
				if(H.stat == DEAD)
					to_chat(user,"<span class='warning'>Only a revive rune can bring back the dead!</span>")
					return
				if(H.blood_volume < BLOOD_VOLUME_SAFE)
					var/restore_blood = BLOOD_VOLUME_SAFE - H.blood_volume
					if(uses*2 < restore_blood)
						H.blood_volume += uses*2
						to_chat(user,"<span class='danger'>You use the last of your blood rites to restore what blood you could!</span>")
						uses = 0
						return ..()
					else
						H.blood_volume = BLOOD_VOLUME_SAFE
						uses -= round(restore_blood/2)
						to_chat(user,"<span class='warning'>Your blood rites have restored [H == user ? "your" : "[H.p_their()]"] blood to safe levels!</span>")
				var/overall_damage = H.getBruteLoss() + H.getFireLoss() + H.getToxLoss() + H.getOxyLoss()
				if(overall_damage == 0)
					to_chat(user,"<span class='cult'>That cultist doesn't require healing!</span>")
				else
					var/ratio = uses/overall_damage
					if(H == user)
						to_chat(user,"<span class='cult'><b>Your blood healing is far less efficient when used on yourself!</b></span>")
						ratio *= 0.35 // Healing is half as effective if you can't perform a full heal
						uses -= round(overall_damage) // Healing is 65% more "expensive" even if you can still perform the full heal
					if(ratio>1)
						ratio = 1
						uses -= round(overall_damage)
						H.visible_message("<span class='warning'>[H] is fully healed by [H==user ? "[H.p_their()]":"[H]'s"]'s blood magic!</span>")
					else
						H.visible_message("<span class='warning'>[H] is partially healed by [H==user ? "[H.p_their()]":"[H]'s"] blood magic.</span>")
						uses = 0
					ratio *= -1
					H.adjustOxyLoss((overall_damage*ratio) * (H.getOxyLoss() / overall_damage), 0)
					H.adjustToxLoss((overall_damage*ratio) * (H.getToxLoss() / overall_damage), 0)
					H.adjustFireLoss((overall_damage*ratio) * (H.getFireLoss() / overall_damage), 0)
					H.adjustBruteLoss((overall_damage*ratio) * (H.getBruteLoss() / overall_damage), 0)
					H.updatehealth()
					playsound(get_turf(H), 'sound/magic/staff_healing.ogg', 25)
					new /obj/effect/temp_visual/cult/sparks(get_turf(H))
					user.Beam(H,icon_state="sendbeam",time=15)
			else
				if(H.stat == DEAD)
					to_chat(user,"<span class='warning'>[H.p_their(TRUE)] blood has stopped flowing, you'll have to find another way to extract it.</span>")
					return
				if(H.cultslurring)
					to_chat(user,"<span class='danger'>[H.p_their(TRUE)] blood has been tainted by an even stronger form of blood magic, it's no use to us like this!</span>")
					return
				if(H.blood_volume > BLOOD_VOLUME_SAFE)
					H.blood_volume -= 100
					uses += 50
					user.Beam(H,icon_state="drainbeam",time=10)
					playsound(get_turf(H), 'sound/magic/enter_blood.ogg', 50)
					H.visible_message("<span class='danger'>[user] has drained some of [H]'s blood!</span>")
					to_chat(user,"<span class='cultitalic'>Your blood rite gains 50 charges from draining [H]'s blood.</span>")
					new /obj/effect/temp_visual/cult/sparks(get_turf(H))
				else
					to_chat(user,"<span class='danger'>[H.p_theyre(TRUE)] missing too much blood - you cannot drain [H.p_them()] further!</span>")
					return
		if(isconstruct(target))
			var/mob/living/simple_animal/M = target
			var/missing = M.maxHealth - M.health
			if(missing)
				if(uses > missing)
					M.adjustHealth(-missing)
					M.visible_message("<span class='warning'>[M] is fully healed by [user]'s blood magic!</span>")
					uses -= missing
				else
					M.adjustHealth(-uses)
					M.visible_message("<span class='warning'>[M] is partially healed by [user]'s blood magic!</span>")
					uses = 0
				playsound(get_turf(M), 'sound/magic/staff_healing.ogg', 25)
				user.Beam(M,icon_state="sendbeam",time=10)
		if(istype(target, /obj/effect/decal/cleanable/trail_holder || /obj/effect/decal/cleanable/blood))
			draw_blood(target, user)
		..()

/obj/item/melee/blood_magic/manipulator/beat/proc/draw_blood(atom/target, mob/living/carbon/human/user)
	var/temp = 0
	var/turf/T = get_turf(target)
	if(T)
		for(var/obj/effect/decal/cleanable/blood/B in view(T, 2))
			if(B.blood_state == BLOOD_STATE_HUMAN)
				if(B.bloodiness == 100) //Bonus for "pristine" bloodpools, also to prevent cheese with footprint spam
					temp += 30
				else
					temp += max((B.bloodiness**2)/800,1)
				new /obj/effect/temp_visual/cult/turf/floor(get_turf(B))
				qdel(B)
		for(var/obj/effect/decal/cleanable/trail_holder/TH in view(T, 2))
			if(TH.bloodiness == 100)
				temp += 30
			else
				temp += max((TH.bloodiness**2)/800,1)
			new /obj/effect/temp_visual/cult/turf/floor(get_turf(TH))
			qdel(TH)
		var/obj/item/clothing/shoes/shoecheck = user.shoes
		if(shoecheck && shoecheck.bloody_shoes[/datum/reagent/blood])
			temp += shoecheck.bloody_shoes[/datum/reagent/blood]/20
			shoecheck.bloody_shoes[/datum/reagent/blood] = 0
		if(temp)
			user.Beam(T,icon_state="drainbeam",time=15)
			new /obj/effect/temp_visual/cult/sparks(get_turf(user))
			playsound(T, 'sound/magic/enter_blood.ogg', 50)
			to_chat(user, "<span class='cultitalic'>Your blood rite has gained [round(temp)] charge\s from blood sources around you!</span>")
			uses += max(1, round(temp))

/obj/item/melee/blood_magic/manipulator/beat/attack_self(mob/living/user)
	if(iscultist(user))
		var/list/options = list("Blood Spear (150)", "Blood Bolt Barrage (300)", "Blood Beam (500)")
		var/choice = input(user, "Choose a greater blood rite...", "Greater Blood Rites") as null|anything in options
		if(!choice)
			to_chat(user, "<span class='cultitalic'>You decide against conducting a greater blood rite.</span>")
			return
		switch(choice)
			if("Blood Spear (150)")
				if(uses < BLOOD_SPEAR_COST)
					to_chat(user, "<span class='cultitalic'>You need [BLOOD_SPEAR_COST] charges to perform this rite.</span>")
				else
					uses -= BLOOD_SPEAR_COST
					var/turf/T = get_turf(user)
					qdel(src)
					var/datum/action/innate/cult/spear/S = new(user)
					var/obj/item/twohanded/cult_spear/rite = new(T)
					S.Grant(user, rite)
					rite.spear_act = S
					if(user.put_in_hands(rite))
						to_chat(user, "<span class='cultitalic'>A [rite.name] appears in your hand!</span>")
					else
						user.visible_message("<span class='warning'>A [rite.name] appears at [user]'s feet!</span>", \
							 "<span class='cultitalic'>A [rite.name] materializes at your feet.</span>")
			if("Blood Bolt Barrage (300)")
				if(uses < BLOOD_BARRAGE_COST)
					to_chat(user, "<span class='cultitalic'>You need [BLOOD_BARRAGE_COST] charges to perform this rite.</span>")
				else
					var/obj/rite = new /obj/item/gun/ballistic/rifle/boltaction/enchanted/arcane_barrage/blood()
					uses -= BLOOD_BARRAGE_COST
					qdel(src)
					if(user.put_in_hands(rite))
						to_chat(user, "<span class='cult'><b>Your hands glow with power!</b></span>")
					else
						to_chat(user, "<span class='cultitalic'>You need a free hand for this rite!</span>")
						qdel(rite)
			if("Blood Beam (500)")
				if(uses < BLOOD_BEAM_COST)
					to_chat(user, "<span class='cultitalic'>You need [BLOOD_BEAM_COST] charges to perform this rite.</span>")
				else
					var/obj/rite = new /obj/item/blood_beam()
					uses -= BLOOD_BEAM_COST
					qdel(src)
					if(user.put_in_hands(rite))
						to_chat(user, "<span class='cultlarge'><b>Your hands glow with POWER OVERWHELMING!!!</b></span>")
					else
						to_chat(user, "<span class='cultitalic'>You need a free hand for this rite!</span>")
						qdel(rite)