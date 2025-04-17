-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "ptBR")
if not L then return end
if L then
	L.energy_discharged = "%s descarregado" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "ptBR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	L.warmup_trigger = "Não fiquem aí, com essa cara de arrogância!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "ptBR")
if L then
	L.mage_guard = "Guarda Mago Gumélion"
	L.magister = "Magíster Gumélion"
	L.keeper = "Guardião Gumélion"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "ptBR")
if L then
	L.scavenger = "Forrageador Etéreo"
	L.priest = "Sacerdote Etéreo"
	L.nexus_terror = "Terror do Nexus"
	L.theurgist = "Teurgo Etéreo"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "ptBR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."

	--L.incendiary_bombs = "Incendiary Bombs"
	--L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "ptBR")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	--L.warmup_trigger = "fetch water"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "ptBR")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	--L.warmup_trigger = "answer to Blackmoore"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "ptBR")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	--L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	--L.boss_warmup_trigger = "very existence!"
end

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "ptBR")
if L then
	-- I knew the prince would be angry, but I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael'thas did not send you! Good... I'll just tell the prince you released the prisoners!
	L.first_cell_trigger = "Eu não fui eu mesmo"
	-- Behold, yet another terrifying creature of incomprehensible power!
	L.second_and_third_cells_trigger = "de poder incompreensível"
	-- Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!
	L.fourth_cell_trigger = "Anarquia! Tumulto!"
	-- It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!
	L.warmup_trigger = "a poderosa Legião"

	L.prison_cell = "Cela da Prisão"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "ptBR")
if L then
	L.entropic_eye = "Olho Entrópico"
	L.sightless_eye = "Olho Cego"
	L.soul_eater = "Devorador de Almas Eredar"
	L.temptress = "Tentadora Rancorosa"
	L.abyssal = "Abissal Gigantesco"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "ptBR")
if L then
	L.wave = "Avisos de Onda"
	L.wave_desc = "Anuncia mensagens de aviso da aproximação das ondas."

	L.medivh = "Medivh"
	L.rift = "Fenda Temporal"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "ptBR")
if L then
	L.despawn_message = "Aparições Etéreas desaparecendo em breve"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "ptBR")
if L then
	L.bossName = "Vigia do Portal Mão-de-ferro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "ptBR")
if L then
	L.bossName = "Vigia do Portal Matagiros"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "ptBR")
if L then
	L.fixate_desc = "Faz com que o lançador fixe a atenção em um alvo aleatório."
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "ptBR")
if L then
	L.legionnaire = "Legionário da Mão Despedaçada"
	L.brawler = "Brigão da Mão Despedaçada"
	L.acolyte = "Acólito da Lua Negra"
	L.darkcaster = "Taumaturgo da Lua Negra"
	L.assassin = "Assassino da Mão Despedaçada"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "ptBR")
if L then
	L.defender = "Defensor Presacurva"
	L.enchantress = "Encantadora Presacurva"
	L.healer = "Skamasara Presacurva"
	L.collaborator = "Colaborador Presacurva"
	L.ray = "Arraia Presacurva"
end

L = BigWigs:NewBossLocale("Ahune", "ptBR")
if L then
	L.ahune = "Ahune"
	--L.warmup_trigger = "The Ice Stone has melted!"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "ptBR")
if L then
	L.mech_trigger = "Ajuste-os bem, rapazes!"
end
