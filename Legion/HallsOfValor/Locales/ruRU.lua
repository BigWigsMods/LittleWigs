local L = BigWigs:NewBossLocale("Odyn", "ruRU")
if not L then return end
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опции запуска боя в диалоге."

	L.gossip_available = "Разговор доступен"
	L.gossip_trigger = "Удивительно! Я не верил, что кто-то может сравниться с валарьярами... Но вы доказали, что это возможно."

	L[197963] = "|cFF800080Право Верх|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500Право Низ|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00Лево Низ|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FFЛево Верх|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000Верх|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "ruRU")
if L then
	L.warmup_text = "Король-бог Сковальд активен"
	L.warmup_trigger = "Сковальд, эти герои завладели Эгидой по праву. Уже поздно что-либо оспаривать."
	L.warmup_trigger_2 = "Или эти псевдогерои сами отдадут Эгиду... Или я вырву ее из их мертвых рук!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "ruRU")
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опций в диалогах."

	L.thundercaller = "Валарьяр - призыватель молний"
	L.drake = "Штормовой дракон"
	L.sentinel = "Закаленный бурей страж"
	L.mystic = "Валарьяр-мистик"
	L.purifier = "Валарьяр-очиститель"
	L.shieldmaiden = "Валарьяр - дева щита"
	L.aspirant = "Валарьяр-претендентка"
	L.solsten = "Солстен"
	L.olmyr = "Олмир Просвещенный"
	L.marksman = "Валарьяр-лучница"
	L.angerhoof = "Сердитый бык"
	L.trapper = "Валарьяр-зверолов"
	L.fourkings = "Четыре Короля"
end
