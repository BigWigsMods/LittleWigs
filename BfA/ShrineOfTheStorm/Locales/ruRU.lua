local L = BigWigs:NewBossLocale("Aqu'sirr", "ruRU")
if not L then return end
if L then
	L.warmup_trigger = "Как вы смеете осквернять мой храм своим присутствием?!"
end

L = BigWigs:NewBossLocale("Lord Stormsong", "ruRU")
if L then
	L.warmup_trigger_horde = "Чужаки?! Я отправлю ваши трупы в черную бездну! Вас ждут вечные страдания!"
	L.warmup_trigger_alliance = "Милорд, это безумие! Не отдавайте наши корабли силам зла!"
end

L = BigWigs:NewBossLocale("Shrine of the Storm Trash", "ruRU")
if L then
	L.templar = "Храмовник из Святилища Штормов"
	L.spiritualist = "Жрица моря - спиритуалистка"
	L.galecaller_apprentice = "Ученик призывательницы штормов"
	L.windspeaker = "Говорящая с ветрами Хелдис"
	L.ironhull_apprentice = "Ученик Айронхалла"
	L.runecarver = "Резчик рун Сорн"
	L.guardian_elemental = "Сторожевой элементаль"
	L.ritualist = "Глубоководный ритуалист"
	L.cultist = "Глубинный сектант"
	L.depthbringer = "Утонувший вестник глубин"
	L.living_current = "Живой поток"
	L.enforcer = "Жрец моря - каратель"
end
