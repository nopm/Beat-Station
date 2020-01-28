// Explorer Firing Pin- Prevents use on station Z-Level, so it's justifiable to give Explorers guns that don't suck.
/obj/item/firing_pin/explorer
	name = "outback firing pin"
	desc = "A firing pin used by the austrailian defense force, retrofit to prevent weapon discharge on the station."
	icon = 'beatstation/icons/obj/device.dmi'
	icon_state = "firing_pin_explorer"
	fail_message = "<span class='warning'>CANNOT FIRE WHILE ON STATION, MATE!</span>"

// This checks that the user isn't on the station Z-level.
/obj/item/firing_pin/explorer/pin_auth(mob/living/user)
	var/turf/station_check = get_turf(user)
	if(!station_check||is_station_level(station_check.z))
		to_chat(user, "<span class='warning'>You cannot use your weapon while on the station!</span>")
		return FALSE
	return TRUE
