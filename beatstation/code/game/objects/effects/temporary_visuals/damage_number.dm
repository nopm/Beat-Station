/obj/effect/temp_visual/damage_number
	name = "damage number"
	desc = "Displays a damage value"
	icon = null
	duration = 10
	randomdir = FALSE

	pixel_x =  -32*0.5
	pixel_y = -32*0.5

	maptext_x = 0
	maptext_y = 0
	maptext_height = 32*2
	maptext_width = 32*2

/obj/effect/temp_visual/damage_number/New(loc, damage_value)
	. = ..()

	var/desired_color = "#9c0808"
	var/desired_size = 1
	if(isnum(damage_value))
		damage_value = FLOOR(damage_value, 1)
		var/damage_color_math = clamp(255 - (damage_value/100)*255,0,255)
		desired_size = clamp(damage_value*0.05,1,5)
		desired_color = rgb(255,damage_color_math,damage_color_math)

	maptext = "<center><font size='[desired_size]' color='[desired_color]'>[damage_value]</text></center>"
	animate(src, pixel_x = initial(pixel_x) + rand(-32, 32), pixel_y = initial(pixel_y) + rand(0, 32), time = duration * 0.5, easing = CIRCULAR_EASING | EASE_OUT)
	spawn(duration - 5)
		animate(src, alpha=0, time = 5)
