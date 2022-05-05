/obj/structure/stoppedrail
	desc = "A stopped rail, with screws to secure it to the floor."
	name = "Stopped rail"
	icon = 'icons/obj/structures.dmi'
	icon_state = "stoppedrail"
	density = 1
	anchored = 1
	flags = FPRINT | CONDUCT
	pressure_resistance = 5*ONE_ATMOSPHERE
	layer = 2.9
	explosion_resistance = 5
	var/health = 500
	var/destroyed = 0