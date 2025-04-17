-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "frFR")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "frFR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	--L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "frFR")
if L then
	L.mage_guard = "Garde mage lamesoleil"
	L.magister = "Magistère lamesoleil"
	L.keeper = "Gardien lamesoleil"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "frFR")
if L then
	L.scavenger = "Charognard éthérien"
	L.priest = "Prêtre éthérien"
	L.nexus_terror = "Terreur de nexus"
	L.theurgist = "Théurge éthérien"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "frFR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."

	--L.incendiary_bombs = "Incendiary Bombs"
	--L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "frFR")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	--L.warmup_trigger = "fetch water"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "frFR")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	--L.warmup_trigger = "answer to Blackmoore"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "frFR")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	--L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	--L.boss_warmup_trigger = "very existence!"
end

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "frFR")
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

L = BigWigs:NewBossLocale("The Arcatraz Trash", "frFR")
if L then
	L.entropic_eye = "Oeil d'entropie"
	L.sightless_eye = "Oeil sans-vue"
	L.soul_eater = "Mangeur d'âme érédar"
	L.temptress = "Tentatrice malveillante"
	L.abyssal = "Abyssal gargantuesque"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "frFR")
if L then
	--L.wave = "Wave Warnings"
	--L.wave_desc = "Announce approximate warning messages for the waves."

	L.medivh = "Medivh"
	L.rift = "Faille dans le temps"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "frFR")
if L then
	L.despawn_message = "Disparition des âmes en peine du Néant imminente"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "frFR")
if L then
	L.bossName = "Gardien de porte Main-en-Fer"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "frFR")
if L then
	L.bossName = "Gardien de porte Gyro-Meurtre"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "frFR")
if L then
	L.fixate_desc = "Le lanceur de sorts se concentre sur une cible aléatoire."
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "frFR")
if L then
	L.legionnaire = "Légionnaire de la Main-Brisée"
	L.brawler = "Bagarreur de la Main-Brisée"
	L.acolyte = "Acolyte ombrelune"
	L.darkcaster = "Invocateur noir ombrelune"
	L.assassin = "Assassin de la Main-Brisée"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "frFR")
if L then
	L.defender = "Défenseur de Glissecroc"
	L.enchantress = "Enchanteresse de Glissecroc"
	L.healer = "Soigne-écaille de Glissecroc"
	L.collaborator = "Collaborateur de Glissecroc"
	L.ray = "Raie de Glissecroc"
end

L = BigWigs:NewBossLocale("Ahune", "frFR")
if L then
	L.ahune = "Ahune"
	--L.warmup_trigger = "The Ice Stone has melted!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "frFR")
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"
end
