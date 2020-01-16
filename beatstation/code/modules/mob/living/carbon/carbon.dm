/mob/living/carbon/proc/fuck() // BEPIS
	switch(rand(100))
		if(0 to 30)
			wabbajack(src)
		if(31 to 60)
			var/list/magic = subtypesof(/obj/item/projectile/magic)
			var/type = pick(magic)
			var/obj/item/projectile/magic/P = new type ()
			P.on_hit(src)
		if(61 to 100)
			if(!reagents)
				return
			reagents.add_reagent(get_random_reagent_id(), rand(10, 100))
