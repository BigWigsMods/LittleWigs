local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "esMX")
if not L then return end
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
