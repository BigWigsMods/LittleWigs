-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "esMX")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "esMX")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	--L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "esMX")
if L then
	L.mage_guard = "Guardia mago Filosol"
	L.magister = "Magister Filosol"
	L.keeper = "Vigilante Filosol"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "esMX")
if L then
	L.scavenger = "Carroñero etéreo"
	L.priest = "Sacerdote etéreo"
	L.nexus_terror = "Terror de El Nexo"
	L.theurgist = "Teúrgo etéreo"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "esMX")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."

	--L.incendiary_bombs = "Incendiary Bombs"
	--L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "esMX")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	--L.warmup_trigger = "fetch water"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "esMX")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	--L.warmup_trigger = "answer to Blackmoore"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "esMX")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	--L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	--L.boss_warmup_trigger = "very existence!"
end

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "esMX")
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

L = BigWigs:NewBossLocale("The Arcatraz Trash", "esMX")
if L then
	L.entropic_eye = "Ojo entrópico"
	L.sightless_eye = "Ojo invidente"
	L.soul_eater = "Devoraalmas eredar"
	L.temptress = "Tentadora maliciosa"
	L.abyssal = "Abisal inmenso"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "esMX")
if L then
	--L.wave = "Wave Warnings"
	--L.wave_desc = "Announce approximate warning messages for the waves."

	L.medivh = "Medivh"
	L.rift = "Falla temporal"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "esMX")
if L then
	--L.despawn_message = "Nether Wraiths Despawning Soon"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "esMX")
if L then
	L.bossName = "Vigía de las puertas Manoyerro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "esMX")
if L then
	L.bossName = "Vigía de las puertas Giromata"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "esMX")
if L then
	L.fixate_desc = "Provoca que el taumaturgo se fije en un objetivo aleatorio."
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "esMX")
if L then
	L.legionnaire = "Legionario Mano Destrozada"
	L.brawler = "Combatiente Mano Destrozada"
	L.acolyte = "Acólito Sombraluna"
	L.darkcaster = "Taumaturgo oscuro Sombraluna"
	L.assassin = "Asesino Mano Destrozada"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "esMX")
if L then
	L.defender = "Defensor Colmillo Torcido"
	L.enchantress = "Encantadora Colmillo Torcido"
	L.healer = "Sanadora de escamas Colmillo Torcido"
	L.collaborator = "Colaborador Colmillo Torcido"
	L.ray = "Raya Colmillo Torcido"
end

L = BigWigs:NewBossLocale("Ahune", "esMX")
if L then
	L.ahune = "Ahune"
	--L.warmup_trigger = "The Ice Stone has melted!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "esMX")
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"
end
