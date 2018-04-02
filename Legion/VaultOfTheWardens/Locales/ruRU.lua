local L = BigWigs:NewBossLocale("Cordana Felsong", "ruRU")
if not L then return end
if L then
	L.kick_combo = "Комбо удар"

	L.light_dropped = "%s выронил Свет."
	L.light_picked = "%s поднял Свет."

	L.warmup_text = "Кордана Оскверненная Песнь активна"
	L.warmup_trigger = "Я уже получила то, за чем пришла. Но осталась, чтобы покончить с вами… раз и навсегда!"
	L.warmup_trigger_2 = "И вы угодили в мою ловушку. Посмотрим, на что вы способны в темноте."
end

L = BigWigs:NewBossLocale("Glazer", "ruRU")
if L then
	--L.radiation_level = "%s: %d%%"
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "ruRU")
if L then
	--L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "ruRU")
if L then
	L.infester = "Скверноподданный заразитель"
	L.myrmidon = "Скверноподданный мирмидон"
	L.fury = "Зараженный Скверной яростный боец"
	--L.mother = "Foul Mother"
	L.illianna = "Иллиана Танцующая с Клинками"
	L.mendacius = "Повелитель ужаса Мендаций"
	L.grimhorn = "Злобнорог Поработитель"
end
