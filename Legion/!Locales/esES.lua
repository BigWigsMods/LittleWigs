-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "Tugar Tótem Sangriento",
	jormog = "Jormog el Behemoth",

	--remaining = "Scales Remaining",

	--submerge = "Submerge",
	--submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes.",

	--charge_desc = "When Jormog is submerged, he will periodically charge in your direction.",

	--rupture = "{243382} (X)",
	--rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it.",

	--totem_warning = "The totem hit you!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "Raest Lanzamágica",

	--handFromBeyond = "Hand from Beyond",

	--rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn.",

	--warmup_text = "Karam Magespear Active",
	--warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!",
	--warmup_trigger2 = "Kill this interloper, brother!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "Alto señor Kruul",
	inquisitor = "Inquisidor Variss",
	velen = "Profeta Velen",

	--warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!",
	--win_trigger = "So be it. You will not stand in our way any longer.",

	--nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations.",

	--smoldering_infernal = "Smoldering Infernal",
	--smoldering_infernal_desc = "Summons a Smoldering Infernal.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "Lord Erdris Espina",

	--warmup_trigger = "Your arrival is well-timed.",
	--warmup_trigger2 = "What's... happening?", --Stage 5 Warm up

	mage = "Mago resucitado corrupto",
	soldier = "Soldado resucitado corrupto",
	arbalest = "Arbalesta resucitada corrupta",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "Archimago Xylem",
	corruptingShadows = "Sombra corruptora",

	--warmup_trigger1 = "With the Focusing Iris under my control", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--warmup_trigger2 = "Drained of magic, your world will be ripe", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "Agatha",
	imp_servant = "Sirviente diablillo",
	fuming_imp = "Diablillo humeante",
	levia = "Levia", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!", -- 35
	--warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!", -- 16
	--warmup_trigger3 = "But first, you must be punished for taking away my little pet.", -- 3

	--stacks = "Stacks",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "Sigryn",
	jarl = "Jarl Velbrand",
	faljar = "Vidente de runas Faljar",

	--warmup_trigger = "What's this? The outsider has come to stop me?",
})

-- Assault on Violet Hold

BigWigsAPI.SetBossModuleLocale("Assault on Violet Hold Trash", {
	custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de la Teniente Sinclari para empezar el Asalto en el Bastión Violeta.",
	keeper = "Vigilante de portal",
	guardian = "Guardián de portal",
	infernal = "Infernal llameante",
})

BigWigsAPI.SetBossModuleLocale("Thalena", {
	essence = "Esencia",
})

-- Black Rook Hold

BigWigsAPI.SetBossModuleLocale("Black Rook Hold Trash", {
	ghostly_retainer = "Criado fantasmal",
	ghostly_protector = "Protector fantasmal",
	ghostly_councilor = "Consejero fantasmal",
	lord_etheldrin_ravencrest = "Lord Etheldrin Cresta Cuervo",
	lady_velandras_ravencrest = "Lady Velandras Cresta Cuervo",
	rook_spiderling = "Arañita del torreón",
	soultorn_champion = "Campeón infausto",
	risen_scout = "Explorador resucitado",
	risen_archer = "Arquera resucitada",
	risen_arcanist = "Arcanista resucitado",
	wyrmtongue_scavenger = "Carroñero Lenguavermis",
	bloodscent_felhound = "Can manáfago Sangresencia",
	felspite_dominator = "Dominador Flemavil",
	risen_swordsman = "Espadachín resucitado",
	risen_lancer = "Lancero resucitado",

	door_open_desc = "Muestra una barra que indica cuando se abre la puerta hacia el Pasadizo secreto.",
})

BigWigsAPI.SetBossModuleLocale("Kurtalos Ravencrest", {
	phase_2_trigger = "¡Basta! Me estoy cansando.",
})

-- Cathedral of Eternal Night

BigWigsAPI.SetBossModuleLocale("Mephistroth", {
	custom_on_time_lost = "Tiempo perdido en Oculto en las sombras",
	custom_on_time_lost_desc = "Muestra el tiempo perdido en Oculto en las sombras en la barra |cffff0000red|r.",
	time_lost = "%s |cffff0000(+%ds)|r",
})

BigWigsAPI.SetBossModuleLocale("Domatrax", {
	custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de la Égida de Aggramar para empezar el encuentro con Domatrax.",

	missing_aegis = "No estás dentro de la Égida",
	aegis_healing = "Égida: Sanación realizada reducida",
	aegis_damage = "Égida: Daño infligido reducido",
})

BigWigsAPI.SetBossModuleLocale("Cathedral of Eternal Night Trash", {
	dulzak = "Dul'zak",
	wrathguard = "Invasor guardia de cólera",
	felguard = "Destructor guardia vil",
	soulmender = "Ensalmador de almas Llama Infernal",
	temptress = "Tentadora Llama Infernal",
	botanist = "Botanista vilificada",
	orbcaster = "Lanzaorbes Zancavil",
	waglur = "Wa'glur",
	scavenger = "Carroñero Lenguavermis",
	gazerax = "Avizorax",
	vilebark = "Caminante Cortezavil",

	throw_tome = "Lanzar escrito", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "Avizor Vigía del ocaso",
	duskwatch_reinforcement = "Refuerzo de los Vigías del ocaso",
	Guard = "Guardia Vigía del ocaso",
	Construct = "Ensamblaje guardián",
	Enforcer = "Déspota de vínculo vil",
	Hound = "Can de la Legión",
	Mistress = "Señora de las Sombras",
	Gerenth = "Gerenth el Vil",
	Jazshariu = "Jazshariu",
	Imacutya = "Imacu'tya",
	Baalgar = "Baalgar el Vigilante",
	Inquisitor = "Inquisidor vigilante",
	BlazingImp = "Diablillo llameante",
	Energy = "Energía contenida",
	Manifestation = "Manifestación Arcana",
	Wyrm = "Vermis de maná",
	Arcanist = "Arcanista Vigía del ocaso",
	InfernalImp = "Diablillo infernal",
	Malrodi = "Arcanista Malrodi",
	Velimar = "Velimar",
	ArcaneKeys = "Llaves Arcanas",
	clues = "Pistas",

	InfernalTome = "Tomo infernal",
	MagicalLantern = "Farol mágico",
	NightshadeRefreshments = "Refrigerios Sombranoche",
	StarlightRoseBrew = "Cerveza de rosa luz estelar",
	UmbralBloom = "Flor umbría",
	WaterloggedScroll = "Pergamino encharcado",
	BazaarGoods = "Objetos del Bazar",
	LifesizedNightborneStatue = "Estatua Nocheterna a tamaño real",
	DiscardedJunk = "Chatarra desechada",
	WoundedNightborneCivilian = "Civil Nocheterna herido",

	announce_buff_items = "Anuncia los buffs de los objetos", --Announce buff items
	announce_buff_items_desc = "Anuncia los buffs disponibles de los objetos alrededor de la mazmorra y quién los puede utilizar.", --Anounces all available buff items around the dungeon and who is able to use them.

	available = "%s|cffffffff%s|r disponible", -- Context: item is available to use
	usableBy = "puede ser utilizado por %s", -- Context: item is usable by someone

	custom_on_use_buff_items = "Usa al instante el buff de los objetos.", -- Instantly use buff items
	custom_on_use_buff_items_desc = "Activa esta opción para usar instantáneamente los buffs de los objetos alrededor de la mazmorra. Esto no será usado en los objetos que amenazan a los guardias antes del segundo jefe.", --Enable this options to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss.

	spy_helper = "Asistente para el evento del espía",
	spy_helper_desc = "Muestra una plantilla de información con todas las pistas que el grupo haya reunido sobre el espía. Las pistas también serán enviadas a tus miembros de grupo en el chat.", --Shows an InfoBox with all clues your group gathered about the spy. The clues will also be send to your party members in chat.

	clueFound = "Pista hallada (%d/5): |cffffffff%s|r",
	spyFound = "Espía encontrado por %s!",
	spyFoundChat = "¡Encontré al espía!",
	spyFoundPattern = "Bueno, bueno, no nos precipitemos", -- Bueno, bueno, no nos precipitemos. ¿Y si me acompañas para poder discutirlo en un ambiente más privado...?

	hints = {
		[1] = "Capa",
		[2] = "Sin capa",
		[3] = "Faltriquera",
		[4] = "Pociones",
		[5] = "Mangas largas",
		[6] = "Mangas cortas",
		[7] = "Guantes",
		[8] = "Sin guantes",
		[9] = "Hombre",
		[10] = "Mujer",
		[11] = "Jubón claro",
		[12] = "Jubón oscuro",
		[13] = "Sin pociones",
		[14] = "Libro",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	warmup_trigger = "Un fracaso más, Melandrus. Esta es tu oportunidad de corregirlo. Deshazte de estos intrusos. Debo regresar al Bastión Nocturno.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	archdruid_glaidalis_warmup_trigger = "Corruptores... Huelo la pesadilla en vuestra sangre. ¡Abandonad estos bosques o sufrid la ira de la naturaleza!",

	mindshattered_screecher = "Estridador Mentequebrada",
	dreadsoul_ruiner = "Arruinador Almaespanto",
	dreadsoul_poisoner = "Envenenador Almaespanto",
	crazed_razorbeak = "Picovaja enloquecido",
	festerhide_grizzly = "Oso pardo con piel supurante",
	vilethorn_blossom = "Flor Espinavil",
	rotheart_dryad = "Dríade Corazón infecto",
	rotheart_keeper = "Vigilante Corazón Infecto",
	nightmare_dweller = "Habitante de la Pesadilla",
	bloodtainted_fury = "Furia manchada de sangre",
	bloodtainted_burster = "Reventador manchado de sangre",
	taintheart_summoner = "Invocador Corazón Ruin",
	dreadfire_imp = "Diablillo de fuego aterrador",
	tormented_bloodseeker = "Buscasangre atormentado",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	throw = "Lanzar",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "Retador Espiral de Odio",
	stormweaver = "Tejetormentas Espiral de Odio",
	crusher = "Triturador Espiral de Odio",
	oracle = "Oráculo Espiral de Odio",
	siltwalker = "Caminante de limo de Mak'rana",
	tides = "Mareas inquietas",
	arcanist = "Arcanista Espiral de Odio",
})

BigWigsAPI.SetBossModuleLocale("Lady Hatecoil", {
	custom_on_show_helper_messages = "Mensajes de ayuda para Nova estática y Relámpago enfocado",
	custom_on_show_helper_messages_desc = "Activa esta opción para añadir un mensaje de ayuda diciéndote si el agua o la arena es segura cuando el jefe esté lanzando |cff71d5ffNova estática|r o |cff71d5ffRelámpago enfocado|r.",

	water_safe = "%s (el agua es segura)",
	land_safe = "%s (la arena es segura)",
})

-- Halls of Valor

BigWigsAPI.SetBossModuleLocale("Odyn", {
	gossip_available = "Conversación disponible",
	gossip_trigger = "Impresionante. Nunca pensé que encontraría a alguien capaz de igualar la fuerza de los Valajar... pero aquí estáis.",

	[197963] = "|cFF800080Arriba derecha|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Right"
	[197964] = "|cFFFFA500Abajo derecha|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Right"
	[197965] = "|cFFFFFF00Abajo izquierda|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Left"
	[197966] = "|cFF0000FFArriba izquierda|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Left"
	[197967] = "|cFF008000Arriba|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top"
})

BigWigsAPI.SetBossModuleLocale("God-King Skovald", {
	warmup_text = "Rey dios Skovald activo",
	warmup_trigger = "Los triunfadores  ya han tomado posesión de ella, Skovald, pues tal era su derecho. Llegas demasiado tarde.",
	warmup_trigger_2 = "Si estos falsos campeones no me entregan la égida por propia voluntad... ¡será mía cuando mueran!",
})

BigWigsAPI.SetBossModuleLocale("Halls of Valor Trash", {
	mug_of_mead = "Jarra de hidromiel",
	valarjar_thundercaller = "Clamatruenos Valarjar",
	storm_drake = "Draco de tormenta",
	stormforged_sentinel = "Centinela Tronaforjado",
	valarjar_runecarver = "Grabador de runas Valarjar",
	valarjar_mystic = "Místico Valarjar",
	valarjar_purifier = "Purificador Valarjar",
	valarjar_shieldmaiden = "Doncella escudera Valarjar",
	valarjar_aspirant = "Aspirante Valarjar",
	solsten = "Solsten",
	olmyr = "Olmyr el Iluminado",
	valarjar_marksman = "Tiradora Valarjar",
	gildedfur_stag = "Venado de pelaje dorado",
	angerhoof_bull = "Astado Uñainquina",
	valarjar_trapper = "Trampero Valarjar",
	fourkings = "Los cuatro reyes",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de Barnes para comenzar el encuentro de la Sala de Ópera.",
	opera_hall_wikket_story_text = "Sala de la Ópera: Makaku",
	opera_hall_wikket_story_trigger = "¡Cierra el piko", -- ¡Cierra el piko, miko dramas! ¡El Rey Mono domina el panorama! / Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "Sala de la Ópera: Historia de Poniente",
	opera_hall_westfall_story_trigger = "conoceremos a dos amantes", -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	opera_hall_beautiful_beast_story_text = "Sala de la Ópera: Bella Bestia",
	opera_hall_beautiful_beast_story_trigger = "una historia de amor y rabia", -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	barnes = "Barnes",
	ghostly_philanthropist = "Filántropo fantasmal",
	skeletal_usher = "Ujier esquelético",
	spectral_attendant = "Auxiliar espectral",
	spectral_valet = "Ayuda de cámara espectral",
	spectral_retainer = "Criado espectral",
	phantom_guardsman = "Aparición de custodio",
	wholesome_hostess = "Anfitriona saludable",
	reformed_maiden = "Doncella reformada",
	spectral_charger = "Destrero espectral",

	-- Return to Karazhan: Upper
	chess_event = "Evento del Ajedrez",
	king = "Rey",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "Control de masas",
	cc_desc = "Temporizadores y alertas de control de masas en los invitados de la cena.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "Nocturno",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "Guardián de almas calado",
	champion = "Campeón Helarjar",
	mariner = "Marino de la Guardia Nocturna",
	swiftblade = "Hojágil maldecido por el mar",
	mistmender = "Curanieblas maldecida por el mar",
	mistcaller = "Clamaneblina Helarjar",
	skjal = "Skjal",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	rokmora_first_warmup_trigger = "¿Navarrogg?! ¡Traidor! ¿Osas liderar a los intrusos contra nosotros?",
	rokmora_second_warmup_trigger = "Pase lo que pase, pienso disfrutarlo. Rokmora, ¡acaba con ellos!",

	vileshard_crawler = "Reptador Pizcavil",
	tarspitter_lurker = "Rondador Escupebrea",
	rockback_gnasher = "Rechinador Rocalomo",
	vileshard_hulk = "Mole Pizcavil",
	vileshard_chunk = "Kacho Pizcavil",
	understone_drummer = "Tamborilero Sotopiedra",
	mightstone_breaker = "Rompedor Piedra de Poderío",
	blightshard_shaper = "Modelador Pizcañublo",
	stoneclaw_grubmaster = "Domalarvas Garrapétrea",
	tarspitter_grub = "Larva Escupebrea",
	rotdrool_grabber = "Agarrador Babapútrida",
	understone_demolisher = "Demoledor Sotopiedra",
	rockbound_trapper = "Trampero ligarroca",
	emberhusk_dominator = "Dominador Caparabrasa",
})

BigWigsAPI.SetBossModuleLocale("Ularogg Cragshaper", {
	hands = "Manos", -- Short for "Stone Hands"
})

-- Seat of the Triumvirate

BigWigsAPI.SetBossModuleLocale("Viceroy Nezhar", {
	guards = "Guardias",
	interrupted = "¡%s interrumpió %s (%.1fs restantes)!",
})

BigWigsAPI.SetBossModuleLocale("L'ura", {
	warmup_text = "L'ura activada",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de Alleria Brisaveloz.",
	gossip_available = "Conversación disponible",
	alleria_gossip_trigger = "¡Venid por aquí!", -- Allerias yell after the first boss is defeated
	lura_warmup_trigger = "Cuánto caos y cuánto tormento... Jamás había sentido algo parecido.",
	lura_warmup_trigger_2 = "Pero esas reflexiones pueden esperar. Esta entidad debe morir.",

	alleria = "Alleria Brisaveloz",
	subjugator = "Subyugador de la Guardia de las Sombras",
	voidbender = "Dominadora del Vacío de la Guardia de las Sombras",
	conjurer = "Conjuradora de la Guardia de las Sombras",
	weaver = "Gran tejesombras",

	-- Midnight+
	--void_rifts_closed = "Void Rifts Closed",
	--void_rifts_closed_desc = "Show an alert when a Void Rift has been closed.",
})

-- The Arcway

BigWigsAPI.SetBossModuleLocale("The Arcway Trash", {
	anomaly = "Anomalía Arcana",
	shade = "Sombra de distorsión",
	wraith = "Espectro de maná Marchito",
	blade = "Guardia de cólera hoja mácula",
	chaosbringer = "Portador de caos eredar",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "Combo de Patadas",

	light_dropped = "%s tiró la Luz.",
	light_picked = "%s cogió la Luz.",

	warmup_trigger = "Ya tengo lo que quería, pero me he quedado para poder acabar con vosotros... de una vez por todas.",
	warmup_trigger_2 = "Y ahora, habéis caído en mi trampa. A ver cómo os desenvolvéis en la oscuridad.",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	warmup_trigger = "Serviré a mi gente: ¡los exiliados y los agravados!",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	infester = "Infestador jurapenas",
	myrmidon = "Mirmidón jurapenas",
	fury = "Furia imbuida de vileza",
	mother = "Madre hedionda",
	illianna = "Bailarina de hojas Illiana",
	mendacius = "Señor del Terror Mendacius",
	grimhorn = "Cuernomacabro el Esclavista",
})
