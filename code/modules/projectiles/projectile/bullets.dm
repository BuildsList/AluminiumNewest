/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	embed = 1

	on_hit(var/atom/target, var/blocked = 0)
		if (..(target, blocked))
			var/mob/living/L = target
			shake_camera(L, 3, 2)

/obj/item/projectile/bullet/weakbullet // "rubber" bullets
	damage = 10
	stun = 5
	weaken = 5
	embed = 0


/obj/item/projectile/bullet/midbullet
	damage = 30
	stun = 5
	weaken = 5

/obj/item/projectile/bullet/midbullet2
	damage = 35

/obj/item/projectile/bullet/suffocationbullet//How does this even work?
	name = "co bullet"
	damage = 20
	damage_type = OXY


/obj/item/projectile/bullet/cyanideround
	name = "poison bullet"
	damage = 40
	damage_type = TOX


/obj/item/projectile/bullet/burstbullet//I think this one needs something for the on hit
	name = "exploding bullet"
	damage = 20


/obj/item/projectile/bullet/stunshot
	name = "stunshot"
	damage = 5
	stun = 10
	weaken = 10
	stutter = 5
	embed = 0

/obj/item/projectile/bullet/a762
	damage = 25

/obj/item/projectile/bullet/c40
	damage = 24

/obj/item/projectile/bullet/c55
	damage = 43
	stun = 5
	weaken = 5

/obj/item/projectile/bullet/c31
	damage = 15
	stun = 10
	weaken = 10

/obj/item/projectile/bullet/c37
	damage = 10