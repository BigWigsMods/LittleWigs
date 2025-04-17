-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "deDE")
if not L then return end
if L then
	L.energy_discharged = "%s beschworen" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "deDE")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	L.warmup_trigger = "Bildet Euch nichts ein!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "deDE")
if L then
	L.mage_guard = "Magierwache der Sonnenklingen"
	L.magister = "Magister der Sonnenklingen"
	L.keeper = "Bewahrer der Sonnenklingen"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "deDE")
if L then
	L.scavenger = "Astraler Strauchdieb"
	L.priest = "Astraler Priester"
	L.nexus_terror = "Nexusschrecken"
	L.theurgist = "Astraler Theurg"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "deDE")
if L then
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoptionen von Erozion, Thrall und Taretha."

	L.incendiary_bombs = "Brandbomben"
	L.incendiary_bombs_desc = "Eine Nachricht anzeigen wenn Brandbomben gelegt werden."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "deDE")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	L.warmup_trigger = "holt schnell"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "deDE")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	L.warmup_trigger = "Schwarzmoor Rede und Antwort stehen"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "deDE")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	L.trash_warmup_trigger = "lästigen Freunde"
	-- Enough, I will erase your very existence!
	L.boss_warmup_trigger = "Existenz auslöschen!"
end

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "deDE")
if L then
	-- I knew the prince would be angry, but I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael'thas did not send you! Good... I'll just tell the prince you released the prisoners!
	L.first_cell_trigger = "ich war nicht ich selbst"
	-- Behold, yet another terrifying creature of incomprehensible power!
	L.second_and_third_cells_trigger = "von unfassbarer Macht"
	-- Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!
	L.fourth_cell_trigger = "Anarchie! Chaos!"
	-- It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!
	L.warmup_trigger = "die mächtige Legion"

	L.prison_cell = "Gefängniszelle"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "deDE")
if L then
	L.entropic_eye = "Entropisches Auge"
	L.sightless_eye = "Blindes Auge"
	L.soul_eater = "Seelenfresser der Eredar"
	L.temptress = "Boshafte Verführerin"
	L.abyssal = "Riesengroßer Abyss"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "deDE")
if L then
	L.wave = "Wellenwarnungen"
	L.wave_desc = "Zeigt ungefähre Nachrichten für die Wellen an."

	L.medivh = "Medivh"
	L.rift = "Zeitriss"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "deDE")
if L then
	L.despawn_message = "Nethergespenster verschwinden bald"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "deDE")
if L then
	L.bossName = "Torwächter Eisenhand"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "deDE")
if L then
	L.bossName = "Torwächter Gyrotod"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "deDE")
if L then
	L.fixate_desc = "Lässt den Zaubernden sich auf ein zufälliges Ziel fixieren."
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "deDE")
if L then
	L.legionnaire = "Legionär der Zerschmetterten Hand"
	L.brawler = "Raufbold der Zerschmetterten Hand"
	L.acolyte = "Akolyth des Schattenmondklans"
	L.darkcaster = "Dunkelzauberer des Schattenmondklans"
	L.assassin = "Auftragsmörder der Zerschmetterten Hand"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "deDE")
if L then
	L.defender = "Verteidiger des Echsenkessels"
	L.enchantress = "Verzauberin des Echsenkessels"
	L.healer = "Schuppenheilerin des Echsenkessels"
	L.collaborator = "Kollaborateur des Echsenkessels"
	L.ray = "Rochen des Echsenkessels"
end

L = BigWigs:NewBossLocale("Ahune", "deDE")
if L then
	L.ahune = "Ahune"
	L.warmup_trigger = "Der Eisbrocken ist geschmolzen!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "deDE")
if L then
	L.mech_trigger = "Legt Sie tiefer, Jungs!"
end
