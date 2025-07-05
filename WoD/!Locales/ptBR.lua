-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "ptBR")
if not L then return end
if L then
	L.affliction = "Suplício"
	L.demonology = "Demonologia"
	L.destruction = "Destruição"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "ptBR")
if L then
	L.abyssal = "Abissal Vilanesco"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "ptBR")
if L then
	L.bloodmaul_enforcer = "Impositor do Malho Sangrento"
	L.bloodmaul_overseer = "Supervisor do Malho Sangrento"
	L.bloodmaul_warder = "Guardião do Malho Sangrento"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "ptBR")
if L then
	L.dropped = "%s soltou-se!"
	L.add_trigger1 = "Chumbo neles, rapaziada!"
	L.add_trigger2 = "Quero ver força total."

	L.waves[1] = "1x Detonador Grom'kar, 1x Artilheiro Grom'kar"
	L.waves[2] = "1x Artilheiro Grom'kar, 1x Granadeiro Grom'kar"
	L.waves[3] = "Infantaria de Ferro"
	L.waves[4] = "2x Detonador Grom'kar"
	L.waves[5] = "Infantaria de Ferro"
	L.waves[6] = "2x Artilheiro Grom'kar"
	L.waves[7] = "Infantaria de Ferro"
	L.waves[8] = "1x Detonador Grom'kar, 1x Granadeiro Grom'kar"
	L.waves[9] = "3x Detonador Grom'kar, 1x Artilheiro Grom'kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "ptBR")
if L then
	L.grimrail_technician = "Técnico do Carrilcruel"
	L.grimrail_overseer = "Supervisor do Carrilcruel"
	L.gromkar_gunner = "Artilheira Grom'kar"
	L.gromkar_cinderseer = "Mirabrasa Grom'kar"
	L.gromkar_boomer = "Detonador Grom'kar"
	L.gromkar_hulk = "Grandalhão de Grom'kar"
	L.gromkar_far_seer = "Clarividente Grom'kar"
	L.gromkar_captain = "Capitã Grom'kar"
	L.grimrail_scout = "Batedora do Carrilcruel"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "ptBR")
if L then
	L.sphere_fail_message = "Escudo foi removida - Eles estão todos se curando :("
end

L = BigWigs:NewBossLocale("Oshir", "ptBR")
if L then
	L.freed = "Libertado após %.1f seg!"
	L.wolves = "Lobos"
	L.rylak = "Rylak"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "ptBR")
if L then
	L.gromkar_battlemaster = "Mestre de Batalha Grom'kar"
	L.gromkar_flameslinger = "Atira-chamas Grom'kar"
	L.gromkar_technician = "Técnico Grom'kar"
	L.siegemaster_olugar = "Mestre de Cerco Olugar"
	L.pitwarden_gwarnok = "Guarda-fossso Gwarnok"
	L.ogron_laborer = "Trabalhador Ogron"
	L.gromkar_chainmaster = "Mestre das Correntes Grom'kar"
	L.thunderlord_wrangler = "Domador do Senhor do Trovão"
	L.rampaging_clefthoof = "Fenoceronte Furioso"
	L.ironwing_flamespitter = "Cospe-chamas Asaférrea"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Bonemaw", "ptBR")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Submergir"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "ptBR")
if L then
	L.shadowmoon_bonemender = "Cola-osso da Lua Negra"
	L.reanimated_ritual_bones = "Ossos do Ritual Reanimados"
	L.void_spawn = "Rebento do Caos"
	L.shadowmoon_loyalist = "Legalista da Lua Negra"
	L.defiled_spirit = "Espírito Profanado"
	L.shadowmoon_dominator = "Dominador da Lua Negra"
	L.shadowmoon_exhumer = "Exumadora da Lua Negra"
	L.exhumed_spirit = "Espírito Exumado"
	L.monstrous_corpse_spider = "Aranha Carniceira Monstruosa"
	L.carrion_worm = "Verme Carniceiro"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "ptBR")
if L then
	L.solar_zealot = "Zelote Solar"
	L.construct = "Constructo-escudo de Beira-céu"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "ptBR")
if L then
	L.energyStatus = "Um glóbulo alcançou Cascasseca: %d%% energia"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "ptBR")
if L then
	L.dreadpetal = "Medônia"
	L.everbloom_naturalist = "Naturalista de Floretérnia"
	L.everbloom_cultivator = "Cultivador de Floretérnia"
	L.rockspine_stinger = "Aguilhoador Costapedra"
	L.everbloom_mender = "Reparador de Floretérnia"
	L.gnarlroot = "Rugirraiz"
	L.melded_berserker = "Berserk"
	L.twisted_abomination = "Abominação Pervertida"
	L.infested_icecaller = "Chamagelo Infestada"
	L.putrid_pyromancer = "Piromante Podre"
	L.addled_arcanomancer = "Arcanomante Atordoado"

	--L.gate_open_desc = "Show a bar indicating when Undermage Kesalon will open the gate to Yalnu."
	--L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "ptBR")
if L then
	L.counduitLeft = "%d |4Conduit:Conduits; faltando"
end
