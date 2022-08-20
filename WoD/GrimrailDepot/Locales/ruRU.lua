local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "ruRU")
if not L then return end
if L then
	L.comma = ", "
	L.dropped = "%s уронены!"
	--L.add_trigger1 = "Let 'em have it, boys!"
	--L.add_trigger2 = "Give 'em all ya got."
end

L = BigWigs:NewBossLocale("Skylord Tovra", "ruRU")
if L then
	L.rakun = "Ракун"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "ruRU")
if L then
	L.grimrail_technician = "Техник Мрачных Путей"
	L.grimrail_overseer = "Надзиратель Мрачных Путей"
	L.gromkar_gunner = "Гром'карская опалительница"
	L.gromkar_cinderseer = "Гром'карская пророчица на пепле"
	L.gromkar_boomer = "Гром'карский подрывник"
	L.gromkar_far_seer = "Гром'карский ясновидящий"
	L.gromkar_captain = "Гром'карский капитан"
	L.grimrail_scout = "Разведчица Мрачных Путей"
end
