-- End Time

local L = BigWigs:NewBossLocale("Echo of Baine", "frFR")
if not L then return end
if L then
	L.totemDrop = "Totem lâché"
	L.totemThrow = "Totem lancé par %s"
end

-- Grim Batol

L = BigWigs:NewBossLocale("Erudax", "frFR")
if L then
	L.summon = "Invocation d'un corrupteur sans-visage"
	L.summon_desc = "Préviens lorsqu'Erudax invoque un Corrupteur sans-visage."
	L.summon_message = "Corrupteur sans-visage invoqué"
	L.summon_trigger = "invoque un"
end

L = BigWigs:NewBossLocale("Grim Batol Trash", "frFR")
if L then
	L.twilight_earthcaller = "Implorateur(trice) de la terre du Crépuscule"
	L.twilight_brute = "Brute du Crépuscule"
	L.twilight_destroyer = "Destructeur du Crépuscule"
	L.twilight_overseer = "Surveillant du Crépuscule"
	L.twilight_beguiler = "Imposteur du Crépuscule"
	L.molten_giant = "Géant de lave"
	L.twilight_warlock = "Démoniste du Crépuscule"
	L.twilight_flamerender = "Tranche-flammes du Crépuscule"
	L.twilight_lavabender = "Tournelave du Crépuscule"
	L.faceless_corruptor = "Corrupteur sans-visage"
end

-- Hour of Twilight

L = BigWigs:NewBossLocale("The Hour of Twilight Trash", "frFR")
if L then
	L.custom_on_autotalk_desc = "Séléctionne automatiquement les options de dialogue de Thrall."
end

-- Lost City of the Tol'vir

L = BigWigs:NewBossLocale("Siamat", "frFR")
if L then
	L.servant = "Invocation de serviteur"
	L.servant_desc = "Prévient quand un Serviteur de Siamat est invoqué."
end

-- Shadowfang Keep

L = BigWigs:NewBossLocale("Lord Walden", "frFR")
if L then
	-- %s will be either "Toxic Coagulant" or "Toxic Catalyst"
	L.coagulant = "%s : se déplacer pour dispell"
	L.catalyst = "%s : Amélioration critique"
	L.toxin_healer_message = "%s : Dégâts sur la durée sur tout le monde"
end

-- The Stonecore

L = BigWigs:NewBossLocale("Corborus", "frFR")
if L then
	L.burrow = "Fouir/Émergence"
	L.burrow_desc = "Prévient quand Corborus s'enterre ou émerge."
	L.burrow_message = "Corborus s'enterre"
	L.burrow_warning = "Fouir dans 5 sec. !"
	L.emerge_message = "Corborus émerge !"
	L.emerge_warning = "Émergence dans 5 sec. !"
end

-- Throne of the Tides

L = BigWigs:NewBossLocale("Throne of the Tides Trash", "frFR")
if L then
	L.nazjar_oracle = "Oracle naz'jar"
	L.vicious_snap_dragon = "Dragon happeur vicieux"
	L.nazjar_sentinel = "Sentinelle naz'jar"
	L.nazjar_ravager = "Ravageur naz'jar"
	L.nazjar_tempest_witch = "Sorcière des tempêtes naz'jar"
	L.faceless_seer = "Voyant sans-visage"
	L.faceless_watcher = "Gardien sans-visage"
	L.tainted_sentry = "Factionnaire corrompu"

	--L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "frFR")
if L then
	--L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	--L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

-- The Vortex Pinnacle

L = BigWigs:NewBossLocale("The Vortex Pinnacle Trash", "frFR")
if L then
	L.armored_mistral = "Mistral cuirassé"
	L.gust_soldier = "Soldat bourrasque"
	L.wild_vortex = "Vortex sauvage"
	L.lurking_tempest = "Tempête en maraude"
	L.cloud_prince = "Prince-nuage"
	L.turbulent_squall = "Grain turbulent"
	L.empyrean_assassin = "Assassin empyréen"
	L.young_storm_dragon = "Jeune dragon des tempêtes"
	L.executor_of_the_caliph = "Exécuteur du Calife"
	L.temple_adept = "Adepte du temple"
	L.servant_of_asaad = "Serviteur d'Asaad"
	L.minister_of_air = "Ministre de l'air"
end

-- Well of Eternity

L = BigWigs:NewBossLocale("Well Of Eternity Trash", "frFR")
if L then
	L.custom_on_autotalk_desc = "Séléctionne automatiquement les options de dialogue d'Illidan."
end

-- Zul'Aman

L = BigWigs:NewBossLocale("Daakara", "frFR")
if L then
	L[42594] = "Forme d'ours Form" -- short form for "Essence of the Bear"
	L[42607] = "Forme de lynx Form"
	L[42606] = "Forme d'aigle Form"
	L[42608] = "Forme de faucon-dragon"
end

L = BigWigs:NewBossLocale("Halazzi", "frFR")
if L then
	L.spirit_message = "Phase d'esprit"
	L.normal_message = "Phase normale"
end

L = BigWigs:NewBossLocale("Nalorakk", "frFR")
if L then
	L.troll_message = "Forme de troll"
	--L.troll_trigger = "Make way for da Nalorakk!"
end

-- Zul'Gurub

L = BigWigs:NewBossLocale("Jin'do the Godbreaker", "frFR")
if L then
	L.barrier_down_message = "Barrière tombée, %d restant(s)" -- short name for "Brittle Barrier" (97417)
end
