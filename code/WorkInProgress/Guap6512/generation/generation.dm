/datum/generator			//A rogue-like generator for dungeons

	var/L[100] [100]
	var/x = 1
	var/y = 1

/datum/generator/proc/generate()
	for(x=1, x<=L.len, x++)
		L[x] [y] = rand(1,100)
		for(y=1, y<=L.len, y++)
			L[x] [y] = rand(1,100)

/datum/generator/proc/smooth()
	x=1
	y=1
	for(x=1, x<=L.len, x++)
		var/a = L[x+1] [y]
		var/b = L[x>1?x-1:1] [y]
		var/c = L[x] [y+1]
		var/d = L[x] [y>1?y-1:1]
		if(L[x] [y] > ((a + b + c + d)/4))
			L[x] [y] += 10
		else
			L[x] [y] -= 10
		for(y=1, y<=L.len, y++)
			a = L[x+1] [y]
			b = L[x>1?x-1:1] [y]
			c = L[x] [y+1]
			d = L[x] [y>1?y-1:1]
			if(L[x] [y] > ((a + b + c + d)/4))
				L[x] [y] += 10
			else
				L[x] [y] -= 10

/datum/generator/proc/print()
	var/coord_x = 1
	var/coord_y = 1

