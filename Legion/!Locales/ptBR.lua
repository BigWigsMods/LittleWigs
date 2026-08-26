-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "Tugar Totem de Sangue",
	jormog = "Jormog, o Beemote",

	remaining = "Escalas restantes",

	submerge = "Submergir",
	submerge_desc = "Submerge abaixo do solo, sumonando ovos e fazendo cair estalactites.",

	charge_desc = "Quando Jormog estiver submerso, ele investirá periodicamente em sua direção.",

	rupture = "{243382} (X)",
	rupture_desc = "Uma Ruptura Vil em forma de um X aparece embaixo de você. Após 5 segundos, ele romperá o solo, enviando espinhos para o ar e repelindo os jogadores em cima dele.",

	totem_warning = "O Totem te acertou!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "Raest Magilança",

	handFromBeyond = "Mão do Além",

	rune_desc = "Coloca uma runa de invocação no chão. Se não for absorvida, uma Coisa de Pesadelo irá aparecer.",

	warmup_text = "Karam Magilança Ativo",
	warmup_trigger = "Foi tolice sua vir atrás de mim, irmão. A Espiral Etérea alimenta minhas forças. Eu me tornei mais poderoso do que você pode imaginar!",
	warmup_trigger2 = "Mate este intruso, irmão!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "Grão-lorde Kruul",
	inquisitor = "Inquisidor Variss",
	velen = "Profeta Velen",

	warmup_trigger = "Tolos arrogantes! Eu me fortaleci com a alma de mil mundos conquistados!",
	win_trigger = "Que assim seja. Vocês não vão ficar no caminho por muito tempo.",

	nether_aberration_desc = "Evoca portais ao redor da sala, gerando Aberrações Etéreas.",

	smoldering_infernal = "Infernal Fumegante",
	smoldering_infernal_desc = "Sumona um Infernal Fumegante.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "Lorde Erdris Cardo",

	warmup_trigger = "Sua chegada foi em boa hora.",
	warmup_trigger2 = "O que está... Acontecendo?", --Stage 5 Warm up

	mage = "Mago Reanimado Corrompido",
	soldier = "Soldado Reanimado Corrompido",
	arbalest = "Arcobalista Reanimada Corrompida",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "Arquimago Tauriel",
	corruptingShadows = "Sombras Corruptoras",

	--warmup_trigger1 = "With the Focusing Iris under my control", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--warmup_trigger2 = "Drained of magic, your world will be ripe", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "Agata",
	imp_servant = "Diabrete Serviçal",
	fuming_imp = "Diabrete Fumegante",
	levia = "Levia", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!", -- 35
	--warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!", -- 16
	--warmup_trigger3 = "But first, you must be punished for taking away my little pet.", -- 3

	stacks = "Acumula",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "Sigryn",
	jarl = "Jarl Velbrand",
	faljar = "Vidente das Runas Faljar",

	--warmup_trigger = "What's this? The outsider has come to stop me?",
})

-- Assault on Violet Hold

BigWigsAPI.SetBossModuleLocale("Assault on Violet Hold Trash", {
	custom_on_autotalk_desc = "Seleciona instantaneamente a opção de fofoca do Tenente Sinclaris para iniciar o Ataque ao Castelo Violeta.",
	keeper = "Defensor do Portal",
	guardian = "Guardião do Portal",
	infernal = "Infernal Fulgurante",
})

BigWigsAPI.SetBossModuleLocale("Thalena", {
	essence = "Essência",
})

-- Black Rook Hold

BigWigsAPI.SetBossModuleLocale("Black Rook Hold Trash", {
	ghostly_retainer = "Escudeiro Fantasmagórico",
	ghostly_protector = "Protetor Fantasmagórico",
	ghostly_councilor = "Conselheiro Fantasmagórico",
	lord_etheldrin_ravencrest = "Lorde Etheldrin Cristacorvo",
	lady_velandras_ravencrest = "Lady Velandras Cristacorvo",
	rook_spiderling = "Aranita-corvo",
	soultorn_champion = "Campeão Almapartida",
	risen_scout = "Batedor Reanimado",
	risen_archer = "Arqueira Erguida",
	risen_arcanist = "Arcanista Reanimado",
	wyrmtongue_scavenger = "Catador Língua de Serpe",
	bloodscent_felhound = "Canisvil Cheirassangue",
	felspite_dominator = "Dominador Rancorvil",
	risen_swordsman = "Espadachim Revivido",
	risen_lancer = "Lanceiro Revivido",

	--door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway.",
})

BigWigsAPI.SetBossModuleLocale("Kurtalos Ravencrest", {
	--phase_2_trigger = "Enough! I tire of this.",
})

-- Cathedral of Eternal Night

BigWigsAPI.SetBossModuleLocale("Mephistroth", {
	custom_on_time_lost = "Tempo perdido durante Desvanecer nas Sombras",
	custom_on_time_lost_desc = "Mostra o tempo perdido durante o Desvanecer nas Sombras na barra em |cffff0000red|r.",
	--time_lost = "%s |cffff0000(+%ds)|r",
})

BigWigsAPI.SetBossModuleLocale("Domatrax", {
	custom_on_autotalk_desc = "Seleciona instantaneamente a opção de fofoca da Égide de Aggramar para começar o confronto com Domatrax.",

	missing_aegis = "Você não está com a Égide ", -- Aegis is a short name for Aegis of Aggramar
	aegis_healing = "Égide: Cura Reduzida",
	aegis_damage = "Égide: Dano Reduzido",
})

BigWigsAPI.SetBossModuleLocale("Cathedral of Eternal Night Trash", {
	dulzak = "Dul'zak",
	wrathguard = "Invasor Guardião Colérico",
	felguard = "Guarda Vil Destruidor",
	soulmender = "Trata-alma Ardinferno",
	temptress = "Tentadora Ardinferno",
	botanist = "Botânica Vilanesca",
	orbcaster = "Lança-orbe Passovil",
	waglur = "Wa'glur",
	scavenger = "Catador Língua de Serpe",
	gazerax = "Gazerax",
	vilebark = "Andarilho Cascavil",

	throw_tome = "Arremessar Tomo", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "Sentinela da Vigia Crepuscular",
	duskwatch_reinforcement = "Reforço da Vigia Crepuscular",
	Guard = "Guarda da Vigia Crepuscular",
	Construct = "Constructo Guardião",
	Enforcer = "Impositora Aviltada",
	Hound = "Farejador Legionário",
	Mistress = "Donzela Sombria",
	Gerenth = "Gerenth, o Torpe",
	Jazshariu = "Jazshariu",
	Imacutya = "Imacu'tya",
	Baalgar = "Baalgar, o Vigilante",
	Inquisitor = "Inquisidor Vigilante",
	BlazingImp = "Diabrete Fulgurante",
	Energy = "Energia Aprisionada",
	Manifestation = "Manifestação Arcana",
	Wyrm = "Moreia de Mana",
	Arcanist = "Arcanista da Vigia Crepuscular",
	InfernalImp = "Diabrete Infernal",
	Malrodi = "Arcanista Malrodi",
	Velimar = "Velimar",
	ArcaneKeys = "Chaves Arcanas",
	clues = "Pistas",

	InfernalTome = "Tomo Infernal",
	MagicalLantern = "Lanterna Mágica",
	NightshadeRefreshments = "Lanches de Beladona",
	StarlightRoseBrew = "Cerveja de Rosa-da-luz-estelar",
	UmbralBloom = "Flor Umbrática",
	WaterloggedScroll = "Pergaminho Encharcado",
	BazaarGoods = "Mercadorias do bazar",
	LifesizedNightborneStatue = "Estátua de Filho da Noite em Tamanho Real",
	DiscardedJunk = "Lixo Descartado",
	WoundedNightborneCivilian = "Civil Filho da Noite Ferido",

	announce_buff_items = "Anuncia itens de buff",
	announce_buff_items_desc = "Anuncia todos os itens buff disponíveis ao redor da dungeon e quem é capaz de usá-los.",

	available = "%s|cffffffff%s|r disponível", -- Context: item is available to use
	usableBy = "utilizável por %s", -- Context: item is usable by someone

	custom_on_use_buff_items = "usar instantaneamente itens com buff",
	custom_on_use_buff_items_desc = "Ative esta opção para usar instantaneamente os itens de buff ao redor da dungeon. Isso não usará os itens que aggram os guardas antes do segundo chefe.",

	spy_helper = "Ajudante de Evento Espião",
	spy_helper_desc = "Mostra uma Caixa de Informações com todas as pistas que seu grupo reuniu sobre o espião. As pistas também serão enviadas para os membros do seu grupo no chat.",

	clueFound = "Pista encontrada (%d/5): |cffffffff%s|r",
	spyFound = "Espião encontrado por %s!",
	spyFoundChat = "Eu encontrei o espião!",
	spyFoundPattern = "Ora, ora, não sejamos apressados", -- Ora, ora, não sejamos apressados, [playername]. Que tal me seguir e conversar em um local mais reservado...

	hints = {
		[1] = "Capa",
		[2] = "Sem capa",
		[3] = "Bolsa",
		[4] = "Poções",
		[5] = "Mangas longas",
		[6] = "Mangas curtas",
		[7] = "Luvas",
		[8] = "Sem luvas",
		[9] = "Masculino",
		[10] = "Feminino",
		[11] = "Roupa clara",
		[12] = "Roupa escura",
		[13] = "Sem poções",
		[14] = "Livro",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	warmup_trigger = "Mais um fracasso, Melandrus. Esta é sua chance de corrigí-lo. Livre-se desses forasteiros. Eu tenho que voltar ao Baluarte da Noite.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	--archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!",

	mindshattered_screecher = "Guinchado Mentepartida",
	dreadsoul_ruiner = "Arruinador Almatorpe",
	dreadsoul_poisoner = "Envenenador Almatorpe",
	crazed_razorbeak = "Bicofino Enlouquecido",
	festerhide_grizzly = "Pelepodre Pardo",
	vilethorn_blossom = "Florescência Vilespinho",
	rotheart_dryad = "Dríade Putricórdio",
	rotheart_keeper = "Guardião Putricórdio",
	nightmare_dweller = "Habitante do Pesadelo",
	bloodtainted_fury = "Fúria Manchada de Sangue",
	bloodtainted_burster = "Estourador Manchado de Sangue",
	taintheart_summoner = "Evocador Cordismáculo",
	dreadfire_imp = "Diabrete do Fogo Mórbido",
	tormented_bloodseeker = "Sanguinário Atormentado",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	--throw = "Throw",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "Domador de Espiródio",
	stormweaver = "Tempestece Espiródio",
	crusher = "Esmagador Espiródio",
	oracle = "Oráculo Espiródio",
	siltwalker = "Mak'rana Andalodo",
	tides = "Marés Inquietas",
	arcanist = "Arcanista Espiródio",
})

BigWigsAPI.SetBossModuleLocale("Lady Hatecoil", {
	custom_on_show_helper_messages = "Mensagens de ajuda para Nova Estática e Raio Concentrado",
	custom_on_show_helper_messages_desc = "Ative esta opção para adicionar uma mensagem auxiliar informando se a água ou a terra estão seguras quando o chefe começa a castar |cff71d5ffNova Estática|r ou |cff71d5ffRacio concentrado|r.",

	water_safe = "%s (água está segura)",
	land_safe = "%s (terra está segura)",
})

-- Halls of Valor

BigWigsAPI.SetBossModuleLocale("Odyn", {
	gossip_available = "Conversa disponível",
	gossip_trigger = "Muito impressionante! Eu nunca pensei que encontraria alguém capaz de igualar Valarjar em força... porém, aí estão vocês.",

	[197963] = "|cFF800080Acima à direita|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Right"
	[197964] = "|cFFFFA500Abaixo à direita|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Right"
	[197965] = "|cFFFFFF00Abaixo à esquerda|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Left"
	[197966] = "|cFF0000FFAcima à esquerda|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Left"
	[197967] = "|cFF008000Acima|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top"
})

BigWigsAPI.SetBossModuleLocale("God-King Skovald", {
	warmup_text = "Deus-Rei Skovald Ativo",
	warmup_trigger = "Os conquistadores já tomaram posse dele, Skovald, como era de direito. Seu protesto vem tarde demais.",
	warmup_trigger_2 = "Se esses falsos campeões não entregarem a égide por escolha própria, entregarão na morte!",
})

BigWigsAPI.SetBossModuleLocale("Halls of Valor Trash", {
	mug_of_mead = "Caneco de Hidromel",
	valarjar_thundercaller = "Arauto do Trovão Valarjar",
	storm_drake = "Draco da Tempestade",
	stormforged_sentinel = "Sentinela Forjada em Tempestade",
	valarjar_runecarver = "Gravarrunas Valarjar",
	valarjar_mystic = "Místico Valarjar",
	valarjar_purifier = "Purificador Valarjar",
	valarjar_shieldmaiden = "Dama Escudeira Valarjar",
	valarjar_aspirant = "Aspirante Valarjar",
	solsten = "Solsten",
	olmyr = "Olmyr, o Iluminado",
	valarjar_marksman = "Atiradora Perita Valarjar",
	gildedfur_stag = "Cervo Pelo D'Ouro",
	angerhoof_bull = "Touro Casca da Fúria",
	valarjar_trapper = "Coureador Valarjar",
	fourkings = "Os Quatro Reis",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	custom_on_autotalk_desc = "Seleciona instantaneamente a opção de conversa com Barnes para iniciar o encontro no Salão de Ópera.",
	opera_hall_wikket_story_text = "Salão de Ópera: Wikket",
	opera_hall_wikket_story_trigger = "Pare de falatório", -- Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "Salão de Ópera: História de Westfall",
	opera_hall_westfall_story_trigger = "nós encontramos dois amantes", -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	opera_hall_beautiful_beast_story_text = "Salão de Ópera: A Bela e a Fera",
	opera_hall_beautiful_beast_story_trigger = "um conto de romance e raiva", -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	barnes = "Barnes",
	ghostly_philanthropist = "Filantropo Fantasma",
	skeletal_usher = "Porteiro Cadavérico",
	spectral_attendant = "Criado Espectral",
	spectral_valet = "Pajem Espectral",
	spectral_retainer = "Escudeiro Espectral",
	phantom_guardsman = "Guarda Fantasma",
	wholesome_hostess = "Anfitriã Respeitável",
	reformed_maiden = "Donzela Reabilitada",
	spectral_charger = "Corcel Espectral",

	-- Return to Karazhan: Upper
	chess_event = "Evento de Xadrez",
	king = "Rei",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "Controle Coletivo",
	--cc_desc = "Timers and alerts for crowd control on the dinner guests.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "Nocturno",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "Guarda da Alma Encharcado",
	champion = "Campeão Helarjar",
	mariner = "Fuzileiro da Vigília Noturna",
	swiftblade = "Mardiçoado Lâmina Célere",
	mistmender = "Remenda-bruma Mardiçoada",
	mistcaller = "Chamabruma Helarjar",
	skjal = "Skjal",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	rokmora_first_warmup_trigger = "Navarrogg?! Traidor! Você liderou esses intrusos contra nós?!",
	rokmora_second_warmup_trigger = "De qualquer forma, vou curtir cada momento. Rokmora, esmague-os!",

	vileshard_crawler = "Rastejante Estilhavil",
	tarspitter_lurker = "Tocaieiro Cospiche",
	rockback_gnasher = "Triscadente Costapétrea",
	vileshard_hulk = "Gigante Estilhavil",
	vileshard_chunk = "Pedaço de Estilhavil",
	understone_drummer = "Caixeiro Subpetra",
	mightstone_breaker = "Rachador Megalito",
	blightshard_shaper = "Moldador Mangrastilha",
	stoneclaw_grubmaster = "Mestre dos Vermes Garrapétrea",
	tarspitter_grub = "Verme Cospiche",
	rotdrool_grabber = "Agarrador Babapodre",
	understone_demolisher = "Demolidor Subpetra",
	rockbound_trapper = "Coureador Rochatado",
	emberhusk_dominator = "Dominador Cascabrasa",
})

BigWigsAPI.SetBossModuleLocale("Ularogg Cragshaper", {
	--hands = "Hands", -- Short for "Stone Hands"
})

-- Seat of the Triumvirate

BigWigsAPI.SetBossModuleLocale("Viceroy Nezhar", {
	guards = "Guardas",
	interrupted = "%s interrompido %s (%.1fs restando)!",
})

BigWigsAPI.SetBossModuleLocale("L'ura", {
	warmup_text = "L'ura Ativa",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	custom_on_autotalk_desc = "Seleciona instantaneamente a opção de conversa com Alleria Correventos.",
	gossip_available = "Conversa disponível",
	alleria_gossip_trigger = "Siga-me!", -- Allerias yell after the first boss is defeated
	lura_warmup_trigger = "Quanto caos, quanta angústia. Nunca senti nada igual.",
	lura_warmup_trigger_2 = "Tais reflexões podem esperar, entretanto. Esta entidade deve morrer.",

	alleria = "Alleria Correventos",
	subjugator = "Subjugante da Guarda Sombria",
	voidbender = "Dobra-caos da Guarda Sombria",
	conjurer = "Conjuradora da Guarda Sombria",
	weaver = "Tecelã-mor das Sombras",

	-- Midnight+
	--void_rifts_closed = "Void Rifts Closed",
	--void_rifts_closed_desc = "Show an alert when a Void Rift has been closed.",
})

-- The Arcway

BigWigsAPI.SetBossModuleLocale("The Arcway Trash", {
	anomaly = "Anomalia Arcana",
	shade = "Vulto Dimensional",
	wraith = "Espectro de Mana Fenecido",
	blade = "Guardião Colérico Lâmina Vil",
	chaosbringer = "Eredar Caótico",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "Combo de Chute",

	light_dropped = "%s derrubou a Luz.",
	light_picked = "%s pegou a Luz.",

	warmup_trigger = "Eu já estou com o que queria. Mas continuei aqui para que pudesse acabar com você... De uma vez por todas!",
	warmup_trigger_2 = "E agora, vocês caem na minha armadilha. Tolos. Vamos ver como vocês ficam no escuro.",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	warmup_trigger = "Servirei ao MEU povo, os exilados e enxovalhados.",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	infester = "Infestador Devoto Vil",
	myrmidon = "Mirmidão Devoto Vil",
	fury = "Fúria Vilinfusa",
	mother = "Mãe Imunda",
	illianna = "Dançarina das Lâminas Illiana",
	mendacius = "Senhor do Medo Mendácius",
	grimhorn = "Chifre Austero, o Escravizador",
})
