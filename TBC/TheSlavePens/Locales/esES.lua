local L = BigWigs:NewBossLocale("The Slave Pens Trash", "esES") or BigWigs:NewBossLocale("The Slave Pens Trash", "esMX")
if not L then return end
if L then
	L.defender = "Defensor Colmillo Torcido"
	L.enchantress = "Encantadora Colmillo Torcido"
	L.healer = "Sanadora de escamas Colmillo Torcido"
	L.collaborator = "Colaborador Colmillo Torcido"
	L.ray = "Raya Colmillo Torcido"
end

L = BigWigs:NewBossLocale("Ahune", "esES") or BigWigs:NewBossLocale("Ahune", "esMX")
if L then
	L.ahune = "Ahune"
	--L.warmup_trigger = "The Ice Stone has melted!"
end
