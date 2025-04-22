-- End Time

local L = BigWigs:NewBossLocale("Echo of Baine", "ptBR")
if not L then return end
if L then
	L.totemDrop = "Totem dropado"
	L.totemThrow = "Totem lançado por %s"
end

-- Grim Batol

L = BigWigs:NewBossLocale("Erudax", "ptBR")
if L then
	L.summon = "Evoca Corruptor Sem-Rosto"
	L.summon_desc = "Avisa quando Erudax sumonar um Corruptor Sem-Rosto."
	L.summon_message = "Corruptor Sem-Rosto Sumonado"
	L.summon_trigger = "evoca um"
end

L = BigWigs:NewBossLocale("Grim Batol Trash", "ptBR")
if L then
	--L.twilight_earthcaller = "Twilight Earthcaller"
	--L.twilight_brute = "Twilight Brute"
	--L.twilight_destroyer = "Twilight Destroyer"
	L.twilight_overseer = "Supervisor do Crepúsculo"
	--L.twilight_beguiler = "Twilight Beguiler"
	--L.molten_giant = "Molten Giant"
	--L.twilight_warlock = "Twilight Warlock"
	--L.twilight_flamerender = "Twilight Flamerender"
	--L.twilight_lavabender = "Twilight Lavabender"
	--L.faceless_corruptor = "Faceless Corruptor"
end

-- Hour of Twilight

L = BigWigs:NewBossLocale("The Hour of Twilight Trash", "ptBR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Thrall's gossip options."
end

-- Lost City of the Tol'vir

L = BigWigs:NewBossLocale("Siamat", "ptBR")
if L then
	L.servant = "Sumonar Serviçal"
	L.servant_desc = "Avisa quando um Serviçal de Siamat é sumonado."
end

-- Shadowfang Keep

L = BigWigs:NewBossLocale("Lord Walden", "ptBR")
if L then
	-- %s será "Coagulante Tóxico" ou "Catalisador Tóxico"
	L.coagulant = "%s: Mova-se para dissipar"
	L.catalyst = "%s: Buff Crítico"
	L.toxin_healer_message = "%s: DoT em todos"
end

-- The Stonecore

L = BigWigs:NewBossLocale("Corborus", "ptBR")
if L then
	L.burrow = "Afunda/emerge"
	L.burrow_desc = "Avisa quando Corborus afunda ou emerge."
	L.burrow_message = "Corborus afundou!"
	L.burrow_warning = "Afundará em 5 seg!"
	L.emerge_message = "Corborus emergiu!"
	L.emerge_warning = "Emergirá em 5 seg!"
end

-- Throne of the Tides

L = BigWigs:NewBossLocale("Throne of the Tides Trash", "ptBR")
if L then
	L.nazjar_oracle = "Oráculo Naz'jar"
	L.vicious_snap_dragon = "Estalodraco Cruel"
	L.nazjar_sentinel = "Sentinela Naz'jar"
	L.nazjar_ravager = "Assoladora Naz'jar"
	L.nazjar_tempest_witch = "Bruxa da Tempestade Naz'jar"
	--L.faceless_seer = "Faceless Seer"
	L.faceless_watcher = "Vigia Sem-rosto"
	L.tainted_sentry = "Sentinela Maculada"

	--L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "ptBR")
if L then
	--L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	--L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

-- The Vortex Pinnacle

L = BigWigs:NewBossLocale("The Vortex Pinnacle Trash", "ptBR")
if L then
	L.armored_mistral = "Mistral Couraçado"
	L.gust_soldier = "Soldado Rajada"
	L.wild_vortex = "Vórtice Selvagem"
	L.lurking_tempest = "Tempesto Entocaiado"
	L.cloud_prince = "Príncipe das Nuvens"
	L.turbulent_squall = "Rajada Turbulenta"
	L.empyrean_assassin = "Assassino Empíreo"
	L.young_storm_dragon = "Dragão Jovem da Tempestade"
	L.executor_of_the_caliph = "Executor do Califa"
	L.temple_adept = "Adepto do Templo"
	L.servant_of_asaad = "Serviçal de Asaad"
	L.minister_of_air = "Ministro do Ar"
end

-- Well of Eternity

L = BigWigs:NewBossLocale("Well Of Eternity Trash", "ptBR")
if L then
	L.custom_on_autotalk_desc = "Instantaneamente seleciona a opção de conversa de Illidan."
end

-- Zul'Aman

L = BigWigs:NewBossLocale("Daakara", "ptBR")
if L then
	L[42594] = "Forma de Urso" -- short form for "Essence of the Bear"
	L[42607] = "Forma de Lince"
	L[42606] = "Forma de Águia"
	L[42608] = "Forma de Falcodrago"
end

L = BigWigs:NewBossLocale("Halazzi", "ptBR")
if L then
	L.spirit_message = "Fase Espiritual"
	L.normal_message = "Fase Normal"
end

L = BigWigs:NewBossLocale("Nalorakk", "ptBR")
if L then
	L.troll_message = "Forma de Troll"
	L.troll_trigger = "Abrir caminho para Nalorakk!"
end

-- Zul'Gurub

L = BigWigs:NewBossLocale("Jin'do the Godbreaker", "ptBR")
if L then
	L.barrier_down_message = "Barreira caiu, %d restando" -- short name for "Brittle Barrier" (97417)
end
