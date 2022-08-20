local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "deDE")
if not L then return end
if L then
	L.comma = ", "
	L.dropped = "%s fallen gelassen!"
	--L.add_trigger1 = "Let 'em have it, boys!"
	--L.add_trigger2 = "Give 'em all ya got."
end

L = BigWigs:NewBossLocale("Skylord Tovra", "deDE")
if L then
	L.rakun = "Rakun"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "deDE")
if L then
	L.grimrail_technician = "Techniker des Grimmgleises"
	L.grimrail_overseer = "Aufseher des Grimmgleises"
	L.gromkar_gunner = "Schützin der Grom'kar"
	L.gromkar_cinderseer = "Zunderhüterin der Grom'kar"
	L.gromkar_boomer = "Kanonenschütze der Grom'kar"
	L.gromkar_far_seer = "Scharfseher der Grom'kar"
	L.gromkar_captain = "Hauptmann der Grom'kar"
	L.grimrail_scout = "Späherin des Grimmgleises"
end
