-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "esES")
if not L then return end
if L then
	L.affliction = "Aflicción"
	L.demonology = "Demonología"
	L.destruction = "Destrucción"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "esES")
if L then
	L.abyssal = "Abisal vilificado"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "esES")
if L then
	L.bloodmaul_enforcer = "Déspota Machacasangre"
	L.bloodmaul_overseer = "Sobrestante Machacasangre"
	L.bloodmaul_warder = "Depositario Machacasangre"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "esES")
if L then
	L.dropped = "¡%s cae!"
	L.add_trigger1 = "¡A por ellos!"
	L.add_trigger2 = "Dadles con todo."

	L.waves[1] = "1x Dinamitero Grom'kar, 1x Artillera Grom'kar"
	L.waves[2] = "1x Artillera Grom'kar, 1x Granadero Grom'kar"
	L.waves[3] = "Infantería de la Horda de Hierro"
	L.waves[4] = "2x Dinamitero Grom'kar"
	L.waves[5] = "Infantería de la Horda de Hierro"
	L.waves[6] = "2x Artillera Grom'kar"
	L.waves[7] = "Infantería de la Horda de Hierro"
	L.waves[8] = "1x Dinamitero Grom'kar, 1x Granadero Grom'kar"
	L.waves[9] = "3x Dinamitero Grom'kar, 1x Artillera Grom'kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "esES")
if L then
	L.grimrail_technician = "Técnico Malavía"
	L.grimrail_overseer = "Sobrestante Malavía"
	L.gromkar_gunner = "Artillera Grom'kar"
	L.gromkar_cinderseer = "Vidente de las cenizas Grom'kar"
	L.gromkar_boomer = "Dinamitero Grom'kar"
	L.gromkar_hulk = "Mole Grom'kar"
	L.gromkar_far_seer = "Clarividente Grom'kar"
	L.gromkar_captain = "Capitana Grom'kar"
	L.grimrail_scout = "Exploradora Malavía"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "esES")
if L then
	L.sphere_fail_message = "El escudo se ha roto - Se están curando todos :("
end

L = BigWigs:NewBossLocale("Oshir", "esES")
if L then
	L.freed = "Liberado después de %.1f seg!"
	L.wolves = "Lobos"
	L.rylak = "Rylak"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "esES")
if L then
	L.gromkar_battlemaster = "Maestro de batalla Grom'kar"
	L.gromkar_flameslinger = "Exhaladora de llamas Grom'kar"
	L.gromkar_technician = "Técnico Grom'kar"
	L.siegemaster_olugar = "Maestro de asedio Olugar"
	L.pitwarden_gwarnok = "Celador de fosa Gwarnok"
	L.ogron_laborer = "Obrero ogron"
	L.gromkar_chainmaster = "Maestra de cadenas Grom'kar"
	L.thunderlord_wrangler = "Retador Señor del Trueno"
	L.rampaging_clefthoof = "Uñagrieta arrasador"
	L.ironwing_flamespitter = "Alahierro escupefuego"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Bonemaw", "esES")
if L then
	L.summon_worms = "Invoca Gusano carroñero"
	L.summon_worms_desc = "Quijahueso invoca dos Gusanos carroñeros."
	L.summon_worms_trigger = "¡Chirrido penetrante atrae Gusanos carroñeros cercanos!"

	L.submerge = "Sumersión"
	L.submerge_desc = "Quijahueso se sumerge y se reposiciona."
	L.submerge_trigger = "¡sisea, merodeando de nuevo en las profundidades sombrías!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "esES")
if L then
	L.shadowmoon_bonemender = "Ensalmadora de huesos Sombraluna"
	L.reanimated_ritual_bones = "Huesos de ritual reanimados"
	L.void_spawn = "Engendro del Vacío"
	L.shadowmoon_loyalist = "Leal Sombraluna"
	L.defiled_spirit = "Espíritu profanado"
	L.shadowmoon_dominator = "Dominador Sombraluna"
	L.shadowmoon_exhumer = "Exhumadora Sombraluna"
	L.exhumed_spirit = "Espíritu exhumado"
	L.monstrous_corpse_spider = "Araña cadáver monstruosa"
	L.carrion_worm = "Gusano carroñero"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "esES")
if L then
	L.solar_zealot = "Zelote solar"
	L.construct = "Ensamblaje de protección del Trecho Celestial"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "esES")
if L then
	L.energyStatus = "Un glóbulo llegó a Cortezamustia: %d%% energía"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "esES")
if L then
	L.dreadpetal = "Horripétalo"
	L.everbloom_naturalist = "Naturalista del Vergel Eterno"
	L.everbloom_cultivator = "Cultivador del Vergel Eterno"
	L.rockspine_stinger = "Aguijón Rocaspina"
	L.everbloom_mender = "Ensalmador del Vergel Eterno"
	L.gnarlroot = "Tuercerraíces"
	L.melded_berserker = "Rabioso fusionado"
	L.twisted_abomination = "Abominación retorcida"
	L.infested_icecaller = "Llamahielos infestada"
	L.putrid_pyromancer = "Piromántico pútrido"
	L.addled_arcanomancer = "Arcanomántico desconcertado"

	L.gate_open_desc = "Muestra una barra que indica cuándo el Mago menor Kesalon abrirá la puerta hacia Yalnu."
	L.yalnu_warmup_trigger = "¡Hemos perdido el portal! ¡No dejéis escapar a esta bestia!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "esES")
if L then
	L.counduitLeft = "%d |4Conducto:Conductos; restantes"
end
