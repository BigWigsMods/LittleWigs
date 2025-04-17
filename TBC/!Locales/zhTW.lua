-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "zhTW")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "zhTW")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	--L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "zhTW")
if L then
	--L.mage_guard = "Sunblade Mage Guard"
	--L.magister = "Sunblade Magister"
	--L.keeper = "Sunblade Keeper"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "zhTW")
if L then
	--L.scavenger = "Ethereal Scavenger"
	--L.priest = "Ethereal Priest"
	--L.nexus_terror = "Nexus Terror"
	--L.theurgist = "Ethereal Theurgist"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "zhTW")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."

	--L.incendiary_bombs = "Incendiary Bombs"
	--L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "zhTW")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	--L.warmup_trigger = "fetch water"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "zhTW")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	--L.warmup_trigger = "answer to Blackmoore"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "zhTW")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	--L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	--L.boss_warmup_trigger = "very existence!"
end

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "zhTW")
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

L = BigWigs:NewBossLocale("The Arcatraz Trash", "zhTW")
if L then
	--L.entropic_eye = "Entropic Eye"
	--L.sightless_eye = "Sightless Eye"
	--L.soul_eater = "Eredar Soul-Eater"
	--L.temptress = "Spiteful Temptress"
	--L.abyssal = "Gargantuan Abyssal"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "zhTW")
if L then
	--L.wave = "Wave Warnings"
	--L.wave_desc = "Announce approximate warning messages for the waves."

	L.medivh = "麦迪文" -- zhCN?
	--L.rift = "Time Rift"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhTW")
if L then
	L.despawn_message = "虚空怨灵召回，帕萨雷恩进入狂暴状态"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhTW")
if L then
	L.bossName = "看守者鐵手"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "zhTW")
if L then
	L.bossName = "看守者蓋洛奇歐"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "zhTW")
if L then
	L.fixate_desc = "使施法者鎖定一個隨機目標。"
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "zhTW")
if L then
	--L.legionnaire = "Shattered Hand Legionnaire"
	--L.brawler = "Shattered Hand Brawler"
	--L.acolyte = "Shadowmoon Acolyte"
	--L.darkcaster = "Shadowmoon Darkcaster"
	--L.assassin = "Shattered Hand Assassin"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "zhTW")
if L then
	--L.defender = "Coilfang Defender"
	--L.enchantress = "Coilfang Enchantress"
	--L.healer = "Coilfang Scale-Healer"
	--L.collaborator = "Coilfang Collaborator"
	--L.ray = "Coilfang Ray"
end

L = BigWigs:NewBossLocale("Ahune", "zhTW")
if L then
	--L.ahune = "Ahune"
	--L.warmup_trigger = "The Ice Stone has melted!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "zhTW")
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"
end
