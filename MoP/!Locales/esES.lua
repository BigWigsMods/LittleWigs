-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "esES")
if not L then return end
if L then
	L.name = "Kanrethad Crinébano"

	--L.summons = "Summons"
	--L.debuffs = "Debuffs"

	--L.start_say = "BEHOLD" -- BEHOLD! I have truly mastered the fel energies of this world! The demonic power I now command... It is indescribable, unlimited, OMNIPOTENT!
	--L.win_say = "Jubeka" -- Jubeka?! What are you...?!
end

L = BigWigs:NewBossLocale("Essence of Order", "esES")
if L then
	L.name = "Esencia de orden"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "esES")
if L then
	--L.engage_yell = "My endless agony shall be yours, as well!"
end

L = BigWigs:NewBossLocale("Brother Korloff", "esES")
if L then
	--L.engage_yell = "I will break you."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "esES")
if L then
	--L.engage_yell = "My legend begins NOW!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "esES")
if L then
	L.the_headless_horseman = "El Jinete decapitado"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "esES")
if L then
	--L.stage_2_trigger = "Now, Lilian, it is time for your transformation."
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "esES")
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	--L.stage3_yell = "was but a cub"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "esES")
if L then
	L.destroying_sha = "Sha destructor"
	L.slain_shado_pan_defender = "Defensor del Shadopan asesinado"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "esES")
if L then
	--L.summon_desc = "Warn when Yan-Zhu summons a Yeasty Brew Alemental. They can cast |cff71d5ffFerment|r to heal the boss."
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "esES")
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	--L.yaungol_warmup_trigger = "Ah, it is not yet over."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	--L.five_suns_warmup_trigger = "If I am not mistaken"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "esES")
if L then
	L.corrupt_living_water = "Agua viviente corrupta"
	L.fallen_waterspeaker = "Orador del agua caído"
	L.haunting_sha = "Sha mortificador"
	L.the_talking_fish = "El Pez Parlante"
	L.the_songbird_queen = "La Reina Cantora"
	L.the_crybaby_hozen = "El Hozen Llorica"
	L.the_nodding_tiger = "El Tigre Asertivo"
	L.the_golden_beetle = "El Alfazaque Dorado"
	L.sha_touched_guardian = "Guardián influenciado por el sha"
	L.depraved_mistweaver = "Tejedora de niebla depravada"
	L.shambling_infester = "Infestador renqueante"
	L.minion_of_doubt = "Esbirro de la duda"
end
