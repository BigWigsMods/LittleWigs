-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "ruRU")
if L then
	L.tugar = "Тугар Кровавый Тотем"
	L.jormog = "Йормог Чудовищный"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "ruRU")
if L then
	L.name = "Рейст Волшебное Копье"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "ruRU")
if L then
	L.name = "Верховный лорд Круул"
	L.inquisitor = "Инквизитор Варисс"
	L.velen = "Пророк Велен"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "ruRU")
if L then
	L.erdris = "Лорд Эрдрис Терновый Шип"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Зараженный восставший маг"
	L.soldier = "Зараженный восставший солдат"
	L.arbalest = "Зараженная восставшая лучница"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "ruRU")
if L then
	L.name = "Верховный маг Ксилем"
	L.corruptingShadows = "Гибельная тень"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "ruRU")
if L then
	L.name = "Агата"
	L.imp_servant = "Бес-прислужник"
	L.fuming_imp = "Тлеющий бес"
	L.levia = "Левия" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	--L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	--L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.stacks = "Стаки"
end

L = BigWigs:NewBossLocale("Sigryn", "ruRU")
if L then
	L.sigryn = "Сигрин"
	L.jarl = "Ярл Вельбранд"
	L.faljar = "Руновидец Фальяр"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "ruRU")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold."
	--L.keeper = "Portal Keeper"
	--L.guardian = "Portal Guardian"
	--L.infernal = "Blazing Infernal"
end

L = BigWigs:NewBossLocale("Thalena", "ruRU")
if L then
	--L.essence = "Essence"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "ruRU")
if L then
	L.ghostly_retainer = "Фантомный вельможа"
	L.ghostly_protector = "Фантомный защитник"
	L.ghostly_councilor = "Фантомный советник"
	L.lord_etheldrin_ravencrest = "Лорд Этелдрин Гребень Ворона"
	L.lady_velandras_ravencrest = "Леди Веландра Гребень Ворона"
	L.rook_spiderling = "Паучонок из крепости Черной Ладьи"
	L.soultorn_champion = "Лишенный души защитник"
	L.risen_scout = "Восставший разведчик"
	L.risen_archer = "Восставшая лучница"
	L.risen_arcanist = "Восставший чародей"
	L.wyrmtongue_scavenger = "Змееуст-барахольщик"
	L.bloodscent_felhound = "Кровожадная гончая Скверны"
	L.felspite_dominator = "Злобный покоритель Скверны"
	L.risen_swordsman = "Восставший мечник"
	L.risen_lancer = "Восставший копейщик"

	--L.door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "ruRU")
if L then
	--L.phase_2_trigger = "Enough! I tire of this."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "ruRU")
if L then
	--L.custom_on_time_lost = "Time lost during Shadow Fade"
	--L.custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "ruRU")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "ruRU")
if L then
	L.dulzak = "Дул'зак"
	--L.wrathguard = "Wrathguard Invader"
	L.felguard = "Страж Скверны - разрушитель"
	L.soulmender = "Врачеватель душ адского огня"
	L.temptress = "Искусительница адского огня"
	L.botanist = "Присягнувшая Скверне - ботаник"
	L.orbcaster = "Сквернолап - метательница сфер"
	L.waglur = "Ва'глур"
	L.scavenger = "Змееуст-барахольщик"
	L.gazerax = "Созерцатель"
	L.vilebark = "Ходячий гиблодрев"

	--L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "ruRU")
if L then
	L.duskwatch_sentry = "Часовой из Сумеречной стражи"
	L.duskwatch_reinforcement = "Резервист из Сумеречной стражи"
	L.Guard = "Караульный из Сумеречной стражи"
	L.Construct = "Голем-страж"
	L.Enforcer = "Порабощенная Скверной карательница"
	L.Hound = "Гончая Легиона"
	L.Mistress = "Владычица теней"
	L.Gerenth = "Герент Зловещий"
	L.Jazshariu = "Джазшариу"
	L.Imacutya = "Имаку'туя"
	L.Baalgar = "Баалгар Бдительный "
	L.Inquisitor = "Бдительный инквизитор"
	L.BlazingImp = "Пылающий бес"
	L.Energy = "Обузданная энергия"
	L.Manifestation = "Проявление магии"
	L.Wyrm = "Маназмей"
	L.Arcanist = "Чародей из Сумеречной Стражи"
	L.InfernalImp = "Инфернальный бес"
	L.Malrodi = "Чародей Малроди"
	L.Velimar = "Велимар"
	L.ArcaneKeys = "Чародейский ключ"
	L.clues = "Подсказки"

	L.InfernalTome = "Инфернальный фолиант"
	L.MagicalLantern = "Магический светильник"
	L.NightshadeRefreshments = "Закуски ночной тени"
	L.StarlightRoseBrew = "Отвар из звездной розы"
	L.UmbralBloom = "Теневой цветок"
	L.WaterloggedScroll = "Промокший свиток"
	L.BazaarGoods = "Рыночные товары"
	L.LifesizedNightborneStatue = "Статуя ночнорожденного в натуральную величину"
	L.DiscardedJunk = "Выброшенный хлам"
	L.WoundedNightborneCivilian = "Раненый ночнорожденный"

	L.announce_buff_items = "Объявление о диверсионных механизмах"
	L.announce_buff_items_desc = "Объявляет все доступные в подземелье механизмы для совершения диверсии и кто может их использовать."

	L.available = "Доступен предмет %s|cffffffff%s|r" -- Context: item is available to use
	L.usableBy = "могут использовать %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Автоматически использовать диверсионный механизм"
	L.custom_on_use_buff_items_desc = "Включите эту опцию, чтобы автоматически использовать диверсионные механизмы в подземелье. Эта опция не будет автоматически использовать механизмы, призывающие охранников второго босса."

	L.spy_helper = "Помощник в поиске шпиона"
	L.spy_helper_desc = "Показывает InfoBox Показывает InfoBox со всеми подсказками, которые нашла ваша группа. Подсказки также будут отправлены в групповой чат."

	L.clueFound = "Подсказка найдена (%d/5): |cffffffff%s|r"
	L.spyFound = "Шпион найден игроком %s!"
	L.spyFoundChat = "Шпион найден!"
	L.spyFoundPattern = "Ну-ну" -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	L.hints[1] = "С накидкой"
	L.hints[2] = "Без накидки"
	L.hints[3] = "Кошель"
	L.hints[4] = "Зелья"
	L.hints[5] = "Длинные рукава"
	L.hints[6] = "Короткие рукава"
	L.hints[7] = "В перчатках"
	L.hints[8] = "Без перчаток"
	L.hints[9] = "Мужчина"
	L.hints[10] = "Женщина"
	L.hints[11] = "Светлый жилет"
	L.hints[12] = "Темный жилет"
	L.hints[13] = "Без зелий"
	L.hints[14] = "Книга"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "ruRU")
if L then
	L.warmup_trigger = "Меландр, ты снова подвел меня, но ты можешь исправиться. Избавься от этих чужаков! Я возвращаюсь в Цитадель Ночи."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "ruRU")
if L then
	--L.archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!"

	L.mindshattered_screecher = "Бешеная визгунья"
	L.dreadsoul_ruiner = "Грозный разрушитель"
	L.dreadsoul_poisoner = "Грозный отравитель"
	L.crazed_razorbeak = "Обезумевший остроклюв"
	L.festerhide_grizzly = "Гноешкурый гризли"
	L.vilethorn_blossom = "Цветущий злошип"
	L.rotheart_dryad = "Гнилосердная дриада"
	L.rotheart_keeper = "Гнилосердный хранитель"
	L.nightmare_dweller = "Обитатель Кошмара"
	L.bloodtainted_fury = "Оскверненная кровью ярость"
	L.bloodtainted_burster = "Оскверненный кровью взрывень"
	L.taintheart_summoner = "Скверносерд-призыватель"
	L.dreadfire_imp = "Бес ужасающего огня"
	L.tormented_bloodseeker = "Истерзанный кровопийца"
end

L = BigWigs:NewBossLocale("Oakheart", "ruRU")
if L then
	--L.throw = "Throw"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "ruRU")
if L then
	L.wrangler = "Ловчий из клана Колец Ненависти"
	L.stormweaver = "Заклинательница штормов из клана Колец Ненависти"
	L.crusher = "Мирмидон из клана Колец Ненависти"
	L.oracle = "Оракул из клана Колец Ненависти"
	L.siltwalker = "Ходульник Мак'раны"
	L.tides = "Неутомимая волна"
	L.arcanist = "Колдунья из клана Колец Ненависти"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "ruRU")
if L then
	--L.custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning"
	--L.custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r."

	--L.water_safe = "%s (water is safe)"
	--L.land_safe = "%s (land is safe)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "ruRU")
if L then
	L.gossip_available = "Разговор доступен"
	L.gossip_trigger = "Удивительно! Я не верил, что кто-то может сравниться с валарьярами... Но вы доказали, что это возможно."

	L[197963] = "|cFF800080Право Верх|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500Право Низ|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00Лево Низ|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FFЛево Верх|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000Верх|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "ruRU")
if L then
	L.warmup_text = "Король-бог Сковальд активен"
	L.warmup_trigger = "Сковальд, эти герои завладели Эгидой по праву. Уже поздно что-либо оспаривать."
	L.warmup_trigger_2 = "Или эти псевдогерои сами отдадут Эгиду... Или я вырву ее из их мертвых рук!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "ruRU")
if L then
	L.mug_of_mead = "Кружка меда"
	L.valarjar_thundercaller = "Валарьяр - призыватель молний"
	L.storm_drake = "Штормовой дракон"
	L.stormforged_sentinel = "Закаленный бурей страж"
	L.valarjar_runecarver = "Валарьяр - резчик рун"
	L.valarjar_mystic = "Валарьяр-мистик"
	L.valarjar_purifier = "Валарьяр-очиститель"
	L.valarjar_shieldmaiden = "Валарьяр - дева щита"
	L.valarjar_aspirant = "Валарьяр-претендентка"
	L.solsten = "Солстен"
	L.olmyr = "Олмир Просвещенный"
	L.valarjar_marksman = "Валарьяр-лучница"
	L.gildedfur_stag = "Золотистый олень"
	L.angerhoof_bull = "Сердитый бык"
	L.valarjar_trapper = "Валарьяр-зверолов"
	L.fourkings = "Четыре Короля"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "ruRU")
if L then
	-- Opera Event
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Оперный зал: Злюкер"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Оперный зал: Однажды в Западном Крае"
	L.opera_hall_westfall_story_trigger = "Они родились по разные стороны Сторожевого холма."
	L.opera_hall_beautiful_beast_story_text = "Оперный зал: Красавица и Зверь"
	L.opera_hall_beautiful_beast_story_trigger = "Эта история о любви и гневе навсегда поставит точку в вопросе, обманчива ли красота."

	-- Return to Karazhan: Lower
	L.barnes = "Барнс"
	L.ghostly_philanthropist = "Бестелесный филантроп"
	L.skeletal_usher = "Гниющий билетер"
	L.spectral_attendant = "Призрачный смотритель"
	L.spectral_valet = "Призрачный служитель"
	L.spectral_retainer = "Призрачный эконом"
	L.phantom_guardsman = "Фантомный стражник"
	L.wholesome_hostess = "Благонравная горничная"
	L.reformed_maiden = "Исправившаяся дева"
	L.spectral_charger = "Призрачный конь"

	-- Return to Karazhan: Upper
	L.chess_event = "Шахматы"
	L.king = "Король"
end

L = BigWigs:NewBossLocale("Moroes", "ruRU")
if L then
	L.cc = "управление толпой"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "ruRU")
if L then
	L.name = "Ночная Погибель"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "ruRU")
if L then
	L.soulguard = "Промокший насквозь страж душ"
	L.champion = "Хеларьяр-защитник"
	L.mariner = "Моряк из Ночного дозора"
	L.swiftblade = "Проклятый морем молниеносный клинок"
	L.mistmender = "Проклятая морем целительница туманов"
	L.mistcaller = "Хеларьяр - призывательница туманов"
	L.skjal = "Скьял"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "ruRU")
if L then
	L.rokmora_first_warmup_trigger = "Наваррогг?! Предатель, ты привел к нам чужаков?!"
	L.rokmora_second_warmup_trigger = "Меня устроят оба варианта! Рокмора, убей их!"

	L.vileshard_crawler = "Злобнозем-ползун"
	L.tarspitter_lurker = "Смолоплюй-ползун"
	L.rockback_gnasher = "Камнеспинный щелкозуб"
	L.vileshard_hulk = "Злобнозем-исполин"
	L.vileshard_chunk = "Злобнозем-глыба"
	L.understone_drummer = "Барабанщик из Подкаменного разлома"
	L.mightstone_breaker = "Крушитель из племени Камня Силы"
	L.blightshard_shaper = "Заклинатель чумных осколков"
	L.stoneclaw_grubmaster = "Камнерукий повелитель личинок"
	L.tarspitter_grub = "Личинка смолоплюя"
	L.rotdrool_grabber = "Гнилослюнный червь"
	L.understone_demolisher = "Разрушитель из Подкаменного разлома"
	L.rockbound_trapper = "Скальный зверолов"
	L.emberhusk_dominator = "Углепанцирный подчинитель"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "ruRU")
if L then
	--L.hands = "Hands" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "ruRU")
if L then
	--L.guards = "Guards"
	--L.interrupted = "%s interrupted %s (%.1fs left)!"
end

L = BigWigs:NewBossLocale("L'ura", "ruRU")
if L then
	L.warmup_text = "Л'ура активна"
	L.warmup_trigger = "Такой хаос... такая боль. Я еще не чувствовала ничего подобного."
	L.warmup_trigger_2 = "Впрочем, неважно. Она должна умереть."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "ruRU")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects Alleria Winrunners gossip option."
	--L.gossip_available = "Gossip available"
	--L.alleria_gossip_trigger = "Follow me!" -- Allerias yell after the first boss is defeated

	--L.alleria = "Alleria Windrunner"
	--L.subjugator = "Shadowguard Subjugator"
	--L.voidbender = "Shadowguard Voidbender"
	--L.conjurer = "Shadowguard Conjurer"
	--L.weaver = "Grand Shadow-Weaver"
end

-- The Arcway

L = BigWigs:NewBossLocale("The Arcway Trash", "ruRU")
if L then
	L.anomaly = "Волшебная аномалия"
	L.shade = "Искаженная тень"
	L.wraith = "Иссохший - магический призрак"
	L.blade = "Страж гнева - клинок Скверны"
	L.chaosbringer = "Эредарский вестник хаоса"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "ruRU")
if L then
	L.kick_combo = "Комбо удар"

	L.light_dropped = "%s выронил Свет."
	L.light_picked = "%s поднял Свет."

	L.warmup_trigger = "Я уже получила то, за чем пришла. Но осталась, чтобы покончить с вами… раз и навсегда!"
	L.warmup_trigger_2 = "И вы угодили в мою ловушку. Посмотрим, на что вы способны в темноте."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "ruRU")
if L then
	--L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "ruRU")
if L then
	L.infester = "Скверноподданный заразитель"
	L.myrmidon = "Скверноподданный мирмидон"
	L.fury = "Зараженный Скверной яростный боец"
	--L.mother = "Foul Mother"
	L.illianna = "Иллиана Танцующая с Клинками"
	L.mendacius = "Повелитель ужаса Мендаций"
	L.grimhorn = "Злобнорог Поработитель"
end
