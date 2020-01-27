local L = BigWigs:NewBossLocale("Underrot Trash", "ruRU")
if not L then return end
if L then
	-- L.custom_on_fixate_plates = "Thirst For Blood icon on Enemy Nameplate"
	-- L.custom_on_fixate_plates_desc = "Show an icon on the target nameplate that is fixating on you.\nRequires the use of Enemy Nameplates. This feature is currently only supported by KuiNameplates."

	L.spirit = "Оскверненный дух"
	L.priest = "Преданная жрица крови"
	L.maggot = "Смрадная личинка"
	L.matron = "Избранная кровавая матрона"
	L.lasher = "Больной плеточник"
	L.bloodswarmer = "Дикий кровавый роевик"
	L.rot = "Живая гниль"
	L.deathspeaker = "Падший вестник смерти"
	L.defiler = "Кровавый осквернитель"
	L.corruptor = "Безликий осквернитель"
end

L = BigWigs:NewBossLocale("Infested Crawg", "ruRU")
if L then
	L.random_cast = "Рывок или Несварение"
	L.random_cast_desc = "Первая способность после Припадка случайна."
end
