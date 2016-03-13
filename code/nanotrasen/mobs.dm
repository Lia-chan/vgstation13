/mob/living/simple_animal/hostile/bear/soviet
	name = "SOVIETSKI MEDVED NASH"
	desc = "Oh no! That's a communist bear!"
	icon_state = "brownbear"
	icon_living = "brownbear"
	icon_floor = null
	icon_dead = "brownbear_dead"
	icon_gib = "brownbear_gib"

/mob/living/simple_animal/hostile/bear/zombie
	name = "mindless zombie"
	desc = "Looks like it interested in your brain"
	icon = 'icons/nanotrasen/zombies.dmi'
	icon_state = "zombie1"
	icon_dead = "zombie1_dead"
	//icon_gib
	icon_floor = null //to prevent changing on floor
	speak = list("Braaaaainz!")
	speak_emote = list("growls", "roars")
	emote_hear = list("rawrs","grumbles","grawls")
	emote_see = list("stares ferociously", "stomps")
	speak_chance = 1
	see_in_dark = 6
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/human
	stop_automated_movement_when_pulled = 0
	maxHealth = 60
	health = 60
//	harm_intent_damage = 10
	melee_damage_lower = 20
	melee_damage_upper = 30
//	a_intent = "harm"
	speed = 4
	faction = "zombie"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	attacktext = "bites"
	var/poison_per_bite = 5
	var/poison_type = "toxin"
	New()
		var/randicon = rand(1,6)
		icon_living = "zombie[randicon]"
		icon_state = icon_living
		icon_dead = "zombie[randicon]_dead"
		..()

/mob/living/simple_animal/hostile/bear/zombie/AttackingTarget()
	..()
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		if(L.reagents)
			L.reagents.add_reagent("toxin", poison_per_bite)
			if(prob(poison_per_bite))
				L << "\red That was painful!"
				L.reagents.add_reagent(poison_type, 5)
				L.zombie_bit(src)