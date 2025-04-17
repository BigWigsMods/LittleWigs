-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "koKR")
if not L then return end
if L then
	L.energy_discharged = "%s 소환됨" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "koKR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	--L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "koKR")
if L then
	L.mage_guard = "태양칼날단 마법수호병"
	L.magister = "태양칼날단 마법학자"
	L.keeper = "태양칼날단 수호자"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "koKR")
if L then
	L.scavenger = "에테리얼 도굴꾼"
	L.priest = "에테리얼 사제"
	L.nexus_terror = "공포의 결정체"
	L.theurgist = "에테리얼 사술사"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "koKR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."

	--L.incendiary_bombs = "Incendiary Bombs"
	--L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "koKR")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	--L.warmup_trigger = "fetch water"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "koKR")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	--L.warmup_trigger = "answer to Blackmoore"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "koKR")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	--L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	--L.boss_warmup_trigger = "very existence!"
end

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "koKR")
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

L = BigWigs:NewBossLocale("The Arcatraz Trash", "koKR")
if L then
	L.entropic_eye = "혼돈의 눈"
	L.sightless_eye = "보이지 않는 눈"
	L.soul_eater = "에레다르 영혼사냥꾼"
	L.temptress = "원한의 요녀"
	L.abyssal = "거대한 심연"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "koKR")
if L then
	--L.wave = "Wave Warnings"
	--L.wave_desc = "Announce approximate warning messages for the waves."

	L.medivh = "메디브"
	L.rift = "시간의 균열"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "koKR")
if L then
	L.despawn_message = "잠시 후 황천의 망령 사라짐"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "koKR")
if L then
	L.bossName = "문지기 무쇠주먹"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "koKR")
if L then
	L.bossName = "문지기 회전톱날"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "koKR")
if L then
	L.fixate_desc = "무작위 대상에게 시선을 고정합니다."
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "koKR")
if L then
	L.legionnaire = "으스러진 손 군단병"
	L.brawler = "으스러진 손 투사"
	L.acolyte = "어둠달 수행사제"
	L.darkcaster = "어둠달 암흑술사"
	L.assassin = "으스러진 손 암살자"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "koKR")
if L then
	L.defender = "갈퀴송곳니 파수병"
	L.enchantress = "갈퀴송곳니 요술사"
	L.healer = "갈퀴송곳니 치유사"
	L.collaborator = "갈퀴송곳니 공모자"
	L.ray = "갈퀴송곳니 가오리"
end

L = BigWigs:NewBossLocale("Ahune", "koKR")
if L then
	L.ahune = "아훈"
	--L.warmup_trigger = "The Ice Stone has melted!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "koKR")
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"
end
