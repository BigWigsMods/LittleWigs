local L = BigWigs:NewBossLocale("Cordana Felsong", "ruRU")
if not L then return end
if L then
	L.kick_combo = "Комбо удар"

	L.light_dropped = "%s выронил Свет."
	L.light_picked = "%s поднял Свет."

	L.warmup_text = "Кордана Оскверненная Песнь активна"
	L.warmup_trigger = "Я уже получила то, за чем пришла. Но осталась, чтобы покончить с вами… раз и навсегда!"
	--L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "ruRU")
if L then
	L.infester = "Скверноподданный заразитель"
	L.illianna = "Иллиана Танцующая с Клинками"
	L.myrmidon = "Скверноподданный мирмидон"
	L.mendacius = "Повелитель ужаса Мендаций"
	L.fury = "Зараженный Скверной яростный боец"
	L.grimhorn = "Злобнорог Поработитель"
end
