//Just some alt-uniforms themed around Star Trek - Pls don't sue, Mr Roddenberry ;_;


/obj/item/clothing/under/trek
	can_adjust = FALSE


//TOS
/obj/item/clothing/under/trek/command
	name = "command uniform"
	desc = "The uniform worn by command officers."
	icon_state = "trek_command"
	item_color = "trek_command"
	item_state = "y_suit"

/obj/item/clothing/under/trek/engsec
	name = "redshirt uniform"
	desc = "People who wear this uniform tend to die not too long after."
	icon_state = "trek_engsec"
	item_color = "trek_engsec"
	item_state = "r_suit"
	armor = list("melee" = -500, "bullet" = -500, "laser" = -500, "energy" = -500, "bomb" = -500, "bio" = -500, "rad" = -500, "fire" = -500, "acid" = -500)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD

/obj/item/clothing/under/trek/medsci
	name = "medsci uniform"
	desc = "The uniform worn by medical/science officers."
	icon_state = "trek_medsci"
	item_color = "trek_medsci"
	item_state = "b_suit"


//TNG
/obj/item/clothing/under/trek/command/next
	icon_state = "trek_next_command"
	item_color = "trek_next_command"
	item_state = "r_suit"

/obj/item/clothing/under/trek/engsec/next
	icon_state = "trek_next_engsec"
	item_color = "trek_next_engsec"
	item_state = "y_suit"

/obj/item/clothing/under/trek/medsci/next
	icon_state = "trek_next_medsci"
	item_color = "trek_next_medsci"


//ENT
/obj/item/clothing/under/trek/command/ent
	icon_state = "trek_ent_command"
	item_color = "trek_ent_command"
	item_state = "bl_suit"

/obj/item/clothing/under/trek/engsec/ent
	icon_state = "trek_ent_engsec"
	item_color = "trek_ent_engsec"
	item_state = "bl_suit"

/obj/item/clothing/under/trek/medsci/ent
	icon_state = "trek_ent_medsci"
	item_color = "trek_ent_medsci"
	item_state = "bl_suit"


//Q
/obj/item/clothing/under/trek/Q
	name = "french marshall's uniform"
	desc = "Something about it feels off..."
	icon_state = "trek_Q"
	item_color = "trek_Q"
	item_state = "r_suit"