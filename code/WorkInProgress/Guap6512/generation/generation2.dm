wgDungeon
	var
		turf/loc0
		turf/loc1
		seed
		generating
		list/nodes
	New(Loc0, Loc1, Seed)
		loc0 = Loc0
		loc1 = Loc1
		seed = Seed
		return ..()
	proc/Generating()
		return generating
	proc/GetCells()
		var/list/cells = list()
		for(var/area/wgCell/v in world)
			if(!(v in cells)) cells[v] = v.weight
		return cells
	proc/NodesList()
		var/list/nodes = list()
		for(var/turf/t in block(loc0,loc1))
			for(var/obj/wgNode/n in t) nodes += n
		return nodes
	proc/Generate()
		set background = 1
		if(generating==1) return
		generating = 1
		for(var/turf/t in block(loc0,loc1))
			new seed (t)
			for(var/a in t) del(a)
		var/turf/start = locate(loc0.x+loc1.x/2,loc0.y+loc1.y/2,loc0.z)
		var/obj/wgNode/StartNode= new(start)
		StartNode.dir = pick(NORTH,SOUTH,EAST,WEST)
		nodes = NodesList()
		while(nodes.len)
			var/obj/wgNode/p = pick(nodes)
			if(p.SpawnCell(src))
				p.Success()
			else
				p.Fail()
			nodes -= p
		for(var/obj/wgNode/n in NodesList())
			if(n.recursion)
				var/turf/nextfloor = get_step(n,n.dir)
				if(nextfloor && !istype(nextfloor,seed) && istype(n.loc,seed) && nextfloor in block(loc0,loc1))
					n.Recursion()
			del n
		generating = 0
		return 1

// nodes are the spawning points which create the maze
obj/wgNode
	var/recursion
	var/spawned
	proc/SpawnCell(wgDungeon/parent)
		var/turf/target = src.loc//get_step(src, dir)
		if(!target) return
		var/turf/loc0
		var/turf/loc1
		var/list/cells = parent.GetCells()
		spawned = 1
		while(cells.len)
			var/area/wgCell/v = WeightPick(cells)
			cells -= v
			var/obj/matchnode = v.MatchNode(dir)
			if(!matchnode)
				continue
			loc0 = v.NewLoc(matchnode, target)
			if(!loc0||!(loc0 in block(parent.loc0, parent.loc1)))
				continue
			loc1 = locate(loc0.x+v.width-1,loc0.y+v.height-1, loc0.z)

			if(!loc1||!(loc1 in block(parent.loc0, parent.loc1)))
				continue
			var/build = 1
			for(var/turf/t in block(loc0,loc1))
				if(!(istype(t, parent.seed))) build = 0
			if(build == 0)
				continue
			v.Place(loc0,matchnode, parent)
			return 1
	proc/Success()
		// Override, this is called when node successfully generates a new cell.
	proc/Fail()
		// Override, this is called when node fails to create a new cell.
	proc/Recursion()
turf/var/recursion
proc/GetSteps(ref, dir, len)
	var/turf/t
	if(istype(ref, /turf)) t = ref
	else t = ref:loc
	for(var/i = 1 to len)
		t = get_step(t, dir)
	return t
proc/WeightPick(l)
	var/list/totals = list()
	var/total
	for(var/i in l)
		if(l[i])
			totals[i] = total
			total += l[i]
	var/rnd = rand(1, total)
	var/ret
	for(var/i in totals)
		if(rnd > totals[i]) ret = i
	return ret

// Vaults are areas which may be copy and pasted while the
// maze is generated
area/wgCell
	var/list/nodes
	var/turf/loc0
	var/turf/loc1
	var/width
	var/height
	var/intialized
	var/weight = 1
	var/recursion

	// This proc will return the new loc0 for the vault if when give the place
	// a node must match up at.
	proc/MatchNode(dir)
		if(!intialized) Initialize()
		for(var/obj/wgNode/node in nodes)
			if(node.dir == turn(dir,180))
				return node
	proc/NewLoc(obj/wgNode/n, atom/nodeloc)
		var/x = n.x - loc0.x
		var/y = n.y - loc0.y
		return locate(nodeloc:x-x, nodeloc:y-y, nodeloc:z)
	// This will copy and paste a vault onto the map.
	proc/Place(turf/loc,matchnode, wgDungeon/parent)
		var/difx = loc0.x - loc.x
		var/dify = loc0.y - loc.y
		var/z = loc.z
		for(var/turf/t in contents)
			var/turf/newturf = locate(t.x-difx, t.y-dify, z)
			if(newturf)
				new t.type (newturf)
				for(var/atom/n in t)
					var/atom/n2 = new n.type (newturf)
					if(n == matchnode)
						n2:Success()
						del(n2)
					else
						parent.nodes += n2
	proc/Initialize()
		intialized = 1
		nodes = list()
		for(var/turf/t in contents)
			if(!loc0) loc0 = t
			if(!loc1) loc1 = t
			if(t.x <= loc0.x&&t.y <= loc0.y) loc0 = t
			if(t.x >= loc1.x&&t.y >= loc1.y) loc1 = t
			for(var/obj/wgNode/n in t)
				nodes += n
		width = loc1.x - loc0.x +1
		height = loc1.y - loc0.y +1
		return ..()