/obj/item/gun/energy/kinetic_accelerator/beat_ebow //no more nerfed ebows
    name = "mini energy crossbow"
    desc = "A poisonous crossbow favored by syndicate stealth specialists."
    icon_state = "crossbow"
    item_state = "crossbow"
    w_class = WEIGHT_CLASS_SMALL
    materials = list(MAT_METAL=2000)
    suppressed = TRUE
    ammo_type = list(/obj/item/ammo_casing/energy/beat_ebolt)
    weapon_weight = WEAPON_LIGHT
    obj_flags = 0
    overheat_time = 20
    holds_charge = TRUE
    unique_frequency = TRUE
    can_flashlight = FALSE
    max_mod_capacity = 0

/obj/item/ammo_casing/energy/beat_ebolt
    projectile_type = /obj/item/projectile/energy/beat_ebolt
    select_name = "bolt"
    e_cost = 500
    fire_sound = 'sound/weapons/genhit.ogg'

/obj/item/projectile/energy/beat_ebolt
    name = "bolt"
    icon_state = "cbbolt"
    nodamage = 1
    var/piercing = TRUE

/obj/item/projectile/energy/beat_ebolt/on_hit(atom/target, blocked = FALSE)
    if(iscarbon(target))
        var/mob/living/carbon/M = target
        if(blocked != 100)
            ..()
            M.Paralyze(60)
            return BULLET_ACT_HIT
        else
            target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
                                    "<span class='userdanger'>You were protected against \the [src]!</span>")
    ..(target, blocked)
    return BULLET_ACT_HIT
