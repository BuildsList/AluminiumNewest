/*
//////////////////////////////////////

Zombie

	Very Very Noticable.
	Decreases resistance.
	Decreases stage speed.
	Reduced Transmittable.
	Badmin level.

Bonus
	BRAAAINSSSSS!!!!

//////////////////////////////////////
*/

/*
Пока положу всё связанное с зомби здесь, потом раскидаю по файлам.
*/

/datum/symptom/zombie

	name = "Tombstone Syndrome"
	stealth = -1
	resistance = -2
	stage_speed = -8
	transmittable = -3
	level = 101

/datum/symptom/zombie/Activate(var/datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB))
		var/mob/living/M = A.affected_mob
		if(A.stage == 5)
			if(istype(M,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = M
				if(!H.zombie)
					H.zombify()
		else
			M.toxloss++
	return

/*
/mob/living/carbon/human/proc/zombify()
	zombietime = 0
	zombifying = 0
	zombie = 1
	update_body()
	src << "\red You've become a zombie"
	if(l_hand)
		if (client)
			client.screen -= l_hand
		if (l_hand)
			l_hand.loc = loc
			l_hand.dropped(src)
			l_hand.layer = initial(r_hand.layer)
			l_hand = null
	if(r_hand)
		if (client)
			client.screen -= r_hand
		if (r_hand)
			r_hand.loc = loc
			r_hand.dropped(src)
			r_hand.layer = initial(r_hand.layer)
			r_hand = null
	sight |= SEE_MOBS
	see_in_dark = 4
	see_invisible = 2
	for(var/mob/O in viewers(src, null))
		O.show_message(text("\red <B>[src] seizes up and falls limp, \his eyes dead and lifeless...[src] is ZOMBIE! HARM CLAW! CLAW! CLAW!</B>"), 1)
	UpdateZombieIcons()
	UpdateDamageIcon()




/proc/UpdateZombieIcons()
	spawn(0)
		for(var/mob/living/carbon/human/H in world)
			del(H.zombieimage)
			if(H.zombie)
				H.zombieimage = image('mob.dmi', loc = H, icon_state = "rev")
			else if(H.zombifying)
				H.zombieimage = image('mob.dmi', loc = H, icon_state = "rev_head")
			else
				H.zombieimage = null
		for(var/mob/living/carbon/human/H in world)
			if(H.zombie)
				for(var/mob/living/carbon/human/N in world)
					H << N.zombieimage

*/