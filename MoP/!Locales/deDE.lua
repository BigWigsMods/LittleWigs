-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "deDE")
if not L then return end
if L then
	L.name = "Kanrethad Schwarzhaupt"

	L.summons = "Beschworene"
	L.debuffs = "Debuffs"

	L.start_say = "SEHT" -- BEHOLD! I have truly mastered the fel energies of this world! The demonic power I now command... It is indescribable, unlimited, OMNIPOTENT!
	L.win_say = "Jubeka" -- Jubeka?! What are you...?!
end

L = BigWigs:NewBossLocale("Essence of Order", "deDE")
if L then
	L.name = "Essenz der Ordnung"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "deDE")
if L then
	L.engage_yell = "Meine endlose Pein soll auch Eure sein!"
end

L = BigWigs:NewBossLocale("Brother Korloff", "deDE")
if L then
	L.engage_yell = "Ich werde Euch brechen."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "deDE")
if L then
	L.engage_yell = "Meine Legende beginnt JETZT!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "deDE")
if L then
	L.the_headless_horseman = "Der kopflose Reiter"
	L.custom_on_autotalk_desc = "Automatisch die Flüche der Weidenmänner akzeptieren und die Begegnung starten."
	L.curses_desc = "Benachrichtigt Dich beim Empfangen eines Fluchs eines Weidenmannes."
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "deDE")
if L then
	L.stage_2_trigger = "Jetzt ist es an der Zeit für Eure Transformation, Lilian."
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "deDE")
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	L.stage3_yell = "ich klein war"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "deDE")
if L then
	L.destroying_sha = "Zerstörendes Sha"
	L.slain_shado_pan_defender = "Erschlagener Shado-Pan-Verteidiger"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "deDE")
if L then
	L.summon_desc = "Warnen wenn Yan-Zhu einen Hefigen Braubierlementar beschwört. Diese können |cff71d5ffFermentierung|r wirken, um den Boss zu heilen."
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "deDE")
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	L.yaungol_warmup_trigger = "Ah, es ist noch nicht vorbei."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	L.five_suns_warmup_trigger = "Es scheint mir"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "deDE")
if L then
	L.corrupt_living_water = "Verderbtes lebendiges Wasser"
	L.fallen_waterspeaker = "Gefallener Wassersprecher"
	L.haunting_sha = "Geisterhaftes Sha"
	L.the_talking_fish = "Der sprechende Fisch"
	L.the_songbird_queen = "Die Singvogelkönigin"
	L.the_crybaby_hozen = "Der Heulsusen-Ho-zen"
	L.the_nodding_tiger = "Der Nickende Tiger"
	L.the_golden_beetle = "Der Goldkäfer"
	L.sha_touched_guardian = "Sha-berührter Wächter"
	L.depraved_mistweaver = "Verkommener Nebelwirker"
	L.shambling_infester = "Schlurfender Verseucher"
	L.minion_of_doubt = "Diener des Zweifels"
end
