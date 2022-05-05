//craftitems ist gut -- odst


/obj/item/weapon/craftitems
	name = "rubber plate"
	desc = "A plate of pure rubber"
	icon = 'icons/obj/crafticon.dmi'
	icon_state = "craftic"
	force = 5.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	m_amt = 150
	flags = FPRINT | TABLEPASS | CONDUCT
	origin_tech = "materials=1"
	attack_verb = list("attacked", "slashed")

/obj/item/weapon/craftitems/New()
	if (prob(60))
		src.pixel_y = rand(0, 4)
	return

/obj/item/weapon/craftitems/frame/gunframe
	name = "frame"
	icon_state = "gunframeic"
	item_state = "buildpipe"

/obj/item/weapon/craftitems/frame/frame
	name = "frame"
	icon_state = "frameic"
	item_state = "buildpipe"

/obj/item/weapon/craftitems/middlecomponent/metalpart
	name = "part"
	desc = "A metal part"
	icon_state = "metalpartic"
	item_state = "table_parts"

/obj/item/weapon/craftitems/middlecomponent/scrapmetal
	name = "scrap metal"
	desc = "A scrap metal"
	icon_state = "scrapmetalic"
	item_state = "rods"


/obj/item/weapon/craftitems/endcomponent/powder
	name = "tin of powder"
	desc = "A tin of powder"
	icon_state = "powderic"
	item_state = "atoxinbottle"

/obj/item/weapon/craftitems/endcomponent/chain
	name = "chain"
	desc = "A chain"
	icon_state = "chainic"
	item_state = "chain"

/obj/item/weapon/craftitems/endcomponent/screws
	name = "screws"
	desc = "A screws"
	icon_state = "nailsic"

/obj/item/weapon/craftitems/endcomponent/nails
	name = "nails"
	desc = "A nails"
	icon_state = "nailsic"

/obj/item/weapon/craftitems/endcomponent/rope
	name = "rope"
	desc = "A rope"
	icon_state = "ropeic"
	item_state = "c_tube"

/obj/item/weapon/craftitems/endcomponent/stone
	name = "stone"
	desc = "A stone"
	icon_state = "stoneic"
	force = 10.0
	throwforce = 14.0

/obj/item/weapon/craftitems/endcomponent/stick
	name = "stick"
	desc = "A stick"
	icon_state = "stickic"
	item_state = "stickic"

/obj/item/weapon/craftitems/endcomponent/pipe
	name = "pipe"
	desc = "A pipe"
	icon_state = "pipeic"



/obj/item/weapon/craftitems/endcomponent/screws/attackby(var/obj/item/R, mob/user as mob)
	..()
	if(istype(R, /obj/item/weapon/craftitems/endcomponent/screws))
		var/obj/item/weapon/craftitems/endcomponent/chain/E = new /obj/item/weapon/craftitems/endcomponent/chain

		user.put_in_hands(E)
		del(R)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/endcomponent/screws/attackby(var/obj/item/Q, mob/user as mob)
	..()
	if(istype(Q, /obj/item/weapon/craftitems/middlecomponent/scrapmetal))
		var/obj/item/weapon/craftitems/middlecomponent/metalpart/W = new /obj/item/weapon/craftitems/middlecomponent/metalpart

		user.put_in_hands(W)
		del(Q)
		del(src)
		update_icon()

/obj/item/clothing/under/attackby(var/obj/item/Y, mob/user as mob)
	..()
	if(istype(Y, /obj/item/weapon/kitchenknife) || \
		istype(Y, /obj/item/weapon/kitchen/utensil/knife) || \
		istype(Y, /obj/item/weapon/twohanded/fireaxe) || \
		istype(Y, /obj/item/weapon/hatchet/topor) || \
		istype(Y, /obj/item/weapon/butch) || \
		istype(Y, /obj/item/weapon/hatchet) )
		var/obj/item/stack/medical/advanced/patch/W = new /obj/item/stack/medical/advanced/patch

		user.put_in_hands(W)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/endcomponent/stick/attackby(var/obj/item/U, mob/user as mob)
	..()
	if(istype(U, /obj/item/weapon/craftitems/middlecomponent/metalpart))
		var/obj/item/weapon/shovel/r = new /obj/item/weapon/shovel

		user.put_in_hands(r)
		del(U)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/endcomponent/stick/attackby(var/obj/item/q, mob/user as mob)
	..()
	if(istype(q, /obj/item/weapon/kitchenknife) || \
		istype(q, /obj/item/weapon/kitchen/utensil/knife) || \
		istype(q, /obj/item/weapon/twohanded/fireaxe) || \
		istype(q, /obj/item/weapon/hatchet/topor) || \
		istype(q, /obj/item/weapon/butch) || \
		istype(q, /obj/item/weapon/hatchet) )
		var/obj/item/weapon/bat/e = new /obj/item/weapon/bat

		user.put_in_hands(e)
		del(src)
		update_icon()

/obj/item/weapon/bat/attackby(var/obj/item/n, mob/user as mob)
	..()
	if(istype(n, /obj/item/weapon/craftitems/endcomponent/screws))
		var/obj/item/weapon/bat/av/o = new /obj/item/weapon/bat/av

		user.put_in_hands(o)
		del(n)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/middlecomponent/scrapmetal/attackby(var/obj/item/k, mob/user as mob)
	..()
	if(istype(k, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/neck/Z = new /obj/item/weapon/neck

		user.put_in_hands(Z)
		del(src)
		update_icon()

/obj/item/weapon/crowbar/attackby(var/obj/item/p, mob/user as mob)
	..()
	if(istype(p, /obj/item/weapon/craftitems/middlecomponent/metalpart))
		var/obj/item/weapon/hatchet/topor/V = new /obj/item/weapon/hatchet/topor

		user.put_in_hands(V)
		del(p)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/endcomponent/chain/attackby(var/obj/item/z, mob/user as mob)
	..()
	if(istype(z, /obj/item/weapon/craftitems/endcomponent/chain))
		var/obj/item/clothing/suit/armor/vest/handmade/bad/b = new /obj/item/clothing/suit/armor/vest/handmade/bad

		user.put_in_hands(b)
		del(z)
		del(src)
		update_icon()

/obj/item/clothing/suit/armor/vest/handmade/bad/attackby(var/obj/item/y, mob/user as mob)
	..()
	if(istype(y, /obj/item/weapon/weldingtool))
		var/obj/item/clothing/suit/armor/vest/handmade/good/c = new /obj/item/clothing/suit/armor/vest/handmade/good

		user.put_in_hands(c)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/middlecomponent/metalpart/attackby(var/obj/item/P, mob/user as mob)
	..()
	if(istype(P, /obj/item/weapon/craftitems/middlecomponent/metalpart))
		var/obj/item/clothing/head/helmet/handmade/bad/v = new /obj/item/clothing/head/helmet/handmade/bad

		user.put_in_hands(v)
		del(P)
		del(src)
		update_icon()

/obj/item/clothing/head/helmet/handmade/bad/attackby(var/obj/item/L, mob/user as mob)
	..()
	if(istype(L, /obj/item/weapon/craftitems/middlecomponent/metalpart))
		var/obj/item/clothing/head/helmet/handmade/good/l = new /obj/item/clothing/head/helmet/handmade/good

		user.put_in_hands(l)
		del(L)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/frame/frame/attackby(var/obj/item/g, mob/user as mob)
	..()
	if(istype(g, /obj/item/weapon/craftitems/middlecomponent/metalpart))
		var/obj/item/weapon/craftitems/frame/gunframe/h = new /obj/item/weapon/craftitems/frame/gunframe

		user.put_in_hands(h)
		del(g)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/frame/gunframe/attackby(var/obj/item/x, mob/user as mob)
	..()
	if(istype(x, /obj/item/weapon/craftitems/endcomponent/pipe))
		var/obj/item/weapon/gun/projectile/pistol/legger/H = new /obj/item/weapon/gun/projectile/pistol/legger

		user.put_in_hands(H)
		del(x)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/frame/gunframe/attackby(var/obj/item/s, mob/user as mob)
	..()
	if(istype(s, /obj/item/weapon/craftitems/endcomponent/rope))
		var/obj/item/weapon/crossbow/C = new /obj/item/weapon/crossbow

		user.put_in_hands(C)
		del(s)
		del(src)
		update_icon()

/obj/item/weapon/craftitems/endcomponent/stick/attackby(var/obj/item/f, mob/user as mob)
	..()
	if(istype(f, /obj/item/stack/medical/advanced/patch) || \
		istype(f, /obj/item/clothing/under) || \
		istype(f, /obj/item/weapon/paper) || \
		istype(f, /obj/item/blueprints) || \
		istype(f, /obj/item/device/flashlight/flare) || \
		istype(f, /obj/item/weapon/weldingtool) )
		var/obj/item/device/flashlight/flare/torch/a = new /obj/item/device/flashlight/flare/torch

		user.put_in_hands(a)
		del(f)
		del(src)
		update_icon()


