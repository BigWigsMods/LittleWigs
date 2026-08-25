-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "Тугар Кровавый Тотем",
	jormog = "Йормог Чудовищный",

	--remaining = "Scales Remaining",

	--submerge = "Submerge",
	--submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes.",

	--charge_desc = "When Jormog is submerged, he will periodically charge in your direction.",

	--rupture = "{243382} (X)",
	--rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it.",

	--totem_warning = "The totem hit you!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "Рейст Волшебное Копье",

	--handFromBeyond = "Hand from Beyond",

	--rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn.",

	--warmup_text = "Karam Magespear Active",
	--warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!",
	--warmup_trigger2 = "Kill this interloper, brother!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "Верховный лорд Круул",
	inquisitor = "Инквизитор Варисс",
	velen = "Пророк Велен",

	--warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!",
	--win_trigger = "So be it. You will not stand in our way any longer.",

	--nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations.",

	--smoldering_infernal = "Smoldering Infernal",
	--smoldering_infernal_desc = "Summons a Smoldering Infernal.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "Лорд Эрдрис Терновый Шип",

	--warmup_trigger = "Your arrival is well-timed.",
	--warmup_trigger2 = "What's... happening?", --Stage 5 Warm up

	mage = "Зараженный восставший маг",
	soldier = "Зараженный восставший солдат",
	arbalest = "Зараженная восставшая лучница",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "Верховный маг Ксилем",
	corruptingShadows = "Гибельная тень",

	--warmup_trigger1 = "With the Focusing Iris under my control", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--warmup_trigger2 = "Drained of magic, your world will be ripe", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "Агата",
	imp_servant = "Бес-прислужник",
	fuming_imp = "Тлеющий бес",
	levia = "Левия", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!", -- 35
	--warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!", -- 16
	--warmup_trigger3 = "But first, you must be punished for taking away my little pet.", -- 3

	stacks = "Стаки",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "Сигрин",
	jarl = "Ярл Вельбранд",
	faljar = "Руновидец Фальяр",

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
	ghostly_retainer = "Фантомный вельможа",
	ghostly_protector = "Фантомный защитник",
	ghostly_councilor = "Фантомный советник",
	lord_etheldrin_ravencrest = "Лорд Этелдрин Гребень Ворона",
	lady_velandras_ravencrest = "Леди Веландра Гребень Ворона",
	rook_spiderling = "Паучонок из крепости Черной Ладьи",
	soultorn_champion = "Лишенный души защитник",
	risen_scout = "Восставший разведчик",
	risen_archer = "Восставшая лучница",
	risen_arcanist = "Восставший чародей",
	wyrmtongue_scavenger = "Змееуст-барахольщик",
	bloodscent_felhound = "Кровожадная гончая Скверны",
	felspite_dominator = "Злобный покоритель Скверны",
	risen_swordsman = "Восставший мечник",
	risen_lancer = "Восставший копейщик",

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
	dulzak = "Дул'зак",
	--wrathguard = "Wrathguard Invader",
	felguard = "Страж Скверны - разрушитель",
	soulmender = "Врачеватель душ адского огня",
	temptress = "Искусительница адского огня",
	botanist = "Присягнувшая Скверне - ботаник",
	orbcaster = "Сквернолап - метательница сфер",
	waglur = "Ва'глур",
	scavenger = "Змееуст-барахольщик",
	gazerax = "Созерцатель",
	vilebark = "Ходячий гиблодрев",

	--throw_tome = "Throw Tome", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "Часовой из Сумеречной стражи",
	duskwatch_reinforcement = "Резервист из Сумеречной стражи",
	Guard = "Караульный из Сумеречной стражи",
	Construct = "Голем-страж",
	Enforcer = "Порабощенная Скверной карательница",
	Hound = "Гончая Легиона",
	Mistress = "Владычица теней",
	Gerenth = "Герент Зловещий",
	Jazshariu = "Джазшариу",
	Imacutya = "Имаку'туя",
	Baalgar = "Баалгар Бдительный ",
	Inquisitor = "Бдительный инквизитор",
	BlazingImp = "Пылающий бес",
	Energy = "Обузданная энергия",
	Manifestation = "Проявление магии",
	Wyrm = "Маназмей",
	Arcanist = "Чародей из Сумеречной Стражи",
	InfernalImp = "Инфернальный бес",
	Malrodi = "Чародей Малроди",
	Velimar = "Велимар",
	ArcaneKeys = "Чародейский ключ",
	clues = "Подсказки",

	InfernalTome = "Инфернальный фолиант",
	MagicalLantern = "Магический светильник",
	NightshadeRefreshments = "Закуски ночной тени",
	StarlightRoseBrew = "Отвар из звездной розы",
	UmbralBloom = "Теневой цветок",
	WaterloggedScroll = "Промокший свиток",
	BazaarGoods = "Рыночные товары",
	LifesizedNightborneStatue = "Статуя ночнорожденного в натуральную величину",
	DiscardedJunk = "Выброшенный хлам",
	WoundedNightborneCivilian = "Раненый ночнорожденный",

	announce_buff_items = "Объявление о диверсионных механизмах",
	announce_buff_items_desc = "Объявляет все доступные в подземелье механизмы для совершения диверсии и кто может их использовать.",

	available = "Доступен предмет %s|cffffffff%s|r", -- Context: item is available to use
	usableBy = "могут использовать %s", -- Context: item is usable by someone

	custom_on_use_buff_items = "Автоматически использовать диверсионный механизм",
	custom_on_use_buff_items_desc = "Включите эту опцию, чтобы автоматически использовать диверсионные механизмы в подземелье. Эта опция не будет автоматически использовать механизмы, призывающие охранников второго босса.",

	spy_helper = "Помощник в поиске шпиона",
	spy_helper_desc = "Показывает InfoBox Показывает InfoBox со всеми подсказками, которые нашла ваша группа. Подсказки также будут отправлены в групповой чат.",

	clueFound = "Подсказка найдена (%d/5): |cffffffff%s|r",
	spyFound = "Шпион найден игроком %s!",
	spyFoundChat = "Шпион найден!",
	spyFoundPattern = "Ну-ну", -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	hints = {
		[1] = "С накидкой",
		[2] = "Без накидки",
		[3] = "Кошель",
		[4] = "Зелья",
		[5] = "Длинные рукава",
		[6] = "Короткие рукава",
		[7] = "В перчатках",
		[8] = "Без перчаток",
		[9] = "Мужчина",
		[10] = "Женщина",
		[11] = "Светлый жилет",
		[12] = "Темный жилет",
		[13] = "Без зелий",
		[14] = "Книга",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	warmup_trigger = "Меландр, ты снова подвел меня, но ты можешь исправиться. Избавься от этих чужаков! Я возвращаюсь в Цитадель Ночи.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	--archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!",

	mindshattered_screecher = "Бешеная визгунья",
	dreadsoul_ruiner = "Грозный разрушитель",
	dreadsoul_poisoner = "Грозный отравитель",
	crazed_razorbeak = "Обезумевший остроклюв",
	festerhide_grizzly = "Гноешкурый гризли",
	vilethorn_blossom = "Цветущий злошип",
	rotheart_dryad = "Гнилосердная дриада",
	rotheart_keeper = "Гнилосердный хранитель",
	nightmare_dweller = "Обитатель Кошмара",
	bloodtainted_fury = "Оскверненная кровью ярость",
	bloodtainted_burster = "Оскверненный кровью взрывень",
	taintheart_summoner = "Скверносерд-призыватель",
	dreadfire_imp = "Бес ужасающего огня",
	tormented_bloodseeker = "Истерзанный кровопийца",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	--throw = "Throw",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "Ловчий из клана Колец Ненависти",
	stormweaver = "Заклинательница штормов из клана Колец Ненависти",
	crusher = "Мирмидон из клана Колец Ненависти",
	oracle = "Оракул из клана Колец Ненависти",
	siltwalker = "Ходульник Мак'раны",
	tides = "Неутомимая волна",
	arcanist = "Колдунья из клана Колец Ненависти",
})

BigWigsAPI.SetBossModuleLocale("Lady Hatecoil", {
	--custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning",
	--custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r.",

	--water_safe = "%s (water is safe)",
	--land_safe = "%s (land is safe)",
})

-- Halls of Valor

BigWigsAPI.SetBossModuleLocale("Odyn", {
	gossip_available = "Разговор доступен",
	gossip_trigger = "Удивительно! Я не верил, что кто-то может сравниться с валарьярами... Но вы доказали, что это возможно.",

	[197963] = "|cFF800080Право Верх|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Right"
	[197964] = "|cFFFFA500Право Низ|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Right"
	[197965] = "|cFFFFFF00Лево Низ|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Left"
	[197966] = "|cFF0000FFЛево Верх|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Left"
	[197967] = "|cFF008000Верх|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top"
})

BigWigsAPI.SetBossModuleLocale("God-King Skovald", {
	warmup_text = "Король-бог Сковальд активен",
	warmup_trigger = "Сковальд, эти герои завладели Эгидой по праву. Уже поздно что-либо оспаривать.",
	warmup_trigger_2 = "Или эти псевдогерои сами отдадут Эгиду... Или я вырву ее из их мертвых рук!",
})

BigWigsAPI.SetBossModuleLocale("Halls of Valor Trash", {
	mug_of_mead = "Кружка меда",
	valarjar_thundercaller = "Валарьяр - призыватель молний",
	storm_drake = "Штормовой дракон",
	stormforged_sentinel = "Закаленный бурей страж",
	valarjar_runecarver = "Валарьяр - резчик рун",
	valarjar_mystic = "Валарьяр-мистик",
	valarjar_purifier = "Валарьяр-очиститель",
	valarjar_shieldmaiden = "Валарьяр - дева щита",
	valarjar_aspirant = "Валарьяр-претендентка",
	solsten = "Солстен",
	olmyr = "Олмир Просвещенный",
	valarjar_marksman = "Валарьяр-лучница",
	gildedfur_stag = "Золотистый олень",
	angerhoof_bull = "Сердитый бык",
	valarjar_trapper = "Валарьяр-зверолов",
	fourkings = "Четыре Короля",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	--custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter.",
	opera_hall_wikket_story_text = "Оперный зал: Злюкер",
	--opera_hall_wikket_story_trigger = "Shut your jabber", -- Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "Оперный зал: Однажды в Западном Крае",
	opera_hall_westfall_story_trigger = "Они родились по разные стороны Сторожевого холма.",
	opera_hall_beautiful_beast_story_text = "Оперный зал: Красавица и Зверь",
	opera_hall_beautiful_beast_story_trigger = "Эта история о любви и гневе навсегда поставит точку в вопросе, обманчива ли красота.",

	-- Return to Karazhan: Lower
	barnes = "Барнс",
	ghostly_philanthropist = "Бестелесный филантроп",
	skeletal_usher = "Гниющий билетер",
	spectral_attendant = "Призрачный смотритель",
	spectral_valet = "Призрачный служитель",
	spectral_retainer = "Призрачный эконом",
	phantom_guardsman = "Фантомный стражник",
	wholesome_hostess = "Благонравная горничная",
	reformed_maiden = "Исправившаяся дева",
	spectral_charger = "Призрачный конь",

	-- Return to Karazhan: Upper
	chess_event = "Шахматы",
	king = "Король",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "управление толпой",
	--cc_desc = "Timers and alerts for crowd control on the dinner guests.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "Ночная Погибель",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "Промокший насквозь страж душ",
	champion = "Хеларьяр-защитник",
	mariner = "Моряк из Ночного дозора",
	swiftblade = "Проклятый морем молниеносный клинок",
	mistmender = "Проклятая морем целительница туманов",
	mistcaller = "Хеларьяр - призывательница туманов",
	skjal = "Скьял",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	rokmora_first_warmup_trigger = "Наваррогг?! Предатель, ты привел к нам чужаков?!",
	rokmora_second_warmup_trigger = "Меня устроят оба варианта! Рокмора, убей их!",

	vileshard_crawler = "Злобнозем-ползун",
	tarspitter_lurker = "Смолоплюй-ползун",
	rockback_gnasher = "Камнеспинный щелкозуб",
	vileshard_hulk = "Злобнозем-исполин",
	vileshard_chunk = "Злобнозем-глыба",
	understone_drummer = "Барабанщик из Подкаменного разлома",
	mightstone_breaker = "Крушитель из племени Камня Силы",
	blightshard_shaper = "Заклинатель чумных осколков",
	stoneclaw_grubmaster = "Камнерукий повелитель личинок",
	tarspitter_grub = "Личинка смолоплюя",
	rotdrool_grabber = "Гнилослюнный червь",
	understone_demolisher = "Разрушитель из Подкаменного разлома",
	rockbound_trapper = "Скальный зверолов",
	emberhusk_dominator = "Углепанцирный подчинитель",
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
	warmup_text = "Л'ура активна",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	--custom_on_autotalk_desc = "Instantly selects Alleria Winrunners gossip option.",
	--gossip_available = "Gossip available",
	--alleria_gossip_trigger = "Follow me!", -- Allerias yell after the first boss is defeated
	lura_warmup_trigger = "Такой хаос... такая боль. Я еще не чувствовала ничего подобного.",
	lura_warmup_trigger_2 = "Впрочем, неважно. Она должна умереть.",

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
	anomaly = "Волшебная аномалия",
	shade = "Искаженная тень",
	wraith = "Иссохший - магический призрак",
	blade = "Страж гнева - клинок Скверны",
	chaosbringer = "Эредарский вестник хаоса",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "Комбо удар",

	light_dropped = "%s выронил Свет.",
	light_picked = "%s поднял Свет.",

	warmup_trigger = "Я уже получила то, за чем пришла. Но осталась, чтобы покончить с вами… раз и навсегда!",
	warmup_trigger_2 = "И вы угодили в мою ловушку. Посмотрим, на что вы способны в темноте.",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	--warmup_trigger = "I will serve MY people, the exiled and the reviled.",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	infester = "Скверноподданный заразитель",
	myrmidon = "Скверноподданный мирмидон",
	fury = "Зараженный Скверной яростный боец",
	--mother = "Foul Mother",
	illianna = "Иллиана Танцующая с Клинками",
	mendacius = "Повелитель ужаса Мендаций",
	grimhorn = "Злобнорог Поработитель",
})
