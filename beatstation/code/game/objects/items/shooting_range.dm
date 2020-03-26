/obj/item/target/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()
	new /obj/effect/temp_visual/damage_number(loc, damage_amount)
