local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "ruRU")
if not L then return end
if L then
	L.zophex_warmup_trigger = "Сдавайте... контрабанду."
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "ruRU")
if L then
	L.achillite_warmup_trigger = "Докучают разъяренные звери? У нас есть решение!"
	L.venza_goldfuse_warmup_trigger = "Вот мой шанс! Топор будет моим!"
end

L = BigWigs:NewBossLocale("Myza's Oasis", "ruRU")
if L then
	-- L.add_wave_killed = "Add wave killed (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "ruRU")
if L then
	L.menagerie_warmup_trigger = "А теперь лот, которого все ждали! Топор, якобы проклятый демонами – Грань Забвения!"
	L.soazmi_warmup_trigger = "Прости нас за вторжение, Со'лея. Кажется, сейчас не самое подходящее время."
	--L.trading_game = "Trading Game"
	--L.trading_game_desc = "Alerts with the right password during the Trading Game."
	L.custom_on_autotalk = "Авторазговор"
	--L.custom_on_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	--[[L.password_triggers = {
		["Ivory Shell"] = true,
		["Sapphire Oasis"] = true,
		["Jade Palm"] = true,
		["Golden Sands"] = true,
		["Amber Sunset"] = true,
		["Emerald Ocean"] = true,
		["Ruby Gem"] = true,
		["Pewter Stone"] = true,
		["Pale Flower"] = true,
		["Crimson Knife"] = true
	}]]--

	L.interrogation_specialist = "Специалист по допросу"
	L.portalmancer_zohonn = "Заклинатель порталов Зо'хонн"
	L.armored_overseer_tracker_zokorss = "Тяжелый смотритель / Следопыт Зо'корсс"
	L.tracker_zokorss = "Следопыт Зо'корсс"
	L.ancient_core_hound = "Древняя гончая недр"
	L.enraged_direhorn = "Разъяренный дикорог"
	L.cartel_muscle = "Громила из картеля"
	L.cartel_smuggler = "Контрабандист из картеля"
	L.support_officer = "Офицер поддержки"
	L.defective_sorter = "Дефективный сортировщик"
	L.market_peacekeeper = "Тазавешский хранитель порядка"
	L.veteran_sparkcaster = "Опытный заклинатель искр"
	L.commerce_enforcer = "Охранитель коммерции"
	L.commerce_enforcer_commander_zofar = "Охранитель коммерции / Командир Зо'фар"
	L.commander_zofar = "Командир Зо'фар"

	L.murkbrine_scalebinder = "Лататель чешуи из племени Соленой Хмари"
	L.murkbrine_shellcrusher = "Крушитель панцирей из племени Соленой Хмари"
	L.coastwalker_goliath = "Береговой голиаф"
	L.stormforged_guardian = "Бурекованый страж"
	L.burly_deckhand = "Дюжий матрос"
	L.adorned_starseer = "Нарядный звездочет"
	L.focused_ritualist = "Настойчивый ритуалист"
	L.devoted_accomplice = "Усердный подручный"
end
