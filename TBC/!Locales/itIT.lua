-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "itIT")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "itIT")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	--L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "itIT")
if L then
	L.mage_guard = "Guardia Magica Lamasole"
	L.magister = "Magistro Lamasole"
	L.keeper = "Guardiano Lamasole"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "itIT")
if L then
	L.scavenger = "Raccattatore Etereo"
	L.priest = "Sacerdote Etereo"
	L.nexus_terror = "Terrore del Nexus"
	L.theurgist = "Teurgo Etereo"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "itIT")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."

	--L.incendiary_bombs = "Incendiary Bombs"
	--L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "itIT")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	--L.warmup_trigger = "fetch water"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "itIT")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	--L.warmup_trigger = "answer to Blackmoore"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "itIT")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	--L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	--L.boss_warmup_trigger = "very existence!"
end

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "itIT")
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

L = BigWigs:NewBossLocale("The Arcatraz Trash", "itIT")
if L then
	L.entropic_eye = "Occhio Entropico"
	L.sightless_eye = "Occhio Cieco"
	L.soul_eater = "Mangiatore di Anime Eredar"
	L.temptress = "Tentatrice Adirata"
	L.abyssal = "Abissale Gigantesco"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "itIT")
if L then
	--L.wave = "Wave Warnings"
	--L.wave_desc = "Announce approximate warning messages for the waves."

	L.medivh = "Medivh"
	L.rift = "Fenditura del Tempo"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "itIT")
if L then
	--L.despawn_message = "Nether Wraiths Despawning Soon"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "itIT")
if L then
	L.bossName = "Guardiano del Portale Mandiferro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "itIT")
if L then
	L.bossName = "Guardiano del Portale Giro-Morte"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "itIT")
if L then
	L.fixate_desc = "Induce l'incantatore a prendere di mira un bersaglio casuale."
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "itIT")
if L then
	L.legionnaire = "Legionario Manomozza"
	L.brawler = "Attaccabrighe Manomozza"
	L.acolyte = "Accolito Torvaluna"
	L.darkcaster = "Mago Oscuro Torvaluna"
	L.assassin = "Assassino Manomozza"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "itIT")
if L then
	L.defender = "Difensore Spiraguzza"
	L.enchantress = "Incantatrice Spiraguzza"
	L.healer = "Guaritrice di Scaglie Spiraguzza"
	L.collaborator = "Collaboratore Spiraguzza"
	L.ray = "Manta Spiraguzza"
end

L = BigWigs:NewBossLocale("Ahune", "itIT")
if L then
	L.ahune = "Ahune"
	--L.warmup_trigger = "The Ice Stone has melted!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "itIT")
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"
end
