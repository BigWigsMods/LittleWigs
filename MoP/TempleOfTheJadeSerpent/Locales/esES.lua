local L = BigWigs:NewBossLocale("Lorewalker Stonestep", "esES") or BigWigs:NewBossLocale("Lorewalker Stonestep", "esMX")
if not L then return end
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	--L.yaungol_warmup_trigger = "Ah, it is not yet over."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	--L.five_suns_warmup_trigger = "If I am not mistaken"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "esES") or BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "esMX")
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
