/mob/living/carbon/proc/bite(mob/living/carbon/human/M as mob)
	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return
