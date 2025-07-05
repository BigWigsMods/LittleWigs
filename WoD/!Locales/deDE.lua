-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "deDE")
if not L then return end
if L then
	L.affliction = "Gebrechen"
	L.demonology = "Dämonologie"
	L.destruction = "Zerstörung"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "deDE")
if L then
	L.abyssal = "Teufelsgeborener Abyssal"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "deDE")
if L then
	L.bloodmaul_enforcer = "Vollstrecker der Blutschläger"
	L.bloodmaul_overseer = "Aufseher der Blutschläger"
	L.bloodmaul_warder = "Wächter der Blutschläger"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "deDE")
if L then
	L.dropped = "%s fallen gelassen!"
	L.add_trigger1 = "Zeigt es ihnen, Jungs!"
	L.add_trigger2 = "Immer feste drauf!"

	L.waves[1] = "1x Kanonenschütze der Grom'kar, 1x Schützin der Grom'kar"
	L.waves[2] = "1x Schützin der Grom'kar, 1x Grenadier der Grom'kar"
	L.waves[3] = "Eiserne Infanteristen"
	L.waves[4] = "2x Kanonenschütze der Grom'kar"
	L.waves[5] = "Eiserne Infanteristen"
	L.waves[6] = "2x Schützin der Grom'kar"
	L.waves[7] = "Eiserne Infanteristen"
	L.waves[8] = "1x Kanonenschütze der Grom'kar, 1x Grenadier der Grom'kar"
	L.waves[9] = "3x Kanonenschütze der Grom'kar, 1x Schützin der Grom'kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "deDE")
if L then
	L.grimrail_technician = "Techniker des Grimmgleises"
	L.grimrail_overseer = "Aufseher des Grimmgleises"
	L.gromkar_gunner = "Schützin der Grom'kar"
	L.gromkar_cinderseer = "Zunderhüterin der Grom'kar"
	L.gromkar_boomer = "Kanonenschütze der Grom'kar"
	L.gromkar_hulk = "Haudrauf der Grom'kar"
	L.gromkar_far_seer = "Scharfseher der Grom'kar"
	L.gromkar_captain = "Hauptmann der Grom'kar"
	L.grimrail_scout = "Späherin des Grimmgleises"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "deDE")
if L then
	L.sphere_fail_message = "Schild wurde entfernt - Bosse heilen sich"
end

L = BigWigs:NewBossLocale("Oshir", "deDE")
if L then
	L.freed = "Befreit nach %.1f Sek!"
	L.wolves = "Wölfe"
	L.rylak = "Rylak"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "deDE")
if L then
	L.gromkar_battlemaster = "Kampfmeister der Grom'kar"
	L.gromkar_flameslinger = "Flammenschützin der Grom'kar"
	L.gromkar_technician = "Techniker der Grom'kar"
	L.siegemaster_olugar = "Belagerungsmeister Olugar"
	L.pitwarden_gwarnok = "Grubenwächter Gwarnok"
	L.ogron_laborer = "Ogronarbeiter"
	L.gromkar_chainmaster = "Kettenmeister der Grom'kar"
	L.thunderlord_wrangler = "Bändiger der Donnerfürsten"
	L.rampaging_clefthoof = "Rasender Grollhuf"
	L.ironwing_flamespitter = "Flammenspucker der Eisenschwingen"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Bonemaw", "deDE")
if L then
	L.summon_worms = "Aaswürmer beschwören"
	L.summon_worms_desc = "Knochenschlund beschwört zwei Aaswürmer."
	L.summon_worms_trigger = "durchdringende Kreischen von Knochenschlund lockt die Aaswürmer in der Nähe an!"

	L.submerge = "Untertauchen"
	L.submerge_desc = "Knochenschlund taucht unter und positioniert sich neu."
	L.submerge_trigger = "zischt und zieht sich in die finsteren Tiefen zurück!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "deDE")
if L then
	L.shadowmoon_bonemender = "Knochenrenkerin des Schattenmondklans"
	L.reanimated_ritual_bones = "Reanimierte Ritualknochen"
	L.void_spawn = "Ausgeburt der Leere"
	L.shadowmoon_loyalist = "Getreue des Schattenmondklans"
	L.defiled_spirit = "Entweihter Geist"
	L.shadowmoon_dominator = "Beherrscher des Schattenmondklans"
	L.shadowmoon_exhumer = "Erweckerin des Schattenmondklans"
	L.exhumed_spirit = "Exhumierter Geist"
	L.monstrous_corpse_spider = "Monströse Leichenspinne"
	L.carrion_worm = "Aaswurm"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "deDE")
if L then
	L.solar_zealot = "Sonnenzelot"
	L.construct = "Schildkonstrukt der Himmelsnadel"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "deDE")
if L then
	L.energyStatus = "Eine Sphäre hat Bleichborke erreicht: %d%% Energie"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "deDE")
if L then
	L.dreadpetal = "Schreckensblüte"
	L.everbloom_naturalist = "Naturalist des Immergrünen Flors"
	L.everbloom_cultivator = "Kultivator des Immergrünen Flors"
	L.rockspine_stinger = "Felsstachelstecher"
	L.everbloom_mender = "Heiler des Immergrünen Flors"
	L.gnarlroot = "Knorrenwurzel"
	L.melded_berserker = "Befallener Berserker"
	L.twisted_abomination = "Verzerrte Monstrosität"
	L.infested_icecaller = "Infizierte Eisruferin"
	L.putrid_pyromancer = "Eitriger Pyromant"
	L.addled_arcanomancer = "Verwirrter Arkanomant"

	L.gate_open_desc = "Zeigt eine Leiste wann Untermagier Kesalon das Portal zu Yalnu öffnet."
	L.yalnu_warmup_trigger = "Das Portal ist verloren. Wir müssen diese Bestie aufhalten, bevor sie entkommt!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "deDE")
if L then
	L.counduitLeft = "%d |4Verbindung:Verbindungen; übrig"
end
