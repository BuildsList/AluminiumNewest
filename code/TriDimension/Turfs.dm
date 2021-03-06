/turf/simulated/floor/open
	name = "open space"
	intact = 0
	density = 0
	icon_state = "open"
	pathweight = 100000 //Seriously, don't try and path over this one numbnuts
	var/icon/darkoverlays = null
	var/turf/floorbelow
	var/list/overlay_references

	New()
		..()
		getbelow()
		return

	Enter(var/atom/movable/AM)
		if (..()) //TODO make this check if gravity is active (future use) - Sukasa
			spawn(1)
				// only fall down in defined areas (read: areas with artificial gravitiy)
				if(!floorbelow) //make sure that there is actually something below
					if(!getbelow())
						return
				if(istype(AM, /mob/living/carbon/human))
					var/mob/living/carbon/human/H = AM
					if(H.jumping)
						return ..()
				if(AM)
//					var/area/areacheck = get_area(src)
					var/blocked = 0
					for(var/atom/A in floorbelow.contents)
						if(A.density)
							blocked = 1
							break
						if(istype(A, /obj/machinery/atmospherics/pipe/zpipe/up) && istype(AM,/obj/item/pipe))
							blocked = 1
							break
						if(istype(A, /obj/structure/disposalpipe/crossZ/up) && istype(AM,/obj/item/pipe))
							blocked = 1
							break
							//dont break here, since we still need to be sure that it isnt blocked

					if	(!blocked)//&& !(areacheck.name == "Space"))
						AM.Move(floorbelow)
						if(istype(AM, /mob/living/carbon/human))
							if(AM.Move(floorbelow))
//							if(AM:back && istype(AM:back, /obj/item/weapon/tank/jetpack))
//								return
//							else
								var/mob/living/carbon/human/H = AM
								var/damage = 20
								H.apply_damage((rand(5,damage)), BRUTE, "l_leg")
								H.apply_damage((rand(5,damage)), BRUTE, "r_leg")
								H.apply_damage((rand(5,damage)), BRUTE, "l_foot")
								H.apply_damage((rand(5,damage)), BRUTE, "r_foot")
								H:weakened = max(H:weakened,2)
								H:updatehealth()
		return ..()

/turf/simulated/floor/open/proc/getbelow()
	var/turf/controllerlocation = locate(1, 1, z)
	for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
		// check if there is something to draw below
		if(!controller.down)
			src.ChangeTurf(/turf/space)
			return 0
		else
			floorbelow = locate(src.x, src.y, controller.down_target)
			return 1
	return 1

// override to make sure nothing is hidden
/turf/simulated/floor/open/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(0)

//overwrite the attackby of space to transform it to openspace if necessary
/turf/space/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/weapon/cable_coil))
		var/turf/simulated/floor/open/W = src.ChangeTurf(/turf/simulated/floor/open)
		W.attackby(C, user)
		return
	..()

/turf/simulated/floor/open/ex_act(severity)
	// cant destroy empty space with an ordinary bomb
	return

/turf/simulated/floor/open/attackby(obj/item/C as obj, mob/user as mob)
	(..)
	if (istype(C, /obj/item/weapon/cable_coil))
		var/obj/item/weapon/cable_coil/cable = C
		cable.turf_place(src, user)
		return

	if (istype(C, /obj/item/stack/rods))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			return
		var/obj/item/stack/rods/R = C
		user << "\blue Constructing support lattice ..."
		playsound(src.loc, 'sound/weapons/Genhit.ogg', 50, 1)
		ReplaceWithLattice()
		R.use(1)
		return

	if (istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			del(L)
			playsound(src.loc, 'sound/weapons/Genhit.ogg', 50, 1)
			S.build(src)
			S.use(1)
			return
		else
			user << "\red The plating is going to need some support."
	return
