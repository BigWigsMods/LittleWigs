local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "ptBR")
if not L then return end
if L then
	L.tugar = "Tugar Totem de Sangue"
	L.jormog = "Jormog, o Beemote"

	L.remaining = "Escalas restantes"

	L.submerge = "Submergir"
	L.submerge_desc = "Submerge abaixo do solo, sumonando ovos e fazendo cair estalactites."

	L.charge_desc = "Quando Jormog estiver submerso, ele investirá periodicamente em sua direção."

	L.rupture = "{243382} (X)"
	L.rupture_desc = "Uma Ruptura Vil em forma de um X aparece embaixo de você. Após 5 segundos, ele romperá o solo, enviando espinhos para o ar e repelindo os jogadores em cima dele."

	L.totem_warning = "O Totem te acertou!"
end

L = BigWigs:NewBossLocale("Raest", "ptBR")
if L then
	L.name = "Raest Magilança"

	L.handFromBeyond = "Mão do Além"

	L.rune_desc = "Coloca uma runa de invocação no chão. Se não for absorvida, uma Coisa de Pesadelo irá aparecer."

	L.killed = "%s morto"

	L.warmup_text = "Karam Magilança Ativo"
	L.warmup_trigger = "Foi tolice sua vir atrás de mim, irmão. A Espiral Etérea alimenta minhas forças. Eu me tornei mais poderoso do que você pode imaginar!"
	L.warmup_trigger2 = "Mate este intruso, irmão!"
end

L = BigWigs:NewBossLocale("Kruul", "ptBR")
if L then
	L.name = "Grão-lorde Kruul"
	L.inquisitor = "Inquisidor Variss"
	L.velen = "Profeta Velen"

	L.warmup_trigger = "Tolos arrogantes! Eu me fortaleci com a alma de mil mundos conquistados!"
	L.win_trigger = "Que assim seja. Vocês não vão ficar no caminho por muito tempo."

	L.nether_aberration_desc = "Evoca portais ao redor da sala, gerando Aberrações Etéreas."

	L.smoldering_infernal = "Infernal Fumegante"
	L.smoldering_infernal_desc = "Sumona um Infernal Fumegante."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "ptBR")
if L then
	L.erdris = "Lorde Erdris Cardo"

	L.warmup_trigger = "Sua chegada foi em boa hora."
	L.warmup_trigger2 = "O que está... Acontecendo?" --Stage 5 Warm up

	L.mage = "Mago Reanimado Corrompido"
	L.soldier = "Soldado Reanimado Corrompido"
	L.arbalest = "Arcobalista Reanimada Corrompida"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "ptBR")
if L then
	L.name = "Arquimago Tauriel"
	L.corruptingShadows = "Sombras Corruptoras"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "ptBR")
if L then
	L.name = "Agata"
	L.imp_servant = "Diabrete Serviçal"
	L.fuming_imp = "Diabrete Fumegante"
	L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	-- L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	-- L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	-- L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.absorb = "Absorve"
	L.stacks = "Acumula"
end

L = BigWigs:NewBossLocale("Sigryn", "ptBR")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Vidente das Runas Faljar"

	-- L.warmup_trigger = "What's this? The outsider has come to stop me?"

	L.absorb = "Absorve"
end
