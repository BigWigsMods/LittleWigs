-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "Tugar Totem-de-Sang",
	jormog = "Jormog le Béhémoth",

	--remaining = "Scales Remaining",

	--submerge = "Submerge",
	--submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes.",

	--charge_desc = "When Jormog is submerged, he will periodically charge in your direction.",

	--rupture = "{243382} (X)",
	--rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it.",

	--totem_warning = "The totem hit you!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "Raëst Magelance",

	--handFromBeyond = "Hand from Beyond",

	--rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn.",

	--warmup_text = "Karam Magespear Active",
	--warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!",
	--warmup_trigger2 = "Kill this interloper, brother!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "Généralissime Kruul",
	inquisitor = "Inquisiteur Variss",
	velen = "Prophète Velen",

	--warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!",
	--win_trigger = "So be it. You will not stand in our way any longer.",

	--nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations.",

	--smoldering_infernal = "Smoldering Infernal",
	--smoldering_infernal_desc = "Summons a Smoldering Infernal.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "Seigneur Erdris Epine",

	--warmup_trigger = "Your arrival is well-timed.",
	--warmup_trigger2 = "What's... happening?", --Stage 5 Warm up

	mage = "Mage ressuscité corrompu",
	soldier = "Soldat ressuscité corrompu",
	arbalest = "Arbalestrier ressuscité corrompu",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "Archimage Xylem",
	corruptingShadows = "Ombres corruptrices",

	--warmup_trigger1 = "With the Focusing Iris under my control", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--warmup_trigger2 = "Drained of magic, your world will be ripe", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "Agatha",
	imp_servant = "Diablotin serviteur",
	fuming_imp = "Diablotin furieux",
	levia = "Levia", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!", -- 35
	--warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!", -- 16
	--warmup_trigger3 = "But first, you must be punished for taking away my little pet.", -- 3

	stacks = "Cumuls",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "Sigryn",
	jarl = "Jarl Velbrand",
	faljar = "Voyant des runes Faljar",

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
	ghostly_retainer = "Factotum fantomatique",
	ghostly_protector = "Protecteur fantomatique",
	ghostly_councilor = "Conseiller fantomatique",
	lord_etheldrin_ravencrest = "Seigneur Etheldrin Corvaltus",
	lady_velandras_ravencrest = "Dame Velandras Corvaltus",
	rook_spiderling = "Jeune araignée du Freux",
	soultorn_champion = "Champion écorchâme",
	risen_scout = "Eclaireur ressuscité",
	risen_archer = "Archère ressuscitée",
	risen_arcanist = "Arcaniste ressuscité",
	wyrmtongue_scavenger = "Pillard langue-de-wyrm",
	bloodscent_felhound = "Gangrechien piste-sang",
	felspite_dominator = "Dominateur gangrefiel",
	risen_swordsman = "Epéiste ressuscité",
	risen_lancer = "Lancier ressuscité",

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
	felguard = "Destructeur gangregarde",
	soulmender = "Soigne-âme feu-d'enfer",
	temptress = "Tentatrice feu-d'enfer",
	botanist = "Botaniste gangrenuit",
	orbcaster = "Lance-orbe gangrerôdeur",
	waglur = "Wa'glur",
	scavenger = "Pillard langue-de-wyrm",
	gazerax = "Scrutax",
	vilebark = "Marcheur vilécorce",

	--throw_tome = "Throw Tome", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "Factionnaire de la Garde crépusculaire",
	duskwatch_reinforcement = "Renfort de la Garde crépusculaire",
	Guard = "Vigile de la Garde crépusculaire",
	Construct = "Assemblage gardien",
	Enforcer = "Massacreur gangre-lié",
	Hound = "Molosse de la Légion",
	Mistress = "Maîtresse de l’ombre",
	Gerenth = "Gerenth le Vil",
	Jazshariu = "Jazshariu",
	Imacutya = "Savatr’anshé",
	Baalgar = "Baalgar le Vigilant",
	Inquisitor = "Inquisiteur vigilant",
	BlazingImp = "Diablotin flamboyant",
	Energy = "Energie liée",
	Manifestation = "Manifestation arcanique",
	Wyrm = "Wyrm de mana",
	Arcanist = "Arcaniste de la Garde crépusculaire",
	InfernalImp = "Diablotin infernal",
	Malrodi = "Arcaniste Malrodi",
	Velimar = "Velimar",
	ArcaneKeys = "Clés arcaniques",
	clues = "Indices",

	InfernalTome = "Tome infernal",
	MagicalLantern = "Lanterne magique",
	NightshadeRefreshments = "Rafraîchissements de belladone",
	StarlightRoseBrew = "Infusion de rose lumétoile",
	UmbralBloom = "Floraison ombreuse",
	WaterloggedScroll = "Parchemin détrempé",
	BazaarGoods = "Marchandises de bazar",
	LifesizedNightborneStatue = "Statue de sacrenuit à échelle réelle",
	DiscardedJunk = "Camelote abandonnée",
	WoundedNightborneCivilian = "Civil sacrenuit blessé",

	announce_buff_items = "Annoncer les objets de buff",
	announce_buff_items_desc = "Annonce tous les objets de buff disponibles du donjon et qui peut les utiliser.",

	available = "%s|cffffffff%s|r disponible", -- Context: item is available to use
	usableBy = "utilisable par %s", -- Context: item is usable by someone

	custom_on_use_buff_items = "Utiliser instantanément les objets de buff",
	custom_on_use_buff_items_desc = "Activer cette option pour utiliser instantanément les objets de buff du donjon. Ceci n'utilisera pas les objets qui attirent les gardes avant le 2ème boss.",

	spy_helper = "Aide évènement espion",
	spy_helper_desc = "Affiche une boîte d'info avec tous les indices que votre groupe a récolté concernant l'espion. Les indices seront également envoyés aux membres de votre groupe dans la discussion.",

	clueFound = "Indice trouvé (%d/5) : |cffffffff%s|r",
	spyFound = "Espion trouvé par %s !",
	spyFoundChat = "J'ai trouvé l'espion !",
	spyFoundPattern = "allez pas trop vite en besogne", -- Allons, [playername]. N’allez pas trop vite en besogne. Et si vous me suiviez, que nous puissions en parler en privé ?

	hints = {
		[1] = "Cape",
		[2] = "Pas de cape",
		[3] = "Sacoche",
		[4] = "Potions",
		[5] = "Manches longues",
		[6] = "Manches courtes",
		[7] = "Gants",
		[8] = "Pas de gants",
		[9] = "Homme",
		[10] = "Femme",
		[11] = "Gilet clair",
		[12] = "Gilet sombre",
		[13] = "Pas de potions",
		[14] = "Livre",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	--warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	--archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!",

	mindshattered_screecher = "Hurleur esprit-brisé",
	dreadsoul_ruiner = "Dévastateur âmeffroi",
	dreadsoul_poisoner = "Empoisonneur âmeffroi",
	crazed_razorbeak = "Bec-rasoir affolé",
	festerhide_grizzly = "Grizzly peau-putride",
	vilethorn_blossom = "Floraison vileronce",
	rotheart_dryad = "Dryade cœur-putride",
	rotheart_keeper = "Gardien cœur-putride",
	nightmare_dweller = "Habitant du Cauchemar",
	bloodtainted_fury = "Fureur sang-vicié",
	bloodtainted_burster = "Irruption sang-vicié",
	taintheart_summoner = "Invocateur cœur-corrompu",
	dreadfire_imp = "Diablotin brûle-effroi",
	tormented_bloodseeker = "Cherche-sang tourmenté",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	--throw = "Throw",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "Querelleur glissefiel",
	stormweaver = "Tisse-tempête glissefiel",
	crusher = "Ecraseur glissefiel",
	oracle = "Oracle glissefiel",
	siltwalker = "Marche-vase de Mak’rana",
	tides = "Courant agité",
	arcanist = "Arcaniste glissefiel",
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
	mug_of_mead = "Chope d'hydromel",
	valarjar_thundercaller = "Mande-tonnerre valarjar",
	storm_drake = "Drake-tempête",
	stormforged_sentinel = "Sentinelle forge-foudre",
	valarjar_runecarver = "Runomancien valarjar",
	valarjar_mystic = "Mystique valarjar",
	valarjar_purifier = "Purificateur valarjar",
	valarjar_shieldmaiden = "Vierge guerrière valarjar",
	valarjar_aspirant = "Aspirante valarjar",
	solsten = "Solsten",
	olmyr = "Olmyr l’Éclairé",
	valarjar_marksman = "Tireuse d’élite valarjar",
	gildedfur_stag = "Cerf fourrure-dorée",
	angerhoof_bull = "Taureau sabot-furieux",
	valarjar_trapper = "Trappeur valarjar",
	fourkings = "Les quatre rois",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	--custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter.",
	opera_hall_wikket_story_text = "Opéra : Lokdu",
	--opera_hall_wikket_story_trigger = "Shut your jabber", -- Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "Opéra : De l’amour à la mer",
	--opera_hall_westfall_story_trigger = "we meet two lovers", -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	opera_hall_beautiful_beast_story_text = "Opéra : La belle bête",
	--opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage", -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	barnes = "Barnes",
	ghostly_philanthropist = "Philanthrope fantomatique",
	skeletal_usher = "Ouvreur squelettique",
	spectral_attendant = "Domestique spectral",
	spectral_valet = "Valet spectral",
	spectral_retainer = "Factotum spectral",
	phantom_guardsman = "Garde fantôme",
	wholesome_hostess = "Hôtesse saine",
	reformed_maiden = "Damoiselle repentie",
	spectral_charger = "Destrier spectral",

	-- Return to Karazhan: Upper
	chess_event = "Évènement de l’échiquier",
	king = "Roi",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "Contrôle des foules",
	cc_desc = "CàR et alertes pour les contrôles de foule sur les invités.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "Plaie-de-Nuit",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "Garde des âmes saumâtre",
	champion = "Champion helarjar",
	mariner = "Marin de la garde de nuit",
	swiftblade = "Vivelame maudit par les flots",
	mistmender = "Soignebrume maudite par les flots",
	mistcaller = "Mandebrume helarjar",
	skjal = "Skjal",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	--rokmora_first_warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!",
	--rokmora_second_warmup_trigger = "Either way, I will enjoy every moment of it. Rokmora, crush them!",

	vileshard_crawler = "Rampante vil-éclat",
	tarspitter_lurker = "Rôdeur crache-goudron",
	rockback_gnasher = "Mâcheur pierre-peau",
	vileshard_hulk = "Mastodonte vil-éclat",
	vileshard_chunk = "Bris vil-éclat",
	understone_drummer = "Batteur pierre-basse",
	mightstone_breaker = "Briseur pierre-puissance",
	blightshard_shaper = "Sculpteur éclat-chancreux",
	stoneclaw_grubmaster = "Maître des larves pierre-griffe",
	tarspitter_grub = "Larve crache-goudron",
	rotdrool_grabber = "Saisisseur bave-pourrie",
	understone_demolisher = "Démolisseur pierre-basse",
	rockbound_trapper = "Trappeur pierre-lié",
	emberhusk_dominator = "Dominateur braise-chitine",
})

BigWigsAPI.SetBossModuleLocale("Ularogg Cragshaper", {
	hands = "Mains", -- Short for "Stone Hands"
})

-- Seat of the Triumvirate

BigWigsAPI.SetBossModuleLocale("Viceroy Nezhar", {
	guards = "Gardes",
	interrupted = "%s a interrompu %s (%.1fs restant) !",
})

BigWigsAPI.SetBossModuleLocale("L'ura", {
	warmup_text = "L'ura actif",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	--custom_on_autotalk_desc = "Instantly selects Alleria Winrunners gossip option.",
	--gossip_available = "Gossip available",
	--alleria_gossip_trigger = "Follow me!", -- Allerias yell after the first boss is defeated
	--lura_warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before.",
	--lura_warmup_trigger_2 = "Such musings can wait, though. This entity must die.",

	alleria = "Alleria Coursevent",
	subjugator = "Subjugateur ombre-garde",
	voidbender = "Arqueur du Vide ombre-garde",
	conjurer = "Adjuratrice ombre-garde",
	weaver = "Grand tisseur d'ombre",

	-- Midnight+
	void_rifts_closed = "Faille du Vide fermée",
	void_rifts_closed_desc = "Affiche une alerte lorsqu'une faille du Vide est fermée.",
})

-- The Arcway

BigWigsAPI.SetBossModuleLocale("The Arcway Trash", {
	anomaly = "Anomalie arcanique",
	shade = "Ombre dimensionnelle",
	wraith = "Ame en peine de mana flétrie",
	blade = "Gangrelame garde-courroux",
	chaosbringer = "Porte-chaos érédar",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "Kick Combo",

	light_dropped = "%s a laissé tomber la Lumière.",
	light_picked = "%s a ramassé la Lumière.",

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
