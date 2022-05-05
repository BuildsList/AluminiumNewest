/obj/item/device/flashlight
	name = "flashlight"
	desc = "A hand-held emergency light."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight"
	item_state = "flashlight"
	w_class = 2
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	m_amt = 50
	g_amt = 20
	icon_action_button = "action_flashlight"
	var/on = 0
	var/brightness_Red = 4			//luminosity when on, R
	var/brightness_Green = 4		//luminosity when on, G
	var/brightness_Blue = 4			//luminosity when on, B

/obj/item/device/flashlight/initialize()
	..()
	if(on)
		icon_state = "[initial(icon_state)]-on"
		ul_SetLuminosity(brightness_Red, brightness_Green, brightness_Blue)
	else
		icon_state = initial(icon_state)
		ul_SetLuminosity(0)

/obj/item/device/flashlight/proc/update_brightness(var/mob/user = null)
	if(on)
		icon_state = "[initial(icon_state)]-on"
		if(loc == user)
			user.ul_SetLuminosity(user.LuminosityRed + brightness_Red, user.LuminosityGreen + brightness_Green, user.LuminosityBlue + brightness_Blue)
		else if(isturf(loc))
			ul_SetLuminosity(brightness_Red, brightness_Green, brightness_Blue)
	else
		icon_state = initial(icon_state)
		if(loc == user)
			user.ul_SetLuminosity(user.LuminosityRed - brightness_Red, user.LuminosityGreen - brightness_Green, user.LuminosityBlue - brightness_Blue)
		else if(isturf(loc))
			ul_SetLuminosity(0)

/obj/item/device/flashlight/attack_self(mob/user)
	if(!isturf(user.loc))
		user << "You cannot turn the light on while in this [user.loc]." //To prevent some lighting anomalities.
		return 0
	on = !on
	update_brightness(user)
	return 1


/obj/item/device/flashlight/attack(mob/living/M as mob, mob/living/user as mob)
	add_fingerprint(user)
	if(on && user.zone_sel.selecting == "eyes")

		if(((CLUMSY in user.mutations) || user.getBrainLoss() >= 60) && prob(50))	//too dumb to use flashlight properly
			return ..()	//just hit them in the head

		if(!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")	//don't have dexterity
			user << "<span class='notice'>You don't have the dexterity to do this!</span>"
			return

		var/mob/living/carbon/human/H = M	//mob has protective eyewear
		if(istype(M, /mob/living/carbon/human) && ((H.head && H.head.flags & HEADCOVERSEYES) || (H.wear_mask && H.wear_mask.flags & MASKCOVERSEYES) || (H.glasses && H.glasses.flags & GLASSESCOVERSEYES)))
			user << "<span class='notice'>You're going to need to remove that [(H.head && H.head.flags & HEADCOVERSEYES) ? "helmet" : (H.wear_mask && H.wear_mask.flags & MASKCOVERSEYES) ? "mask": "glasses"] first.</span>"
			return

		if(M == user)	//they're using it on themselves
			if(!M.blinded)
				flick("flash", M.flash)
				M.visible_message("<span class='notice'>[M] directs [src] to \his eyes.</span>", \
									 "<span class='notice'>You wave the light in front of your eyes! Trippy!</span>")
			else
				M.visible_message("<span class='notice'>[M] directs [src] to \his eyes.</span>", \
									 "<span class='notice'>You wave the light in front of your eyes.</span>")
			return

		user.visible_message("<span class='notice'>[user] directs [src] to [M]'s eyes.</span>", \
							 "<span class='notice'>You direct [src] to [M]'s eyes.</span>")

		if(istype(M, /mob/living/carbon/human) || istype(M, /mob/living/carbon/monkey))	//robots and aliens are unaffected
			if(M.stat == DEAD || M.sdisabilities & BLIND)	//mob is dead or fully blind
				user << "<span class='notice'>[M] pupils does not react to the light!</span>"
			else if(XRAY in M.mutations)	//mob has X-RAY vision
				flick("flash", M.flash) //Yes, you can still get flashed wit X-Ray.
				user << "<span class='notice'>[M] pupils give an eerie glow!</span>"
			else	//they're okay!
				if(!M.blinded)
					flick("flash", M.flash)	//flash the affected mob
					user << "<span class='notice'>[M]'s pupils narrow.</span>"
	else
		return ..()


/obj/item/device/flashlight/pickup(mob/user)
	if(on)
		user.ul_SetLuminosity(user.LuminosityRed + brightness_Red, user.LuminosityGreen + brightness_Green, user.LuminosityBlue + brightness_Blue)
		ul_SetLuminosity(0)


/obj/item/device/flashlight/dropped(mob/user)
	if(on)
		user.ul_SetLuminosity(user.LuminosityRed - brightness_Red, user.LuminosityGreen - brightness_Green, user.LuminosityBlue - brightness_Blue)
		ul_SetLuminosity(brightness_Red, brightness_Green, brightness_Blue)


/obj/item/device/flashlight/pen
	name = "penlight"
	desc = "A pen-sized light, used by medical staff."
	icon_state = "penlight"
	item_state = ""
	flags = FPRINT | TABLEPASS | CONDUCT
	brightness_Red = 2
	brightness_Green = 2
	brightness_Blue = 2


// the desk lamps are a bit special
/obj/item/device/flashlight/lamp
	name = "desk lamp"
	desc = "A desk lamp with an adjustable mount."
	icon_state = "lamp"
	item_state = "lamp"
	w_class = 4
	flags = FPRINT | TABLEPASS | CONDUCT
	m_amt = 0
	g_amt = 0
	brightness_Red = 6
	brightness_Green = 6
	brightness_Blue = 6
	on = 1


// green-shaded desk lamp
/obj/item/device/flashlight/lamp/green
	desc = "A classic green-shaded desk lamp."
	icon_state = "lampgreen"
	item_state = "lampgreen"


/obj/item/device/flashlight/lamp/verb/toggle_light()
	set name = "Toggle light"
	set category = "Object"
	set src in oview(1)

	if(!usr.stat)
		attack_self(usr)

// FLARES

/obj/item/device/flashlight/flare
	name = "flare"
	desc = "A red issued flare. There are instructions on the side, it reads 'pull cord, make light'."
	w_class = 2.0
	brightness_Red = 7		//R - pretty bright
	brightness_Green = 1
	brightness_Blue = 1
	icon_state = "flare"
	item_state = "flare"
	icon_action_button = null	//just pull it manually, neckbeard.
	var/fuel = 0
	var/on_damage = 7
	var/produce_heat = 1500

/obj/item/device/flashlight/flare/New()
	fuel = rand(800, 1000) // Sorry for changing this so much but I keep under-estimating how long X number of ticks last in seconds.
	..()

/obj/item/device/flashlight/flare/process()
	var/turf/pos = get_turf(src)
	if(pos)
		pos.hotspot_expose(produce_heat, 5)
	fuel = max(fuel - 1, 0)
	if(!fuel || !on)
		turn_off()
		if(!fuel)
			src.icon_state = "[initial(icon_state)]-empty"
		processing_objects -= src

/obj/item/device/flashlight/flare/proc/turn_off()
	on = 0
	src.force = initial(src.force)
	src.damtype = initial(src.damtype)
	if(ismob(loc))
		var/mob/U = loc
		update_brightness(U)
	else
		update_brightness(null)

/obj/item/device/flashlight/flare/attack_self(mob/user)

	// Usual checks
	if(!fuel)
		user << "<span class='notice'>It's out of fuel.</span>"
		return
	if(on)
		return

	. = ..()
	// All good, turn it on.
	if(.)
		user.visible_message("<span class='notice'>[user] activates the flare.</span>", "<span class='notice'>You pull the cord on the flare, activating it!</span>")
		src.force = on_damage
		src.damtype = "fire"
		processing_objects += src

/obj/item/device/flashlight/flare/torch
	name = "handmade torch"
	desc = "A simple torch made of wood and a piece of cloth."
	icon = 'icons/obj/crafticon.dmi'
	icon_state = "firestickic"
	item_state = "firestickic"
	brightness_Red = 5
	brightness_Green = 4
	brightness_Blue = 0


/obj/item/device/flashlight/flare/torch/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn())
			if(!fuel)
				user << "<span class='notice'>It has burned out.</span>"
				return
			if(!isturf(user.loc))
				user << "You cannot turn the light on while in this [user.loc]." //To prevent some lighting anomalities.
				return 0
			if(on)
				return
			on = 1
			update_brightness(user)
			user.visible_message("<span class='notice'>[user] lights [src] with [WT].</span>")
			return 1
	else if(istype(W, /obj/item/weapon/lighter))
		var/obj/item/weapon/lighter/L = W
		if(L.lit)
			if(!isturf(user.loc))
				user << "You cannot turn the light on while in this [user.loc]." //To prevent some lighting anomalities.
				return 0
			if(!fuel)
				user << "<span class='notice'>It has burned out.</span>"
				return
			if(on)
				return
			on = 1
			update_brightness(user)
			user.visible_message("<span class='notice'>[user] lights [src] with [W].</span>")
			return 1
	else if(istype(W, /obj/item/weapon/match))
		var/obj/item/weapon/match/M = W
		if(M.lit)
			if(!isturf(user.loc))
				user << "You cannot turn the light on while in this [user.loc]." //To prevent some lighting anomalities.
				return 0
			if(!fuel)
				user << "<span class='notice'>It has burned out.</span>"
				return
			if(on)
				return
			on = 1
			update_brightness(user)
			user.visible_message("<span class='notice'>[user] lights [src] with [W].</span>")
			return 1
	else
		..()
		return

/obj/item/device/flashlight/flare/torch/attack_self(mob/user)
	user.visible_message("<span class='notice'>[user] puts out the [src]'s fire.</span>")
	on = 0
	return