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

	L.mug_of_mead = "Кружка меда"
	L.valarjar_thundercaller = "Валарьяр - призыватель молний"
	L.storm_drake = "Штормовой дракон"
	L.stormforged_sentinel = "Закаленный бурей страж"
	L.valarjar_runecarver = "Валарьяр - резчик рун"
	L.valarjar_mystic = "Валарьяр-мистик"
	L.valarjar_purifier = "Валарьяр-очиститель"
	L.valarjar_shieldmaiden = "Валарьяр - дева щита"
	L.valarjar_aspirant = "Валарьяр-претендентка"
	L.solsten = "Солстен"
	L.olmyr = "Олмир Просвещенный"
	L.valarjar_marksman = "Валарьяр-лучница"
	L.gildedfur_stag = "Золотистый олень"
	L.angerhoof_bull = "Сердитый бык"
	L.valarjar_trapper = "Валарьяр-зверолов"
	L.fourkings = "Четыре Короля"
end
