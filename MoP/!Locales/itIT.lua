-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "itIT")
if not L then return end
if L then
	L.name = "Kanrethad Serranero"

	L.summons = "Evocazioni"
	L.debuffs = "Malefici"

	L.start_say = "GUARDA" -- BEHOLD! I have truly mastered the fel energies of this world! The demonic power I now command... It is indescribable, unlimited, OMNIPOTENT!
	L.win_say = "Jubeka" -- Jubeka?! What are you...?!
end

L = BigWigs:NewBossLocale("Essence of Order", "itIT")
if L then
	L.name = "Essenza dell'Ordine"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "itIT")
if L then
	L.engage_yell = "La mia eterna agonia sarà anche la vostra!"
end

L = BigWigs:NewBossLocale("Brother Korloff", "itIT")
if L then
	L.engage_yell = "Vi spezzo in due."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "itIT")
if L then
	L.engage_yell = "La mia leggenda comincia ORA!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "itIT")
if L then
	L.the_headless_horseman = "Cavaliere Senza Testa"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "itIT")
if L then
	--L.stage_2_trigger = "Now, Lilian, it is time for your transformation."
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "itIT")
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	L.stage3_yell = "ero un cucciolo"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "itIT")
if L then
	L.destroying_sha = "Sha Distruttivo"
	L.slain_shado_pan_defender = "Difensore Shandaren Ucciso"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "itIT")
if L then
	--L.summon_desc = "Warn when Yan-Zhu summons a Yeasty Brew Alemental. They can cast |cff71d5ffFerment|r to heal the boss."
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "itIT")
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	--L.yaungol_warmup_trigger = "Ah, it is not yet over."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	--L.five_suns_warmup_trigger = "If I am not mistaken"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "itIT")
if L then
	L.corrupt_living_water = "Acqua Vivente Corrotta"
	L.fallen_waterspeaker = "Oratore dell'Acqua Caduto"
	L.haunting_sha = "Sha Infestante"
	L.the_talking_fish = "Il Pesce Parlante"
	L.the_songbird_queen = "La Gru Cantante"
	L.the_crybaby_hozen = "L'Hozen Piangente"
	L.the_nodding_tiger = "La Tigre Ondeggiante"
	L.the_golden_beetle = "La Blatta Dorata"
	L.sha_touched_guardian = "Guardiano Toccato dallo Sha"
	L.depraved_mistweaver = "Teurga del Misticismo Degenerata"
	L.shambling_infester = "Infestatore Barcollante"
	L.minion_of_doubt = "Servitore del Dubbio"
end
