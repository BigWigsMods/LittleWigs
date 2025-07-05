-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "esMX")
if not L then return end
if L then
	L.affliction = "Aflicción"
	L.demonology = "Demonología"
	L.destruction = "Destrucción"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "esMX")
if L then
	L.abyssal = "Abisal vilificado"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "esMX")
if L then
	L.bloodmaul_enforcer = "Déspota Machacasangre"
	L.bloodmaul_overseer = "Sobrestante Machacasangre"
	L.bloodmaul_warder = "Depositario Machacasangre"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "esMX")
if L then
	--L.dropped = "%s dropped!"
	L.add_trigger1 = "¡Denles fuerte, muchachos!"
	L.add_trigger2 = "¡Hay que atacar con todo!"

	L.waves[1] = "1x Explotador Grom'kar, 1x Artillero Grom'kar"
	L.waves[2] = "1x Artillero Grom'kar, 1x Granadero Grom'kar"
	L.waves[3] = "Infantería de hierro"
	L.waves[4] = "2x Explotador Grom'kar"
	L.waves[5] = "Infantería de hierro"
	L.waves[6] = "2x Artillero Grom'kar"
	L.waves[7] = "Infantería de hierro"
	L.waves[8] = "1x Explotador Grom'kar, 1x Granadero Grom'kar"
	L.waves[9] = "3x Explotador Grom'kar, 1x Artillero Grom'kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "esMX")
if L then
	L.grimrail_technician = "Técnico Malavía"
	L.grimrail_overseer = "Sobrestante Malavía"
	L.gromkar_gunner = "Artillero Grom'kar"
	L.gromkar_cinderseer = "Vidente de las cenizas Grom'kar"
	L.gromkar_boomer = "Explotador Grom'kar"
	L.gromkar_hulk = "Mole Grom'kar"
	L.gromkar_far_seer = "Clarividente Grom'kar"
	L.gromkar_captain = "Capitana Grom'kar"
	L.grimrail_scout = "Exploradora Malavía"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "esMX")
if L then
	--L.sphere_fail_message = "Shield was broken - They're all healing :("
end

L = BigWigs:NewBossLocale("Oshir", "esMX")
if L then
	--L.freed = "Freed after %.1f sec!"
	L.wolves = "Lobos"
	L.rylak = "Rylak"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "esMX")
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

L = BigWigs:NewBossLocale("Bonemaw", "esMX")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Sumersión"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "esMX")
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

L = BigWigs:NewBossLocale("High Sage Viryx", "esMX")
if L then
	L.solar_zealot = "Fanático solar"
	L.construct = "Ensamblaje de protección del Trecho Celestial"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "esMX")
if L then
	--L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "esMX")
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

	--L.gate_open_desc = "Show a bar indicating when Undermage Kesalon will open the gate to Yalnu."
	--L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "esMX")
if L then
	--L.counduitLeft = "%d |4Conduit:Conduits; left"
end
