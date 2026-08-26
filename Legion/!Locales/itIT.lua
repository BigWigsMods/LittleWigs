-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "Tugar Totem Sanguinario",
	jormog = "Jormog il Behemoth",

	--remaining = "Scales Remaining",

	--submerge = "Submerge",
	--submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes.",

	--charge_desc = "When Jormog is submerged, he will periodically charge in your direction.",

	--rupture = "{243382} (X)",
	--rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it.",

	--totem_warning = "The totem hit you!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "Raest Lanciamagica",

	--handFromBeyond = "Hand from Beyond",

	--rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn.",

	--warmup_text = "Karam Magespear Active",
	--warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!",
	--warmup_trigger2 = "Kill this interloper, brother!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "Gran Signore Kruul",
	inquisitor = "Inquisitore Variss",
	velen = "Profeta Velen",

	--warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!",
	--win_trigger = "So be it. You will not stand in our way any longer.",

	--nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations.",

	--smoldering_infernal = "Smoldering Infernal",
	--smoldering_infernal_desc = "Summons a Smoldering Infernal.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "Ser Erdris Rovospina",

	--warmup_trigger = "Your arrival is well-timed.",
	--warmup_trigger2 = "What's... happening?", --Stage 5 Warm up

	mage = "Mago Rianimato Corrotto",
	soldier = "Soldato Rianimato Corrotto",
	arbalest = "Balestriera Rianimata Corrotta",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "Arcimago Xylem",
	corruptingShadows = "Ombre Corrompenti",

	--warmup_trigger1 = "With the Focusing Iris under my control", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--warmup_trigger2 = "Drained of magic, your world will be ripe", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "Agatha",
	imp_servant = "Imp Servitore",
	fuming_imp = "Imp Fumante",
	levia = "Levia", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!", -- 35
	--warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!", -- 16
	--warmup_trigger3 = "But first, you must be punished for taking away my little pet.", -- 3

	--stacks = "Stacks",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "Sigryn",
	jarl = "Jarl Velbrand",
	faljar = "Veggente delle Rune Faljar",

	--warmup_trigger = "What's this? The outsider has come to stop me?",
})

-- Assault on Violet Hold

BigWigsAPI.SetBossModuleLocale("Assault on Violet Hold Trash", {
	--custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold.",
	--keeper = "Portal Keeper",
	--guardian = "Portal Guardian",
	--infernal = "Blazing Infernal",
})

BigWigsAPI.SetBossModuleLocale("Thalena", {
	--essence = "Essence",
})

-- Black Rook Hold

BigWigsAPI.SetBossModuleLocale("Black Rook Hold Trash", {
	ghostly_retainer = "Lacchè Spettrale",
	ghostly_protector = "Protettore Spettrale",
	ghostly_councilor = "Consigliere Spettrale",
	lord_etheldrin_ravencrest = "Ser Etheldrin Crinocorvo",
	lady_velandras_ravencrest = "Dama Velandras Crinocorvo",
	rook_spiderling = "Ragnetto Corvino",
	soultorn_champion = "Campione Senz'Anima",
	risen_scout = "Esploratore Rianimato",
	risen_archer = "Arciera Rianimata",
	risen_arcanist = "Arcanista Rianimato",
	wyrmtongue_scavenger = "Saprofago Drachilingua",
	bloodscent_felhound = "Vilsegugio Fiutorosso",
	felspite_dominator = "Dominatore Vilvendetta",
	risen_swordsman = "Spadaccino Rianimato",
	risen_lancer = "Lanciere Rianimato",

	--door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway.",
})

BigWigsAPI.SetBossModuleLocale("Kurtalos Ravencrest", {
	--phase_2_trigger = "Enough! I tire of this.",
})

-- Cathedral of Eternal Night

BigWigsAPI.SetBossModuleLocale("Mephistroth", {
	--custom_on_time_lost = "Time lost during Shadow Fade",
	--custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r.",
	--time_lost = "%s |cffff0000(+%ds)|r",
})

BigWigsAPI.SetBossModuleLocale("Domatrax", {
	--custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter.",

	--missing_aegis = "You're not standing in Aegis", -- Aegis is a short name for Aegis of Aggramar
	--aegis_healing = "Aegis: Reduced Healing Done",
	--aegis_damage = "Aegis: Reduced Damage Done",
})

BigWigsAPI.SetBossModuleLocale("Cathedral of Eternal Night Trash", {
	dulzak = "Dul'zak",
	--wrathguard = "Wrathguard Invader",
	felguard = "Vilguardia Distruttrice",
	soulmender = "Guaritore d'Anime Ardinferno",
	temptress = "Tentatrice Ardinferno",
	botanist = "Botanica Stirpevile",
	orbcaster = "Scagliaglobi Vilcamminatrice",
	waglur = "Wa'glur",
	scavenger = "Saprofago Drachilingua",
	gazerax = "Gazerax",
	vilebark = "Camminatore Scorzavile",

	--throw_tome = "Throw Tome", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "Sentinella della Guardia del Vespro",
	duskwatch_reinforcement = "Membro dei Rinforzi della Guardia del Vespro",
	Guard = "Miliziano della Guardia del Vespro",
	Construct = "Costrutto Guardiano",
	Enforcer = "Scagnozza Vilvincolata",
	Hound = "Segugio della Legione",
	Mistress = "Signora dell'Ombra",
	Gerenth = "Gerenth il Vile",
	Jazshariu = "Jazshariu",
	Imacutya = "Mohte'tajo",
	Baalgar = "Baalgar il Solerte",
	Inquisitor = "Inquisitore Vigile",
	BlazingImp = "Imp Fiammeggiante",
	Energy = "Energia Vincolata",
	Manifestation = "Manifestazione Arcana",
	Wyrm = "Dragone di Mana",
	Arcanist = "Arcanista della Guardia del Vespro",
	InfernalImp = "Imp Infernale",
	Malrodi = "Arcanista Malrodi",
	Velimar = "Velimar",
	ArcaneKeys = "Chiavi Arcane",
	clues = "Indizi",

	InfernalTome = "Tomo Infernale",
	MagicalLantern = "Lanterna Magica",
	NightshadeRefreshments = "Rinfreschi degli Ombranera",
	StarlightRoseBrew = "Birra di Rosa Lucestellare",
	UmbralBloom = "Germoglio Ombroso",
	WaterloggedScroll = "Pergamena Fradicia",
	BazaarGoods = "Merci del Bazar",
	LifesizedNightborneStatue = "Statua di Nobile Oscuro Realistica",
	DiscardedJunk = "Cianfrusaglie Scartate",
	WoundedNightborneCivilian = "Civile Nobile Oscuro Ferito",

	--announce_buff_items = "Announce buff items",
	--announce_buff_items_desc = "Anounces all available buff items around the dungeon and who is able to use them.",

	--available = "%s|cffffffff%s|r available", -- Context: item is available to use
	--usableBy = "usable by %s", -- Context: item is usable by someone

	--custom_on_use_buff_items = "Instantly use buff items",
	--custom_on_use_buff_items_desc = "Enable this options to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss.",

	--spy_helper = "Spy Event Helper",
	--spy_helper_desc = "Shows an InfoBox with all clues your group gathered about the spy. The clues will also be send to your party members in chat.",

	--clueFound = "Clue found (%d/5): |cffffffff%s|r",
	--spyFound = "Spy found by %s!",
	--spyFoundChat = "I found the spy!",
	spyFoundPattern = "Su, su, non perdiamo la calma", -- Su, su, non perdiamo la calma, [playername]. Perché non mi segui, così possiamo parlare più tranquillamente...

	--hints = {
		--[1] = "Cape",
		--[2] = "No Cape",
		--[3] = "Pouch",
		--[4] = "Potions",
		--[5] = "Long Sleeves",
		--[6] = "Short Sleeves",
		--[7] = "Gloves",
		--[8] = "No Gloves",
		--[9] = "Male",
		--[10] = "Female",
		--[11] = "Light Vest",
		--[12] = "Dark Vest",
		--[13] = "No Potions",
		--[14] = "Book",
	--},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	--warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	--archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!",

	mindshattered_screecher = "Stridente Dissennato",
	dreadsoul_ruiner = "Polverizzatore Tetranima",
	dreadsoul_poisoner = "Avvelenatore Tetranima",
	crazed_razorbeak = "Beccolesto Frenetico",
	festerhide_grizzly = "Grizzly Putrescente",
	vilethorn_blossom = "Germoglio Spinavile",
	rotheart_dryad = "Driade Cuormarcio",
	rotheart_keeper = "Custode Cuormarcio",
	nightmare_dweller = "Abitante dell'Incubo",
	bloodtainted_fury = "Furia Marcasangue",
	bloodtainted_burster = "Zampillo Marcasangue",
	taintheart_summoner = "Evocatore Marcacuori",
	dreadfire_imp = "Imp Malofuoco",
	tormented_bloodseeker = "Bramasangue Tormentato",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	--throw = "Throw",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "Mandriano Spiraostile",
	stormweaver = "Brigliatuono Spiraostile",
	crusher = "Frantumatore Spiraostile",
	oracle = "Oracolo Spiraostile",
	siltwalker = "Calcalimo Mak'rana",
	tides = "Marea Irrequieta",
	arcanist = "Arcanista Spiraostile",
})

BigWigsAPI.SetBossModuleLocale("Lady Hatecoil", {
	--custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning",
	--custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r.",

	--water_safe = "%s (water is safe)",
	--land_safe = "%s (land is safe)",
})

-- Halls of Valor

BigWigsAPI.SetBossModuleLocale("Odyn", {
	--gossip_available = "Gossip available",
	--gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand.",

	--[197963] = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Right"
	--[197964] = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Right"
	--[197965] = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Left"
	--[197966] = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Left"
	--[197967] = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top"
})

BigWigsAPI.SetBossModuleLocale("God-King Skovald", {
	--warmup_text = "God-King Skovald Active",
	--warmup_trigger = "The vanquishers have already taken possession of it, Skovald, as was their right. Your protest comes too late.",
	--warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!",
})

BigWigsAPI.SetBossModuleLocale("Halls of Valor Trash", {
	mug_of_mead = "Boccale di Idromele",
	valarjar_thundercaller = "Evocatuoni Valarjar",
	storm_drake = "Draco della Tempesta",
	stormforged_sentinel = "Sentinella Forgiatuono",
	valarjar_runecarver = "Incisore di Rune Valarjar",
	valarjar_mystic = "Mistico Valarjar",
	valarjar_purifier = "Purificatore Valarjar",
	valarjar_shieldmaiden = "Signora dello Scudo Valarjar",
	valarjar_aspirant = "Aspirante Valarjar",
	solsten = "Solsten",
	olmyr = "Olmyr l'Illuminato",
	valarjar_marksman = "Tiratrice Valarjar",
	gildedfur_stag = "Cervo Peldorato",
	angerhoof_bull = "Zoccolofurioso Adulto",
	valarjar_trapper = "Mastro Bracconiere Valarjar",
	fourkings = "I quattro re",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	--custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter.",
	opera_hall_wikket_story_text = "Teatro: Il Mago di Hoz",
	--opera_hall_wikket_story_trigger = "Shut your jabber", -- Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "Teatro: Mrrgria",
	--opera_hall_westfall_story_trigger = "we meet two lovers", -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	opera_hall_beautiful_beast_story_text = "Teatro: La Bella e il Bruto",
	--opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage", -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	barnes = "Barnes",
	ghostly_philanthropist = "Filantropo Fantasma",
	skeletal_usher = "Usciere Scheletrico",
	spectral_attendant = "Attendente Spettrale",
	spectral_valet = "Maschera Spettrale",
	spectral_retainer = "Lacchè Spettrale",
	phantom_guardsman = "Armigero Fantasma",
	wholesome_hostess = "Cameriera Integerrima",
	reformed_maiden = "Dama Ravveduta",
	spectral_charger = "Gran Destriero Spettrale",

	-- Return to Karazhan: Upper
	chess_event = "Evento degli Scacchi",
	king = "Re",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "Controllo delle Creature",
	--cc_desc = "Timers and alerts for crowd control on the dinner guests.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "Noctumor",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "Guardia dell'Anima Fradicia",
	champion = "Campione Helarjar",
	mariner = "Marinaio dei Guardiani della Notte",
	swiftblade = "Lamalesta Maledetto",
	mistmender = "Curatrice delle Nebbie Maledetta",
	mistcaller = "Evocanebbie Helarjar",
	skjal = "Skjal",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	--rokmora_first_warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!",
	--rokmora_second_warmup_trigger = "Either way, I will enjoy every moment of it. Rokmora, crush them!",

	vileshard_crawler = "Strisciatore Scheggiavile",
	tarspitter_lurker = "Guardingo Sputapece",
	rockback_gnasher = "Masticatore Dorsorigido",
	vileshard_hulk = "Colosso Scheggiavile",
	vileshard_chunk = "Frammento di Scheggiavile",
	understone_drummer = "Percussionista di Pietrabassa",
	mightstone_breaker = "Spezzatore di Pietragrossa",
	blightshard_shaper = "Plasmatore Scheggiamorbo",
	stoneclaw_grubmaster = "Signore delle Larve Unghiadura",
	tarspitter_grub = "Verme Sputapece",
	rotdrool_grabber = "Afferratore Bavamarcia",
	understone_demolisher = "Demolitore di Pietrabassa",
	rockbound_trapper = "Mastro Bracconiere Roccioso",
	emberhusk_dominator = "Dominatore Scorzambrata",
})

BigWigsAPI.SetBossModuleLocale("Ularogg Cragshaper", {
	--hands = "Hands", -- Short for "Stone Hands"
})

-- Seat of the Triumvirate

BigWigsAPI.SetBossModuleLocale("Viceroy Nezhar", {
	--guards = "Guards",
	--interrupted = "%s interrupted %s (%.1fs left)!",
})

BigWigsAPI.SetBossModuleLocale("L'ura", {
	--warmup_text = "L'ura Active",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	--custom_on_autotalk_desc = "Instantly selects Alleria Winrunners gossip option.",
	--gossip_available = "Gossip available",
	--alleria_gossip_trigger = "Follow me!", -- Allerias yell after the first boss is defeated
	--lura_warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before.",
	--lura_warmup_trigger_2 = "Such musings can wait, though. This entity must die.",

	--alleria = "Alleria Windrunner",
	--subjugator = "Shadowguard Subjugator",
	--voidbender = "Shadowguard Voidbender",
	--conjurer = "Shadowguard Conjurer",
	--weaver = "Grand Shadow-Weaver",

	-- Midnight+
	--void_rifts_closed = "Void Rifts Closed",
	--void_rifts_closed_desc = "Show an alert when a Void Rift has been closed.",
})

-- The Arcway

BigWigsAPI.SetBossModuleLocale("The Arcway Trash", {
	anomaly = "Anomalia Arcana",
	shade = "Ombra Distorcente",
	wraith = "Avvizzito del Mana Spettrale",
	blade = "Guardia dell'Ira Vilspada",
	chaosbringer = "Portatore del Caos Eredar",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	--kick_combo = "Kick Combo",

	--light_dropped = "%s dropped the Light.",
	--light_picked = "%s picked up the Light.",

	--warmup_trigger = "I have what I was after. But I stayed just so that I could put an end to you... once and for all!",
	--warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark.",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	--warmup_trigger = "I will serve MY people, the exiled and the reviled.",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	--infester = "Felsworn Infester",
	--myrmidon = "Felsworn Myrmidon",
	--fury = "Fel-Infused Fury",
	--mother = "Foul Mother",
	--illianna = "Blade Dancer Illianna",
	--mendacius = "Dreadlord Mendacius",
	--grimhorn = "Grimhorn the Enslaver",
})
