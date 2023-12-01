local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "ruRU")
if not L then return end
if L then
	L.tugar = "Тугар Кровавый Тотем"
	L.jormog = "Йормог Чудовищный"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "ruRU")
if L then
	L.name = "Рейст Волшебное Копье"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.killed = "%s killed"

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "ruRU")
if L then
	L.name = "Верховный лорд Круул"
	L.inquisitor = "Инквизитор Варисс"
	L.velen = "Пророк Велен"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "ruRU")
if L then
	L.erdris = "Лорд Эрдрис Терновый Шип"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Зараженный восставший маг"
	L.soldier = "Зараженный восставший солдат"
	L.arbalest = "Зараженная восставшая лучница"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "ruRU")
if L then
	L.name = "Верховный маг Ксилем"
	L.corruptingShadows = "Гибельная тень"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "ruRU")
if L then
	L.name = "Агата"
	L.imp_servant = "Бес-прислужник"
	L.fuming_imp = "Тлеющий бес"
	L.levia = "Левия" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	-- L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	-- L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	-- L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.absorb = "Поглощение"
	L.stacks = "Стаки"
end

L = BigWigs:NewBossLocale("Sigryn", "ruRU")
if L then
	L.sigryn = "Сигрин"
	L.jarl = "Ярл Вельбранд"
	L.faljar = "Руновидец Фальяр"

	-- L.warmup_trigger = "What's this? The outsider has come to stop me?"

	L.absorb = "Поглощение"
end
