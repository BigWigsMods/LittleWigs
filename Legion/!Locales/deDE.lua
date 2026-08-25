-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "Tugar Bluttotem",
	jormog = "Jormog das Ungetüm",

	remaining = "Verbleibende Schuppen",

	submerge = "Untertauchen",
	submerge_desc = "Taucht unter den Boden und beschwört Spuckereier und fallende Stacheln.",

	charge_desc = "Während Jormog untergetaucht ist, stürmt er regelmäßig in Deine Richtung.",

	rupture = "{243382} (X)",
	rupture_desc = "Ein X-förmiger Teufelsriss erscheint unter Dir. Nach 5 Sekunden reißt er den Boden auf, wobei Stacheln aus dem Boden schießen und auf ihnen befindliche Spieler zurückstoßen.",

	totem_warning = "Das Totem trifft Dich!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "Raest Magusspeer",

	handFromBeyond = "Hand aus den Weiten",

	rune_desc = "Platziert eine Beschwörungsrune auf dem Boden. Wenn diese nicht gesoaked wird, erscheint eine Ausgeburt des Alptraums.",

	warmup_text = "Karam Magusspeer aktiv",
	warmup_trigger = "Es war dumm, mir zu folgen, Bruder. Der Wirbelnde Nether verleiht mir ungeahnte Macht. Ich bin stärker, als du es dir jemals hättest vorstellen können!",
	warmup_trigger2 = "Töte diesen Eindringling, Bruder!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "Hochlord Kruul",
	inquisitor = "Inquisitor Variss",
	velen = "Prophet Velen",

	warmup_trigger = "Arrogantes Pack! Ich trage die Seelen von tausend unterworfenen Welten in mir!",
	win_trigger = "So sei es. Ihr werdet uns nicht länger im Weg stehen.",

	nether_aberration_desc = "Beschwört im Raum verteilt Portale, aus denen Netherschrecken erscheinen.",

	smoldering_infernal = "Qualmende Höllenbestie",
	smoldering_infernal_desc = "Beschwört eine Qualmende Höllenbestie.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "Lord Erdris Dorn",

	warmup_trigger = "Ihr kommt gerade zur rechten Zeit.",
	warmup_trigger2 = "Was... passiert?", --Stage 5 Warm up

	mage = "Verderbter auferstandener Magier",
	soldier = "Verderbter auferstandener Soldat",
	arbalest = "Verderbte auferstandene Armbrustschützin",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "Erzmagier Xylem",
	corruptingShadows = "Verderbende Schatten",

	warmup_trigger1 = "Mit der fokussierenden Iris kann ich die arkane Energie", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	warmup_trigger2 = "Ihrer Magie beraubt wird diese Welt", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "Agatha",
	imp_servant = "Wichteldiener",
	fuming_imp = "Rauchender Wichtel",
	levia = "Levia", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	warmup_trigger1 = "Ihr kommt zu spät! Levias Macht gehört mir! Meine Diener werden ihr Wissen nutzen, um die Kirin Tor zu unterwandern und sie aus dem Inneren zu zerstören.", -- 35
	warmup_trigger2 = "Meine Sayaad bringen Eure schwachen Magier bereits in Versuchung. Eure Verbündeten werden sich widerstandslos der Legion beugen.", -- 16
	warmup_trigger3 = "Doch zuerst werde ich Euch dafür bestrafen, mir meine kleine Sklavin genommen zu haben.", -- 3

	stacks = "Stapel",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "Sigryn",
	jarl = "Jarl Velbrand",
	faljar = "Runenseher Faljar",

	warmup_trigger = "Wie? Der Fremdling kommt, mich aufzuhalten?",
})

-- Assault on Violet Hold

BigWigsAPI.SetBossModuleLocale("Assault on Violet Hold Trash", {
	custom_on_autotalk_desc = "Wählt direkt Leutnant Sinclaris Dialogoption zum Starten des Sturms auf die Violette Festung.",
	keeper = "Portalhüter",
	guardian = "Portalwächter",
	infernal = "Lodernde Höllenbestie",
})

BigWigsAPI.SetBossModuleLocale("Thalena", {
	essence = "Essenz",
})

-- Black Rook Hold

BigWigsAPI.SetBossModuleLocale("Black Rook Hold Trash", {
	ghostly_retainer = "Geisterhafter Gefolgsmann",
	ghostly_protector = "Geisterhafter Beschützer",
	ghostly_councilor = "Geisterhafter Berater",
	lord_etheldrin_ravencrest = "Lord Etheldrin Rabenkrone",
	lady_velandras_ravencrest = "Lady Velandras Rabenkrone",
	rook_spiderling = "Rabenspinnling",
	soultorn_champion = "Seelengeschändeter Champion",
	risen_scout = "Auferstandener Späher",
	risen_archer = "Auferstandene Bogenschützin",
	risen_arcanist = "Auferstandener Arkanist",
	wyrmtongue_scavenger = "Wyrmzungenplünderer",
	bloodscent_felhound = "Blutwitternder Teufelshund",
	felspite_dominator = "Teufelsgrollunterwerfer",
	risen_swordsman = "Auferstandener Schwertkämpfer",
	risen_lancer = "Auferstandener Lanzer",

	door_open_desc = "Zeigt eine Leiste wann die Tür zum versteckten Durchgang geöffnet ist.",
})

BigWigsAPI.SetBossModuleLocale("Kurtalos Ravencrest", {
	phase_2_trigger = "Es reicht! Genug der Scharade.",
})

-- Cathedral of Eternal Night

BigWigsAPI.SetBossModuleLocale("Mephistroth", {
	custom_on_time_lost = "Verlorene Zeit während Schattenverblassen",
	custom_on_time_lost_desc = "Zeigt die verlorene Zeit während Schattenverblassen in der Leiste in |cffff0000red|r.",
	time_lost = "%s |cffff0000(+%ds)|r",
})

BigWigsAPI.SetBossModuleLocale("Domatrax", {
	custom_on_autotalk_desc = "Wählt direkt Aegis von Aggramars Dialogoption um den Kampf gegen Domatrax zu starten.",

	missing_aegis = "Du stehst nicht im Aegis", -- Aegis is a short name for Aegis of Aggramar
	aegis_healing = "Aegis: Reduzierte Heilung",
	aegis_damage = "Aegis: Reduzierter verursachter Schaden",
})

BigWigsAPI.SetBossModuleLocale("Cathedral of Eternal Night Trash", {
	dulzak = "Dul'zak",
	wrathguard = "Einfallender Zornwächter",
	felguard = "Zerstörer der Teufelswache",
	soulmender = "Höllenglutseelenheiler",
	temptress = "Höllenglutverführerin",
	botanist = "Teufelsgeborene Botanikerin",
	orbcaster = "Sphärenwirker der Teufelsschreiter",
	waglur = "Wa'glur",
	scavenger = "Wyrmzungenplünderer",
	gazerax = "Gazerax",
	vilebark = "Übelrindenläufer",

	throw_tome = "Folianten werfen", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "Wächter der Dämmerwache",
	duskwatch_reinforcement = "Verstärkung der Dämmerwache",
	Guard = "Wachposten der Dämmerwache",
	Construct = "Wächterkonstrukt",
	Enforcer = "Dämonenversklavte Vollstreckerin",
	Hound = "Legionshund",
	Mistress = "Schattenmeisterin",
	Gerenth = "Verdächtiger Adliger",
	Jazshariu = "Jazshariu",
	Imacutya = "Imacu'tya",
	Baalgar = "Baalgar der Wachsame",
	Inquisitor = "Wachsamer Inquisitor",
	BlazingImp = "Lodernder Wichtel",
	Energy = "Gebundene Energie",
	Manifestation = "Arkane Manifestation",
	Wyrm = "Manawyrm",
	Arcanist = "Arkanist der Dämmerwache",
	InfernalImp = "Höllenwichtel",
	Malrodi = "Arkanistin Malrodi",
	Velimar = "Velimar",
	ArcaneKeys = "Arkane Schlüssel",
	clues = "Hinweise",

	InfernalTome = "Höllischer Foliant",
	MagicalLantern = "Magische Laterne",
	NightshadeRefreshments = "Nachtschattenerfrischungen",
	StarlightRoseBrew = "Sternlichtrosenbräu",
	UmbralBloom = "Umbralblüte",
	WaterloggedScroll = "Durchnässte Schriftrolle",
	BazaarGoods = "Basarwaren",
	LifesizedNightborneStatue = "Lebensgroße Nachtgeborenenstatue",
	DiscardedJunk = "Ausrangierter Schrott",
	WoundedNightborneCivilian = "Verwundeter Zivilist der Nachtgeborenen",

	announce_buff_items = "Buff-Items bekanntgeben",
	announce_buff_items_desc = "Gibt bekannt, welche verfügbaren Buff-Items in der Instanz vorhanden sind und wer sie benutzen kann.",

	available = "%s|cffffffff%s|r vorhanden", -- Context: item is available to use
	usableBy = "benutzbar von %s", -- Context: item is usable by someone

	custom_on_use_buff_items = "Buff-Items sofort benutzen",
	custom_on_use_buff_items_desc = "Durch die Aktivierung dieser Option werden die Buff-Items beim anklicken sofort benutzt, ausgenommen derjenigen, die eine der drei Botschafter des zweiten Bosses rufen.",

	spy_helper = "Spion Event Helfer",
	spy_helper_desc = "Zeigt eine Infobox mit allen Hinweisen über den Spion an. Diese Hinweise werden ebenfalls im Chat an deine Gruppe geschickt.",

	clueFound = "Hinweise gefunden (%d/5): |cffffffff%s|r",
	spyFound = "Der Spion wurde von %s gefunden!",
	spyFoundChat = "Ich habe den Spion gefunden!",
	spyFoundPattern = "Na, na, wir wollen doch nicht voreilig sein", -- Na, na, wir wollen doch nicht voreilig sein, [player]. Wieso folgt Ihr mir nicht, damit wir in etwas privaterer Umgebung darüber sprechen können...

	hints = {
		[1] = "Umhang",
		[2] = "Kein Umhang",
		[3] = "Geldbeutel",
		[4] = "Fläschchen",
		[5] = "Lange Ärmel",
		[6] = "Kurze Ärmel",
		[7] = "Handschuhe",
		[8] = "Keine Handschuhe",
		[9] = "Männlich",
		[10] = "Weiblich",
		[11] = "Helle Weste",
		[12] = "Dunkle Weste",
		[13] = "Kein Fläschchen",
		[14] = "Buch",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	warmup_trigger = "Eine weitere Fehlleistung, Melandrus. Aber Ihr könnt es wiedergutmachen. Vernichtet die Eindringlinge. Ich muss zurück zur Nachtfestung.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	archdruid_glaidalis_warmup_trigger = "Entweiher... ich wittere den Alptraum in Eurem Blut. Verschwindet aus diesem Wald oder spürt den Zorn der Natur!",

	mindshattered_screecher = "Gebrochener Kreischer",
	dreadsoul_ruiner = "Verheerer der Schreckensseele",
	dreadsoul_poisoner = "Vergifter der Schreckensseele",
	crazed_razorbeak = "Wahnsinniger Klingenschnabel",
	festerhide_grizzly = "Eiterpelzgrizzly",
	vilethorn_blossom = "Garststachelblüte",
	rotheart_dryad = "Moderherzdryade",
	rotheart_keeper = "Moderherzbewahrer",
	nightmare_dweller = "Alptraumbewohner",
	bloodtainted_fury = "Blutbesudelter Zornbrodler",
	bloodtainted_burster = "Blutbesudelter Sprudler",
	taintheart_summoner = "Pestherzbeschwörer",
	dreadfire_imp = "Schreckensfeuerwichtel",
	tormented_bloodseeker = "Gequälter Blutsucher",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	throw = "Wurf",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "Zänker der Hassnattern",
	stormweaver = "Sturmwirkerin der Hassnattern",
	crusher = "Zermalmer der Hassnattern",
	oracle = "Orakel der Hassnattern",
	siltwalker = "Treibsandläufer der Mak'rana",
	tides = "Aufgewühlte Fluten",
	arcanist = "Arkanistin der Hassnattern",
})

BigWigsAPI.SetBossModuleLocale("Lady Hatecoil", {
	custom_on_show_helper_messages = "Hinweis für Statische Nova und Gebündelter Blitz",
	custom_on_show_helper_messages_desc = "Wenn diese Option aktiviert ist, wird ein Hinweis angezeigt, welcher beinhaltet ob das Wasser oder Land sicher ist wenn der Boss |cff71d5ffStatische Nova|r oder |cff71d5ffGebündelter Blitz|r wirkt.",

	water_safe = "%s (Wasser ist sicher)",
	land_safe = "%s (Land ist sicher)",
})

-- Halls of Valor

BigWigsAPI.SetBossModuleLocale("Odyn", {
	gossip_available = "Dialog verfügbar",
	gossip_trigger = "Höchst beeindruckend! Ich hielt die Kräfte der Valarjar stets für unerreicht... und dennoch steht Ihr hier vor mir.",

	[197963] = "|cFF800080Oben rechts|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Right"
	[197964] = "|cFFFFA500Unten rechts|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Right"
	[197965] = "|cFFFFFF00Unten links|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Left"
	[197966] = "|cFF0000FFOben links|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Left"
	[197967] = "|cFF008000Oben|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top"
})

BigWigsAPI.SetBossModuleLocale("God-King Skovald", {
	warmup_text = "Gottkönig Skovald aktiv",
	warmup_trigger = "Die Sieger haben ihren Anspruch geltend gemacht, Skovald, wie es ihr Recht ist. Euer Protest kommt zu spät.",
	warmup_trigger_2 = "Wenn sie die Aegis nicht aus freien Stücken übergeben... dann soll ihr Tod mir diesen Dienst erweisen!",
})

BigWigsAPI.SetBossModuleLocale("Halls of Valor Trash", {
	mug_of_mead = "Metkrug",
	valarjar_thundercaller = "Donnerrufer der Valarjar",
	storm_drake = "Sturmdrache",
	stormforged_sentinel = "Sturmgeschmiedeter Wächter",
	valarjar_runecarver = "Runenmetz der Valarjar",
	valarjar_mystic = "Mystiker der Valarjar",
	valarjar_purifier = "Läuterer der Valarjar",
	valarjar_shieldmaiden = "Schildmaid der Valarjar",
	valarjar_aspirant = "Aspirantin der Valarjar",
	solsten = "Solsten",
	olmyr = "Olmyr der Erleuchtete",
	valarjar_marksman = "Schützin der Valarjar",
	gildedfur_stag = "Goldfellhirsch",
	angerhoof_bull = "Zornhufbulle",
	valarjar_trapper = "Fallensteller der Valarjar",
	fourkings = "Die Vier Könige",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	custom_on_autotalk_desc = "Wählt direkt Barnes' Dialogoption zum Starten des Bosskampfes im Opernsaal.",
	opera_hall_wikket_story_text = "Opernsaal: Wikket",
	opera_hall_wikket_story_trigger = "Halt die Gotsche", -- Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "Opernsaal: Westfall Story",
	opera_hall_westfall_story_trigger = "treffen wir auf zwei Liebende", -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	opera_hall_beautiful_beast_story_text = "Opernsaal: Das schöne Biest",
	opera_hall_beautiful_beast_story_trigger = "eine Geschichte von Romantik und Wut", -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	barnes = "Barnes",
	ghostly_philanthropist = "Geisterhafter Philanthrop",
	skeletal_usher = "Skelettpförtner",
	spectral_attendant = "Spektraler Knecht",
	spectral_valet = "Spektraldiener",
	spectral_retainer = "Spektraler Anhänger",
	phantom_guardsman = "Phantomgardist",
	wholesome_hostess = "Sittsame Schankmaid",
	reformed_maiden = "Reformierte Jungfer",
	spectral_charger = "Spektrales Streitross",

	-- Return to Karazhan: Upper
	chess_event = "Das Schachspiel",
	king = "König",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "Massenkontrolle",
	cc_desc = "Timer und Warnungen für die Massenkontrolle auf den Essensgästen.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "Schrecken der Nacht",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "Aufgedunsene Seelenwache",
	champion = "Champion der Helarjar",
	mariner = "Matrosennachtwächter",
	swiftblade = "Meeresfluchschnellklinge",
	mistmender = "Meeresfluchnebelheilerin",
	mistcaller = "Nebelruferin der Helarjar",
	skjal = "Skjal",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	rokmora_first_warmup_trigger = "Navarrogg?! Verräter! Ihr führt diese Eindringlinge gegen uns ins Feld?!",
	rokmora_second_warmup_trigger = "Sei's drum, ich werde jeden Moment davon genießen. Rokmora, zerschmettert sie!",

	vileshard_crawler = "Ekelsplitterkriecher",
	tarspitter_lurker = "Teerspuckerlauerer",
	rockback_gnasher = "Steinrückenknirscher",
	vileshard_hulk = "Ekelsplittergigant",
	vileshard_chunk = "Ekelsplitterbrocken",
	understone_drummer = "Hämmerer des Tiefgesteins",
	mightstone_breaker = "Machtsteinbrecher",
	blightshard_shaper = "Pestsplitterformer",
	stoneclaw_grubmaster = "Steinklauenlarvenmeister",
	tarspitter_grub = "Teerspuckerlarve",
	rotdrool_grabber = "Rottspeichelschnapper",
	understone_demolisher = "Demolierer des Tiefgesteins",
	rockbound_trapper = "Steingebundener Fallensteller",
	emberhusk_dominator = "Glutpanzerdominator",
})

BigWigsAPI.SetBossModuleLocale("Ularogg Cragshaper", {
	hands = "Hände", -- Short for "Stone Hands"
})

-- Seat of the Triumvirate

BigWigsAPI.SetBossModuleLocale("Viceroy Nezhar", {
	guards = "Hüter",
	interrupted = "%s unterbrach %s (%.1fs übrig)!",
})

BigWigsAPI.SetBossModuleLocale("L'ura", {
	warmup_text = "L'ura aktiv",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	custom_on_autotalk_desc = "Wählt direkt Alleria Windläufers Dialogoption.",
	gossip_available = "Dialog verfügbar",
	alleria_gossip_trigger = "Folgt mir!", -- Allerias yell after the first boss is defeated
	lura_warmup_trigger = "Dieses Chaos... diese Qualen. Etwas Derartiges habe ich noch nie gespürt.",
	lura_warmup_trigger_2 = "Derlei Gedanken können jetzt warten. Dieses Wesen muss sterben.",

	alleria = "Alleria Windläufer",
	subjugator = "Unterwerfer der Schattenwache",
	voidbender = "Leerenformer der Schattenwache",
	conjurer = "Beschwörer der Schattenwache",
	weaver = "Großschattenwirker",

	-- Midnight+
	void_rifts_closed = "Leerenrisse geschlossen",
	void_rifts_closed_desc = "Zeigt einen Alarm, wenn ein Leerenriss geschlossen wurde.",
})

-- The Arcway

BigWigsAPI.SetBossModuleLocale("The Arcway Trash", {
	anomaly = "Arkananomalie",
	shade = "Warpschemen",
	wraith = "Verdorrtes Managespenst",
	blade = "Teufelsklinge der Zornwächter",
	chaosbringer = "Chaosbringer der Eredar",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "Kick Combo",

	light_dropped = "%s hat das Licht fallen gelassen.",
	light_picked = "%s hat das Licht aufgenommen.",

	warmup_trigger = "Ich habe, wofür ich gekommen bin. Doch ich wollte Euch noch persönlich ein Ende setzen... ein für alle Mal.",
	warmup_trigger_2 = "Und jetzt sitzt Ihr Narren in meiner Falle. Sehen wir mal, wie Ihr im Dunkeln zurechtkommt.",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	warmup_trigger = "Ich diene MEINEM Volk, den Vertriebenen und Verstoßenen.",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	infester = "Verseucher des Dämonenpakts",
	myrmidon = "Myrmidone des Dämonenpakts",
	fury = "Teufelsberauschter Wüter",
	mother = "Üble Mutter",
	illianna = "Klingentänzerin Illianna",
	mendacius = "Schreckenslord Mendacius",
	grimhorn = "Grimmhorn der Versklaver",
})
