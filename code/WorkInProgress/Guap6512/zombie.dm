mob/var/zombieleader = 0
mob/var/zombieimmune = 0
/mob/living/carbon/proc/zombify()
	stat &= 1
	oxyloss = 0
	becoming_zombie = 0
	zombie = 1
	bodytemperature = 310.055
	see_in_dark = 4
	sight |= SEE_MOBS
	update_icons()
	src.verbs += /mob/living/carbon/proc/supersuicide
//	if(zombieleader)
//		src.verbs -= /mob/living/carbon/proc/zombierelease
	src << "\red<font size=3> You have become a zombie!"
	for(var/mob/O in viewers(src, null))
		O.show_message(text("\red <B>[src] seizes up and falls limp, \his eyes dead and lifeless...[src] is ZOMBIE! HARM CLAW! CLAW! CLAW!</B>"), 1)
//	if(ticker.mode.name == "Zombie Outbreak")
//		ticker.check_win()

/mob/living/carbon/proc/unzombify()
	zombie = 0
	see_in_dark = 2
	update_icons()
	src << "You have been cured from being a zombie!"

/mob/living/carbon/proc/zombie_bit(var/mob/living/carbon/biter)
	var/mob/living/carbon/human/biten = src
	if(zombie || becoming_zombie || !isliving())
		return
	if(stat > 1)//dead: it takes time to reverse death, but there is no chance of failure
		sleep(50)
		zombify()
		return
	if(istype(biten.wear_suit, /obj/item/clothing/suit/bio_suit) || (istype(biten.head, /obj/item/clothing/head/bio_hood)))
		if(istype(biten.head, /obj/item/clothing/head/bio_hood) && (istype(biten.wear_suit, /obj/item/clothing/suit/bio_suit)))
			if(prob(50))
				for(var/mob/M in viewers(src, null))
					if ((M.client && !( M.blinded )))
						M << "[biter.name] fails to bite [name]"
				return
		else if(prob(25))
			for(var/mob/M in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M << "[biter.name] fails to bite [name]"
			return
	for(var/mob/M in viewers(src, null))
		if ((M.client && !( M.blinded )))
			M << "[biter.name] bites [name]"
	if(zombieimmune)
		return
	if(prob(5))
		zombify()
	else if(prob(5))
		becoming_zombie = 1
		src << "You feel a strange itch"
		sleep(300)
		if(becoming_zombie)
			zombify()
	else if(prob(30))
		becoming_zombie = 1
		src << "You faintly feel a strange itch"
		sleep(800)
		if(becoming_zombie)
			src << "You feel a strange itch, stronger this time"
			sleep(400)
			if(becoming_zombie)
				zombify()

/mob/living/carbon/proc/zombie_infect()
	becoming_zombie = 1
	src << "You feel a strange itch"
	sleep(200)
	if(becoming_zombie)
		zombify()
/mob/living/carbon/proc/traitor_infect()
	becoming_zombie = 1
	zombieleader = 1
	src.verbs += /mob/living/carbon/proc/zombierelease
	src << "You have been implanted with a chemical canister you can either release it yourself or wait until it activates."
	sleep(3000)
	if(becoming_zombie)
		zombify()

/mob/living/carbon/proc/admin_infect()
	becoming_zombie = 1
	src << "You faintly feel a strange itch"
	sleep(800)
	if(becoming_zombie)
		src << "You feel a strange itch, stronger this time"
		sleep(400)
		if(becoming_zombie)
			zombify()
/mob/living/carbon/proc/supersuicide()
	set name = "Zombie suicide"
	set hidden = 0
	if(zombie == 1)
		switch(alert(usr,"Are you sure you wanna die?",,"Yes","No"))
			if("Yes")
				fireloss = 999
				src << "You died suprised?"
				return
			else
				src << "You live to see another day."
				return
	else
		src << "Only for zombies."

/mob/living/carbon/proc/zombierelease()
	set name = "Zombify"
	set desc = "Turns you into a zombie"
	if(zombieleader)
		zombify()