/datum/outfit/job/virologist/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	var/datum/martial_art/krav_medical/under_siege/justamed = new
	justamed.teach(H)