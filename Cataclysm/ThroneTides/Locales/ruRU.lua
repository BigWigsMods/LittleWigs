local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "ruRU")
if not L then return end
if L then
	L.nazjar_oracle = "Оракул леди Наз'жар"
	L.vicious_snap_dragon = "Злобный морской варан"
	L.nazjar_sentinel = "Часовой Леди Наз'жар"
	L.nazjar_ravager = "Опустошительница леди Наз'жар"
	L.nazjar_tempest_witch = "Ведьма бурь Леди Наз'жар"
	L.faceless_seer = "Безликий провидец"
	L.faceless_watcher = "Безликий дозорный"
	L.tainted_sentry = "Опороченный часовой"

	--L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "ruRU")
if L then
	--L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	--L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

L = BigWigs:NewBossLocale("Ozumat", "ruRU")
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опции запуска боя в диалоге."
end
