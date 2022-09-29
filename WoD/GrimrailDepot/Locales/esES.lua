local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "esES")
if not L then return end
if L then
	--L.dropped = "%s dropped!"
	L.add_trigger1 = "¡A por ellos!"
	L.add_trigger2 = "Dadles con todo."

	L.waves[1] = "1x Dinamitero Grom'kar, 1x Artillera Grom'kar"
	L.waves[2] = "1x Artillera Grom'kar, 1x Granadero Grom'kar"
	L.waves[3] = "Infantería de la Horda de Hierroo"
	L.waves[4] = "2x Dinamitero Grom'kar"
	L.waves[5] = "Infantería de la Horda de Hierroo"
	L.waves[6] = "2x Artillera Grom'kar"
	L.waves[7] = "Infantería de la Horda de Hierroo"
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
