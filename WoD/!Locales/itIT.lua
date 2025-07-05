-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "itIT")
if not L then return end
if L then
	L.affliction = "Afflizione"
	L.demonology = "Demonologia"
	L.destruction = "Distruzione"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "itIT")
if L then
	L.abyssal = "Abissale della Stirpe Vile"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "itIT")
if L then
	L.bloodmaul_enforcer = "Scagnozzo Magliorosso"
	L.bloodmaul_overseer = "Sovrintendente Magliorosso"
	L.bloodmaul_warder = "Custode Magliorosso"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "itIT")
if L then
	--L.dropped = "%s dropped!"
	L.add_trigger1 = "Facciamogliela vedere!"
	L.add_trigger2 = "Fate del vostro meglio!"

	L.waves[1] = "1x Bombarolo Grom'kar, 1x Artigliere Grom'kar"
	L.waves[2] = "1x Artigliere Grom'kar, 1x Granatiere Grom'kar"
	L.waves[3] = "Gregario di Ferro"
	L.waves[4] = "2x Bombarolo Grom'kar"
	L.waves[5] = "Gregario di Ferro"
	L.waves[6] = "2x Artigliere Grom'kar"
	L.waves[7] = "Gregario di Ferro"
	L.waves[8] = "1x Bombarolo Grom'kar, 1x Granatiere Grom'kar"
	L.waves[9] = "3x Bombarolo Grom'kar, 1x Artigliere Grom'kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "itIT")
if L then
	L.grimrail_technician = "Tecnico del Frecciacupa"
	L.grimrail_overseer = "Sovrintendente del Frecciacupa"
	L.gromkar_gunner = "Artigliere Grom'kar"
	L.gromkar_cinderseer = "Veggente delle Braci Grom'kar"
	L.gromkar_boomer = "Bombarolo Grom'kar"
	L.gromkar_hulk = "Energumeno Grom'kar"
	L.gromkar_far_seer = "Chiaroveggente Grom'kar"
	L.gromkar_captain = "Capitano Grom'kar"
	L.grimrail_scout = "Esploratore del Frecciacupa"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "itIT")
if L then
	--L.sphere_fail_message = "Shield was broken - They're all healing :("
end

L = BigWigs:NewBossLocale("Oshir", "itIT")
if L then
	--L.freed = "Freed after %.1f sec!"
	L.wolves = "Lupi"
	L.rylak = "Rylak"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "itIT")
if L then
	L.gromkar_battlemaster = "Maestro di Guerra Grom'kar"
	L.gromkar_flameslinger = "Scagliafiamme Grom'kar"
	L.gromkar_technician = "Tecnico Grom'kar"
	L.siegemaster_olugar = "Maestro d'Assedio Olugar"
	L.pitwarden_gwarnok = "Custode della Fossa Gwarnok"
	L.ogron_laborer = "Bracciante Ogron"
	L.gromkar_chainmaster = "Aguzzino Grom'kar"
	L.thunderlord_wrangler = "Mandriano Spaccatuono"
	L.rampaging_clefthoof = "Mammuceronte Sfrenato"
	L.ironwing_flamespitter = "Sputafiamme Aladura"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Bonemaw", "itIT")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Immersione"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "itIT")
if L then
	L.shadowmoon_bonemender = "Curaossa Torvaluna"
	L.reanimated_ritual_bones = "Scheletro Rituale Rianimato"
	L.void_spawn = "Creatura del Vuoto"
	L.shadowmoon_loyalist = "Lealista Torvaluna"
	L.defiled_spirit = "Spirito Profanato"
	L.shadowmoon_dominator = "Dominatore di Torvaluna"
	L.shadowmoon_exhumer = "Esumatore Torvaluna"
	L.exhumed_spirit = "Spirito Riesumato"
	L.monstrous_corpse_spider = "Ragno Cadaverico Mostruoso"
	L.carrion_worm = "Verme Carogna"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "itIT")
if L then
	L.solar_zealot = "Zelota del Sole"
	L.construct = "Costrutto dello Scudo di Vetta dei Cieli"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "itIT")
if L then
	--L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "itIT")
if L then
	L.dreadpetal = "Petalotruce"
	L.everbloom_naturalist = "Naturalista di Verdeterno"
	L.everbloom_cultivator = "Coltivatore di Verdeterno"
	L.rockspine_stinger = "Pungitore Spinacoriacea"
	L.everbloom_mender = "Guaritore di Verdeterno"
	L.gnarlroot = "Torciradice"
	L.melded_berserker = "Berserker Ibrido"
	L.twisted_abomination = "Abominio Corrotto"
	L.infested_icecaller = "Invocatore del Ghiaccio Infestato"
	L.putrid_pyromancer = "Piromante Putrido"
	L.addled_arcanomancer = "Arcanomante Confuso"

	--L.gate_open_desc = "Show a bar indicating when Undermage Kesalon will open the gate to Yalnu."
	--L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "itIT")
if L then
	--L.counduitLeft = "%d |4Conduit:Conduits; left"
end
