local L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "ruRU")
if not L then return end
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опций в диалогах с Эрозионом, Траллом и Таретой."

	L.incendiary_bombs = "Зажигательные бомбы"
	L.incendiary_bombs_desc = "Показывать сообщение, когда Зажигательная бомба заложена."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "ruRU")
if L then
	-- Эй, воды сюда, живо! Тушите огонь, пока вся крепость не сгорела! Ну быстрее же, будьте вы прокляты!
	L.warmup_trigger = "Тушите огонь"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "ruRU")
if L then
	-- Тралл! Ты ведь не думал, что в самом деле сможешь сбежать? Ты ответишь перед Блэкмуром, как и твои союзники... но сперва я позабавлюсь.
	L.warmup_trigger = "перед Блэкмуром"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "ruRU")
if L then
	-- А, вот и ты. Я надеялся решить эту проблему более изящно, но, похоже, открытого боя не избежать. У тебя нет будущего, Тралл. Так что, тебе и твоим назойливым друзьям придется умереть.
	L.trash_warmup_trigger = "назойливым друзьям"
	-- Довольно! От вас не останется и следа!
	L.boss_warmup_trigger = "не останется"
end

