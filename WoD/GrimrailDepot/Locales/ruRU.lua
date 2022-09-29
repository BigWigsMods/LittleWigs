local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "ruRU")
if not L then return end
if L then
	L.dropped = "%s уронены!"
	L.add_trigger1 = "Зададим им жару!"
	L.add_trigger2 = "Не щадите их!"

	L.waves[1] = "1x Гром'карский подрывник, 1x Гром'карская опалительница"
	L.waves[2] = "1x Гром'карская опалительница, 1x Гром'карский гренадер"
	L.waves[3] = "Железный пехотинец"
	L.waves[4] = "2x Гром'карский подрывник"
	L.waves[5] = "Железный пехотинец"
	L.waves[6] = "2x Гром'карская опалительница"
	L.waves[7] = "Железный пехотинец"
	L.waves[8] = "1x Гром'карский подрывник, 1x Гром'карский гренадер"
	L.waves[9] = "3x Гром'карский подрывник, 1x Гром'карская опалительница"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "ruRU")
if L then
	L.grimrail_technician = "Техник Мрачных Путей"
	L.grimrail_overseer = "Надзиратель Мрачных Путей"
	L.gromkar_gunner = "Гром'карская опалительница"
	L.gromkar_cinderseer = "Гром'карская пророчица на пепле"
	L.gromkar_boomer = "Гром'карский подрывник"
	L.gromkar_hulk = "Гром'карский исполин"
	L.gromkar_far_seer = "Гром'карский ясновидящий"
	L.gromkar_captain = "Гром'карский капитан"
	L.grimrail_scout = "Разведчица Мрачных Путей"
end
