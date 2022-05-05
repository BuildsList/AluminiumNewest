/mob/living/carbon/alien/verb/ventcrawl() // -- TLE
	set name = "Crawl through vent"
	set desc = "Enter an air vent and crawl through the pipe system."
	set category = "Alien"
	handle_ventcrawl()

/mob/living/carbon/alien/verb/toggle_darkness()
	set name = "Toggle Darkness"
	set category = "Alien"

	if(nightvision)
		see_in_dark = 4
		nightvision = 0
	else
		see_in_dark = 8
		nightvision = 1
