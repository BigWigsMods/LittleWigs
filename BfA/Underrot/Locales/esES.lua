local L = BigWigs:NewBossLocale("Underrot Trash", "esES") or BigWigs:NewBossLocale("Underrot Trash", "esMX")
if not L then return end
if L then
	L.spirit = "Espíritu contaminado"
	L.priest = "Sacerdotisa de sangre devota"
	L.maggot = "Cresa fétida"
	L.matron = "Matriarca de sangre elegida"
	L.lasher = "Azotador malsano"
	L.bloodswarmer = "Enjambrista de sangre feral"
	L.rot = "Putrefacción viva"
	L.deathspeaker = "Portavoz de la muerte caído"
	L.defiler = "Profanador Jurasangre"
	L.corruptor = "Corruptor ignoto"
end

L = BigWigs:NewBossLocale("Infested Crawg", "esES") or BigWigs:NewBossLocale("Infested Crawg", "esMX")
if L then
	-- L.random_cast = "Charge or Indigestion"
	-- L.random_cast_desc = "The first cast after each Tantrum is random."
end
