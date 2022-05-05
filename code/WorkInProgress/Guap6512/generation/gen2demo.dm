//world/view = 10
// Just a couple definitions for our simple dungeon.
/*
turf
	icon = 'dungeon.dmi'
	wall
		density = 1
		text = "<font color=#A0A0A0>#"
		icon_state = "wall"
		opacity = 1
	floor
		text = "<font color=#C0C0C0>."
		icon_state = "floor"
	room
		text = "<font color=#C0C0C0>."
		icon_state = "floor"

obj
	door
		icon = 'dungeon.dmi'
		text = "<font color=#A0C000>+"
		icon_state = "closed"
		opacity =1
		density = 1

mob/Bump(o)
	if(istype(o,/obj/machinery/door/airlock))
		// When you bump into a door, it opens
		o:text = "<font color=#A0C000>/"
		o:opacity = 0
		o:density = 0
		o:icon_state = "opened"

mob
	text = "@"
	icon = 'dungeon.dmi'
	icon_state = "player"
*/

var/wgDungeon/level1 = new(locate(1,1,1),locate(world.maxx,world.maxy,1))
mob/verb/Generate()
	level1.seed = /turf/simulated/wall
	loc = null // we have to move the player before we generate the level so the generator doesn't delete em'
	if(level1.Generate())
		var /obj/effect/landmark/S = new(null)
		S.name = "JoinLate"
		S.loc = locate(/turf/simulated/floor/plating)
		loc = locate(/turf/simulated/floor/plating)
	else
		usr << "There is already a map generating."
	return ..()
/*
mob/Login()
	loc = locate(1,1,1)
*/
// These cells will be used in our demo map generator.
area/wgCell
	corridor
		horizontal/weight = 10
		vertical/weight = 10
		corner1/weight = 1
		corner2/weight = 1
		corner3/weight = 1
		corner4/weight = 1
		juntion1/weight = 1
		juntion2/weight = 1
		juntion3/weight = 1
		juntion4/weight = 1
		intersection/weight = 1
	room
		weight = 2
		room1
		room2
		room3
		room4
		skull

// Node types to be used in the cells.
obj/wgNode
	icon = 'dungeon.dmi'
	icon_state = "node"
	corridor
		recursion = TRUE
		Success()
			new /turf/simulated/floor/plating (loc)
		Fail()
			new /turf/simulated/wall (loc)
		Recursion()
			new /turf/simulated/floor/plating (loc)
			var/turf/t = get_step(src, dir)
			if(istype(t, /turf/simulated/floor/))
				// We just broke down a wall for room, so lets place a door here.
				new /obj/machinery/door/airlock (loc)
		north
			text = "<font color=yellow>A"
			dir = NORTH
		south
			text = "<font color=yellow>V"
			dir = SOUTH
		east
			text = "<font color=yellow>>"
			dir = EAST
		west
			text = "<font color=yellow><"
			dir = WEST
	// Room nodes are a bit different, since we want
	// to create doors instead of floors.
	room
		Success()
			new /turf/simulated/floor/plating (loc)
			new /obj/machinery/door/airlock (loc)
		Fail()
			new /turf/simulated/wall (loc)
		north
			text = "<font color=yellow>A"
			dir = NORTH
		south
			text = "<font color=yellow>V"
			dir = SOUTH
		east
			text = "<font color=yellow>>"
			dir = EAST
		west
			text = "<font color=yellow><"
			dir = WEST