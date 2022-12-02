local L = BigWigs:NewBossLocale("Lorewalker Stonestep", "deDE")
if not L then return end
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	L.yaungol_warmup_trigger = "Ah, es ist noch nicht vorbei."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	L.five_suns_warmup_trigger = "Es scheint mir"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "deDE")
if L then
	L.corrupt_living_water = "Verderbtes lebendiges Wasser"
	--L.fallen_waterspeaker = "Fallen Waterspeaker"
	L.haunting_sha = "Geisterhaftes Sha"
	L.the_talking_fish = "Der sprechende Fisch"
	L.the_songbird_queen = "Die Singvogelkönigin"
	L.the_crybaby_hozen = "Der Heulsusen-Ho-zen"
	L.the_nodding_tiger = "Der Nickende Tiger"
	L.the_golden_beetle = "Der Goldkäfer"
	--L.sha_touched_guardian = "Sha-Touched Guardian"
	--L.depraved_mistweaver = "Depraved Mistweaver"
	--L.shambling_infester = "Shambling Infester"
end
