//It's not a very big change, but I think melee will benefit from it.
//Currently will only be restricted to special training weapons to test the balancedness of the system.
//1)Knockdown, stun and weaken chances are separate and dependant on the part of the body you're aiming at
//eg a mop will be better applied to legs since it has a higher base knockdown chance than the other disabling states
//while an energy gun would be better applied to the chest because of the stunning chance.
//2)Weapons also have a parry chance which is checked every time the one wielding the weapon is attacked in melee
//in the area is currently aiming at and is able to defend himself.
//More ideas to come.

//NOTES: doesn't work with armor yet

/obj/item/weapon/training //subclass of weapons that is currently the only one that uses the alternate combat system

	name = "training weapon"
	desc = "A weapon for training the advanced fighting technicues"
	icon = 'icons/obj/weapons.dmi'
	var/chance_parry = 0
	var/chance_weaken = 0
	var/chance_stun = 0
	var/chance_knockdown = 0
	var/chance_knockout = 0
	var/chance_disarm = 0


//chances - 5 is low, 10 is medium, 15 is good

/obj/item/weapon/training/axe //hard-hitting, but doesn't have much in terms of disabling people (except by killing)
	name = "training axe"
	icon_state = "hatchet"
	/*combat stats*/
	force = 15
	chance_parry = 5
	chance_weaken = 10
	chance_stun = 5
	chance_knockdown = 5
	chance_knockout = 5
	chance_disarm = 0

/obj/item/weapon/training/sword //not bad attack, good at parrying and disarming
	name = "training sword"
	icon_state = "claymore"
	/*combat stats*/
	force = 10
	sharp = 1
	chance_parry = 30
	chance_weaken = 5
	chance_stun = 0
	chance_knockdown = 5
	chance_knockout = 0
	chance_disarm = 20

/obj/item/weapon/training/staff //not bad attack either, good at tripping and parrying
	name = "training staff"
	icon_state = "training_staff"
	/*combat stats*/
	force = 10
	chance_parry = 15
	chance_weaken = 5
	chance_stun = 0
	chance_knockdown = 15
	chance_knockout = 0
	chance_disarm = 10

/obj/item/weapon/training/mace //worst attack, but has a good chance of stun, knockout or weaken
	name = "training mace"
	icon_state = "training_mace"
	/*combat stats*/
	force = 5
	chance_parry = 0
	chance_weaken = 15
	chance_stun = 10
	chance_knockdown = 0
	chance_knockout = 10
	chance_disarm = 0

/obj/item/weapon/training/attack(target as mob, mob/user as mob, location, control, params)

	if((!istype(target, /mob/living/carbon)) || (!istype(user, /mob/living/carbon)))
		..()
		return

	var/list/PL = params2list(params)
	var/icon_x = text2num(PL["icon-x"])
	var/icon_y = text2num(PL["icon-y"])

	var/mob/living/carbon/A = user
	var/mob/living/carbon/T = target
	var/target_area = A.zone_sel.selecting
	for(var/mob/O in viewers(target))
		O << "\red \b [A.name] attacks [T.name] in the [target_area] with [src.name]!"
	if(T.stat < 2 && T.zone_sel.selecting == target_area) //parrying occurs here
		if(istype(T.r_hand,/obj/item/weapon/training))
			if(prob(T.r_hand:chance_parry))
				for(var/mob/O in viewers(target))
					O << "\red \b [T.name] deftly parries the attack with [T.r_hand.name]!"
					if(prob(chance_disarm))
						O << "\red The [T.r_hand.name] flies out of [T.name]'s hands!"
						T.drop_r_hand()
						return
		if(istype(T.l_hand,/obj/item/weapon/training))
			if(prob(T.l_hand:chance_parry))
				for(var/mob/O in viewers(target))
					O << "\red \b [T.name] deftly parries the attack with [T.l_hand.name]!"
					if(prob(chance_disarm))
						O << "\red The [T.r_hand.name] flies out of [T.name]'s hands!"
						T.drop_l_hand()
						return
	if(sharp)
		if(user.att_intent == "stab" && user.zone_sel.selecting == "chest")
			if(prob(force*2))
				stab(target,user)
				return
	T.apply_damage(src.force, BRUTE, target_area, 0, src.sharp)
/*
	var/modifier_knockdown = 1.0
	var/modifier_knockout = 1.0
	var/modifier_stun = 1.0
	var/modifier_weaken = 1.0
	var/modifier_disarm = 0.0

        switch(target_area)
                if("eyes")
                        modifier_weaken = 2.0
                        modifier_stun = 0.5
                        modifier_knockdown = 0.0
                if("head")
                        modifier_stun = 0.8
                        modifier_knockout = 1.5
                        modifier_weaken = 1.2
                        modifier_knockdown = 0.0
                if("chest")
                if("right arm","r_arm")
                if("left arm","l_arm")
                if("right hand","r_hand")
                if("left hand","l_hand")
                if("groin")
                if("right leg","r_leg")
                if("left leg","l_leg")
                if("right foot","r_foot")
                if("left foot","l_foot")


	if(prob(chance_knockdown*modifier_knockdown))
		T.Weaken(1)
		for(var/mob/O in viewers(target))
			O << "\red \b [T.name] has been knocked down!"
	if(prob(chance_disarm*modifier_disarm))
		T.Weaken(1)
		for(var/mob/O in viewers(target))
			O << "\red \b [T.name] has been knocked down!"
*/

/obj/item/weapon/training/proc/attack_location(target as mob, var/initloc = "chest", location, control, params) //proc to randomise actual hit loc based on where you're aiming at
    var/resultloc = "chest" //also forgot hands/feet. bleh
    var/list/PL = params2list(params)
	var/icon_x = text2num(PL["icon-x"])
	var/icon_y = text2num(PL["icon-y"])

	if(!(hasorgans(target)))
		return

	if(dir = NORTH || dir = SOUTH)
		switch(icon_y)
			if(1 to 3) //Feet
				switch(icon_x)
					if(10 to 15)
						resultloc = "r_foot"
					if(17 to 22)
						resultloc = "l_foot"
					else
						return 1
			if(4 to 9) //Legs
				switch(icon_x)
					if(10 to 15)
						resultloc = "r_leg"
					if(17 to 22)
						resultloc = "l_leg"
					else
						return 1
			if(10 to 13) //Hands and groin
				switch(icon_x)
					if(8 to 11)
						resultloc = "r_hand"
					if(12 to 20)
						resultloc = "groin"
					if(21 to 24)
						resultloc = "l_hand"
					else
						return 1
			if(14 to 22) //Chest and arms to shoulders
				switch(icon_x)
					if(8 to 11)
						resultloc = "r_arm"
					if(12 to 20)
						resultloc = "chest"
					if(21 to 24)
						resultloc = "l_arm"
					else
						return 1
			if(23 to 30) //Head, but we need to check for eye or mouth
				if(icon_x in 12 to 20)
					resultloc = "head"
					switch(icon_y)
						if(23 to 24)
							if(icon_x in 15 to 17)
								resultloc = "mouth"
						if(26) //Eyeline, eyes are on 15 and 17
							if(icon_x in 14 to 18)
								resultloc = "eyes"
						if(25 to 27)
							if(icon_x in 15 to 17)
								resultloc = "eyes"


    return resultloc