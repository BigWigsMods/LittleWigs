-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "ptBR")
if not L then return end
if L then
	L.name = "Kanrethad Ebanez"

	L.summons = "Convocações"
	L.debuffs = "Debuffs"

	L.start_say = "CONTEMPLEM" -- CONTEMPLEM! Eu consegui controlar as energias vis deste mundo! O poder demoníaco que eu comando agora... É indescritível, ilimitado, ONIPOTENTE!
	L.win_say = "Jubeka" -- Jubeka?! O que você está...?!
end

L = BigWigs:NewBossLocale("Essence of Order", "ptBR")
if L then
	L.name = "Essência da Ordem"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "ptBR")
if L then
	L.engage_yell = "Minha agonia infinita será sua, também!"
end

L = BigWigs:NewBossLocale("Brother Korloff", "ptBR")
if L then
	L.engage_yell = "Vou acabar com você."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "ptBR")
if L then
	L.engage_yell = "A minha lenda começa AGORA!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "ptBR")
if L then
	L.the_headless_horseman = "O Cavaleiro Sem Cabeça"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "ptBR")
if L then
	--L.stage_2_trigger = "Now, Lilian, it is time for your transformation."
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "ptBR")
if L then
	-- Quando eu era filhote, eu mal conseguia dar uns soquinhos, mas após anos de treinamento eu consigo muito mais!
	L.stage3_yell = "era filhote"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "ptBR")
if L then
	L.destroying_sha = "Sha Destruidor"
	L.slain_shado_pan_defender = "Defensor Shado-Pan Assassinado"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "ptBR")
if L then
	L.summon_desc = "Avisa quando Yan-Zhu summona um Cervejante Maltado Leveduro. Ele pode lançar |cff71d5ffFerment|r para curar o chefe."
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "ptBR")
if L then
	-- Ah, ainda não acabou. Pelo que vejo, estamos diante do desafio yaungol. Permita-me esclarecer...
	L.yaungol_warmup_trigger = "Ah, ainda não acabou."

	-- Oh. Se não estou enganado, parece que o conto de Zao Anélion veio à vida antes de nós.
	L.five_suns_warmup_trigger = "Se não estou enganado"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "ptBR")
if L then
	L.corrupt_living_water = "Água Viva Corrompida"
	L.fallen_waterspeaker = "Parlágua Caído"
	L.haunting_sha = "Sha Assombrante"
	L.the_talking_fish = "O Peixe Falante"
	L.the_songbird_queen = "A Rainha Canto de Pássaro"
	L.the_crybaby_hozen = "O Hozen Chorão"
	L.the_nodding_tiger = "O Tigre Cabeceante"
	L.the_golden_beetle = "O Besouro Dourado"
	L.sha_touched_guardian = "Guardião Tocado pelo Sha"
	L.depraved_mistweaver = "Tecelã da Névoa Perversa"
	L.shambling_infester = "Infestador Claudicante"
	L.minion_of_doubt = "Lacaio da Dúvida"
end
