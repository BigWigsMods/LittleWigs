local L = BigWigs:NewBossLocale("Karazhan Trash", "ruRU")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "Авторазговор"
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Оперный зал: Злюкер"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Оперный зал: Однажды в Западном Крае"
	L.opera_hall_westfall_story_trigger = "Они родились по разные стороны Сторожевого холма."
	L.opera_hall_beautiful_beast_story_text = "Оперный зал: Красавица и Зверь"
	L.opera_hall_beautiful_beast_story_trigger = "Эта история о любви и гневе навсегда поставит точку в вопросе, обманчива ли красота."

	-- Return to Karazhan: Lower
	L.barnes = "Барнс"
	L.ghostly_philanthropist = "Бестелесный филантроп"
	L.skeletal_usher = "Гниющий билетер"
	L.spectral_attendant = "Призрачный смотритель"
	L.spectral_valet = "Призрачный служитель"
	L.spectral_retainer = "Призрачный эконом"
	L.phantom_guardsman = "Фантомный стражник"
	L.wholesome_hostess = "Благонравная горничная"
	L.reformed_maiden = "Исправившаяся дева"
	L.spectral_charger = "Призрачный конь"

	-- Return to Karazhan: Upper
	L.chess_event = "Шахматы"
	L.king = "Король"
end

L = BigWigs:NewBossLocale("Moroes", "ruRU")
if L then
	L.cc = "управление толпой"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "ruRU")
if L then
	L.name = "Ночная Погибель"
end
