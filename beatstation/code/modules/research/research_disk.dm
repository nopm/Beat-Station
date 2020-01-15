// BEPIS
/obj/item/disk/tech_disk/major
	name = "Reformatted technology disk"
	desc = "A disk containing a new, completed tech from the B.E.P.I.S. Upload the disk to an R&D Console to redeem the tech."
	icon = 'beatstation/icons/obj/module.dmi'
	icon_state = "rndmajordisk"
	materials = list(MAT_METAL = 300, MAT_GLASS = 100)

/obj/item/disk/tech_disk/major/Initialize()
	. = ..()
	stored_research = new /datum/techweb/bepis
