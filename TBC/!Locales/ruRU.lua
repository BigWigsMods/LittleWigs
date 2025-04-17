-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "ruRU")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "ruRU")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	--L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "ruRU")
if L then
	L.mage_guard = "Маг-стражник Солнечного Клинка"
	L.magister = "Магистр Солнечного Клинка"
	L.keeper = "Хранитель Солнечного Клинка"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "ruRU")
if L then
	L.scavenger = "Эфириал-падальщик"
	L.priest = "Эфириал-жрец"
	L.nexus_terror = "Ужасень Нексуса"
	L.theurgist = "Эфириал-чудесник"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "ruRU")
if L then
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

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "ruRU")
if L then
	-- I knew the prince would be angry, but I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael'thas did not send you! Good... I'll just tell the prince you released the prisoners!
	--L.first_cell_trigger = "I have not been myself"
	-- Behold, yet another terrifying creature of incomprehensible power!
	--L.second_and_third_cells_trigger = "of incomprehensible power"
	-- Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!
	--L.fourth_cell_trigger = "Anarchy! Bedlam!"
	-- It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!
	--L.warmup_trigger = "the mighty Legion"

	--L.prison_cell = "Prison Cell"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "ruRU")
if L then
	L.entropic_eye = "Энтропический глаз"
	L.sightless_eye = "Незрячий глаз"
	L.soul_eater = "Эредераский пожиратель душ"
	L.temptress = "Сердитая искусительница"
	L.abyssal = "Чудовищный магматический инфернал"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "ruRU")
if L then
	--L.wave = "Wave Warnings"
	--L.wave_desc = "Announce approximate warning messages for the waves."

	L.medivh = "Медив"
	L.rift = "Портал времени"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "ruRU")
if L then
	L.despawn_message = "Скоро Призраки Хаоса исчезнут"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "ruRU")
if L then
	L.bossName = "Страж ворот Стальная Клешня"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "ruRU")
if L then
	L.bossName = "Страж ворот Точеный Нож"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "ruRU")
if L then
	L.fixate_desc = "Вынуждает заклинателя сосредоточить свое внимание на случайно выбранной цели."
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "ruRU")
if L then
	L.legionnaire = "Легионер клана Изувеченной Длани"
	L.brawler = "Буян из клана Изувеченной Длани"
	L.acolyte = "Послушник из клана Призрачной Луны"
	L.darkcaster = "Темный маг из клана Призрачной Луны"
	L.assassin = "Убийца из клана Изувеченной Длани"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "ruRU")
if L then
	L.defender = "Защитник резервуара Кривого Клыка"
	L.enchantress = "Чародейка резервуара Кривого Клыка"
	L.healer = "Целительница чешуи резервуара Кривого Клыка"
	L.collaborator = "Работяга резервуара Кривого Клыка"
	L.ray = "Скат резервуара Кривого Клыка"
end

L = BigWigs:NewBossLocale("Ahune", "ruRU")
if L then
	L.ahune = "Ахун"
	--L.warmup_trigger = "The Ice Stone has melted!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "ruRU")
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"
end
