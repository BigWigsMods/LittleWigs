local L = BigWigs:NewBossLocale("The Slave Pens Trash", "deDE")
if not L then return end
if L then
	L.defender = "Verteidiger des Echsenkessels"
	L.enchantress = "Verzauberin des Echsenkessels"
	L.healer = "Schuppenheilerin des Echsenkessels"
	L.collaborator = "Kollaborateur des Echsenkessels"
	L.ray = "Rochen des Echsenkessels"
end

L = BigWigs:NewBossLocale("Ahune", "deDE")
if L then
	L.ahune = "Ahune"
	L.warmup_trigger = "Der Eisbrocken ist geschmolzen!"
end
