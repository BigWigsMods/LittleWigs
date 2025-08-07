-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "frFR")
if not L then return end
if L then
	L.affliction = "Affliction"
	L.demonology = "Démonologie"
	L.destruction = "Destruction"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "frFR")
if L then
	L.abyssal = "Abyssal gangrelien"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "frFR")
if L then
	L.bloodmaul_enforcer = "Massacreur de la Masse-Sanglante"
	L.bloodmaul_overseer = "Surveillant de la Masse-Sanglante"
	L.bloodmaul_warder = "Gardien de la Masse-Sanglante"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "frFR")
if L then
	L.dropped = "%s lâché !"
	L.add_trigger1 = "Montrez-leur qui vous êtes, les gars !"
	L.add_trigger2 = "Donnez-leur tout ce que vous avez."

	L.waves[1] = "1x Boumeur grom’kar, 1x Mitrailleur grom’kar"
	L.waves[2] = "1x Mitrailleur grom’kar, 1x Grenadier grom’kar"
	L.waves[3] = "Soldat d’infanterie de Fer"
	L.waves[4] = "2x Boumeur grom’kar"
	L.waves[5] = "Soldat d’infanterie de Fer"
	L.waves[6] = "2x Mitrailleur grom’kar"
	L.waves[7] = "Soldat d’infanterie de Fer"
	L.waves[8] = "1x Boumeur grom’kar, 1x Grenadier grom’kar"
	L.waves[9] = "3x Boumeur grom’kar, 1x Mitrailleur grom’kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "frFR")
if L then
	L.grimrail_technician = "Technicien de Tristerail"
	L.grimrail_overseer = "Surveillant de Tristerail"
	L.gromkar_gunner = "Mitrailleur grom’kar"
	L.gromkar_cinderseer = "Voyant-de-braise grom’kar"
	L.gromkar_boomer = "Boumeur grom’kar"
	L.gromkar_hulk = "Butor grom’kar"
	L.gromkar_far_seer = "Long-voyant grom’kar"
	L.gromkar_captain = "Capitaine grom’kar"
	L.grimrail_scout = "Eclaireuse de Tristerail"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "frFR")
if L then
	L.sphere_fail_message = "Bouclier est cassé- Ils se soignet tous :("
end

L = BigWigs:NewBossLocale("Oshir", "frFR")
if L then
	L.freed = "Libéré après %.1f sec !"
	L.wolves = "Loups"
	L.rylak = "Rylak"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "frFR")
if L then
	L.gromkar_battlemaster = "Maître de guerre grom'kar"
	L.gromkar_flameslinger = "Jette-flamme grom’kar"
	L.gromkar_technician = "Technicien grom’kar"
	L.siegemaster_olugar = "Maître de siège Olugar"
	L.pitwarden_gwarnok = "Gardefosse Gwarnok"
	L.ogron_laborer = "Travailleur ogron"
	L.gromkar_chainmaster = "Maître-chaînes grom’kar"
	L.thunderlord_wrangler = "Querelleur sire-tonnerre"
	L.rampaging_clefthoof = "Sabot-fourchu enragé"
	L.ironwing_flamespitter = "Cracheur de flammes aile-de-fer"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Bonemaw", "frFR")
if L then
	L.summon_worms = "Invocation ver putride"
	L.summon_worms_desc = "Ossegueule invoque deux vers putrides."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Submerger"
	L.submerge_desc = "Ossegueule submerge et se repositionne."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "frFR")
if L then
	L.shadowmoon_bonemender = "Répare-os ombrelune"
	L.reanimated_ritual_bones = "Ossements rituels ranimés"
	L.void_spawn = "Rejeton du Vide"
	L.shadowmoon_loyalist = "Loyaliste ombrelune"
	L.defiled_spirit = "Esprit profané"
	L.shadowmoon_dominator = "Dominateur ombrelune"
	L.shadowmoon_exhumer = "Exhumeuse d’âmes ombrelune"
	L.exhumed_spirit = "Esprit exhumé"
	L.monstrous_corpse_spider = "Araignée nécrophage monstrueuse"
	L.carrion_worm = "Ver putride"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "frFR")
if L then
	L.solar_zealot = "Zélote solaire"
	L.construct = "Assemblage-bouclier d’Orée-du-Ciel"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "frFR")
if L then
	L.energyStatus = "Un globule a atteint Fanécorce : %d%% énergie"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "frFR")
if L then
	L.dreadpetal = "Pétaleffroi"
	L.everbloom_naturalist = "Naturaliste de la Flore éternelle"
	L.everbloom_cultivator = "Cultivateur de la Flore éternelle"
	L.rockspine_stinger = "Aiguillonneur épine-rocheuse"
	L.everbloom_mender = "Soigneur de la Flore éternelle"
	L.gnarlroot = "Racine-Noueuse"
	L.melded_berserker = "Berserker assimilé"
	L.twisted_abomination = "Abomination distordue"
	L.infested_icecaller = "Mandeglace infesté"
	L.putrid_pyromancer = "Pyromancien putride"
	L.addled_arcanomancer = "Arcanomancien perturbé"

	L.gate_open_desc = "Affiche une barre indiquant lorsque le Sous-mage Kesalon ouvrira la porter vers Yalnu."
	--L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "frFR")
if L then
	L.counduitLeft = "Il reste %d |4conduit:conduits;"
end
