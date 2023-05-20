local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "deDE")
if not L then return end
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
