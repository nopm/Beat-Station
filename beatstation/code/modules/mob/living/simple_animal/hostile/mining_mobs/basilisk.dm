//Watcher
/mob/living/simple_animal/hostile/asteroid/basilisk/watcher
	search_objects = 1
	wanted_objects = list(/obj/item/pen/survival, /obj/item/stack/ore/diamond)

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/Life()
	. = ..()
	if(stat == CONSCIOUS)
		consume_bait()

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/proc/consume_bait()
	var/obj/item/stack/ore/diamond/diamonds = locate(/obj/item/stack/ore/diamond) in oview(src, 9)
	var/obj/item/pen/survival/bait = locate(/obj/item/pen/survival) in oview(src, 9)
	if(!diamonds && !bait)
		return
	if(diamonds)
		var/distanced = 0
		distanced = get_dist(loc,diamonds.loc)
		if(distanced <= 1 && diamonds)
			qdel(diamonds)
			src.visible_message("<span class='notice'>[src] consumes [diamonds], and it disappears! ...At least, you think.</span>")
	if(bait)
		var/distanceb = 0
		distanceb = get_dist(loc,bait.loc)
		if(distanceb <= 1 && bait)
			qdel(bait)
			src.visible_message("<span class='notice'>[src] examines [bait] closer, and telekinetically shatters the pen.</span>")
