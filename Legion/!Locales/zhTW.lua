-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	--tugar = "Tugar Bloodtotem",
	--jormog = "Jormog the Behemoth",

	--remaining = "Scales Remaining",

	--submerge = "Submerge",
	--submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes.",

	--charge_desc = "When Jormog is submerged, he will periodically charge in your direction.",

	--rupture = "{243382} (X)",
	--rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it.",

	--totem_warning = "The totem hit you!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	--name = "Raest Magespear",

	--handFromBeyond = "Hand from Beyond",

	--rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn.",

	--warmup_text = "Karam Magespear Active",
	--warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!",
	--warmup_trigger2 = "Kill this interloper, brother!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	--name = "Highlord Kruul",
	--inquisitor = "Inquisitor Variss",
	--velen = "Prophet Velen",

	--warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!",
	--win_trigger = "So be it. You will not stand in our way any longer.",

	--nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations.",

	--smoldering_infernal = "Smoldering Infernal",
	--smoldering_infernal_desc = "Summons a Smoldering Infernal.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	--erdris = "Lord Erdris Thorn",

	--warmup_trigger = "Your arrival is well-timed.",
	--warmup_trigger2 = "What's... happening?", --Stage 5 Warm up

	--mage = "Corrupted Risen Mage",
	--soldier = "Corrupted Risen Soldier",
	--arbalest = "Corrupted Risen Arbalest",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	--name = "Archmage Xylem",
	--corruptingShadows = "Corrupting Shadows",

	--warmup_trigger1 = "With the Focusing Iris under my control", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--warmup_trigger2 = "Drained of magic, your world will be ripe", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	--name = "Agatha",
	--imp_servant = "Imp Servant",
	--fuming_imp = "Fuming Imp",
	--levia = "Levia", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!", -- 35
	--warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!", -- 16
	--warmup_trigger3 = "But first, you must be punished for taking away my little pet.", -- 3

	--stacks = "Stacks",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	--sigryn = "Sigryn",
	--jarl = "Jarl Velbrand",
	--faljar = "Runenseher Faljar",

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
	ghostly_retainer = "鬼魅侍從",
	ghostly_protector = "鬼魅保衛者",
	ghostly_councilor = "鬼魅參事",
	lord_etheldrin_ravencrest = "埃賽德林．黑羽",
	lady_velandras_ravencrest = "維蘭卓斯．黑羽女士",
	rook_spiderling = "玄鴉幼蛛",
	soultorn_champion = "喪魂勇士",
	risen_scout = "復活的斥候",
	risen_archer = "復活的弓箭手",
	risen_arcanist = "復活的祕法師",
	wyrmtongue_scavenger = "蟲舌魔拾荒者",
	bloodscent_felhound = "血腥惡魔犬",
	felspite_dominator = "魔恨支配者",
	risen_swordsman = "復活的劍兵",
	risen_lancer = "復活的矛兵",

	door_open_desc = "顯示開啟通往密道門的計時條。",
})

BigWigsAPI.SetBossModuleLocale("Kurtalos Ravencrest", {
	phase_2_trigger = "夠了！我不耐煩了。",
})

-- Cathedral of Eternal Night

BigWigsAPI.SetBossModuleLocale("Mephistroth", {
	custom_on_time_lost = "黑暗漸隱期間計時器",
	custom_on_time_lost_desc = "將黑暗漸隱持續時間的計時器顯示為|cffff0000紅色|r。",
	--time_lost = "%s |cffff0000(+%ds)|r",
})

BigWigsAPI.SetBossModuleLocale("Domatrax", {
	--custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter.",

	--missing_aegis = "You're not standing in Aegis", -- Aegis is a short name for Aegis of Aggramar
	--aegis_healing = "Aegis: Reduced Healing Done",
	--aegis_damage = "Aegis: Reduced Damage Done",
})

BigWigsAPI.SetBossModuleLocale("Cathedral of Eternal Night Trash", {
	--dulzak = "Dul'zak",
	--wrathguard = "Wrathguard Invader",
	felguard = "惡魔守衛摧毀者",
	soulmender = "獄炎魔能使者",
	temptress = "獄炎妖女",
	botanist = "魔裔植物學家",
	orbcaster = "獄炎補魂者",
	--waglur = "Wa'glur",
	--scavenger = "Wyrmtongue Scavenger",
	gazerax = "賈澤拉克斯",
	--vilebark = "Vilebark Walker",

	--throw_tome = "Throw Tome", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	--duskwatch_sentry = "Duskwatch Sentry",
	--duskwatch_reinforcement = "Duskwatch Reinforcement",
	Guard = "暮衛守衛",
	Construct = "守護者傀儡",
	Enforcer = "魔縛執行者",
	Hound = "燃燒軍團獵犬",
	--Mistress = "Shadow Mistress",
	Gerenth = "『鄙惡者』葛任斯",
	Jazshariu = "賈茲夏魯",
	Imacutya = "伊瑪庫緹雅",
	Baalgar = "『警戒者』包爾加",
	Inquisitor = "警戒的審判官",
	BlazingImp = "熾炎小鬼",
	Energy = "束縛能量",
	Manifestation = "秘法化身",
	Wyrm = "法力龍鰻",
	Arcanist = "暮衛祕法師",
	InfernalImp = "熾炎小鬼",
	Malrodi = "祕法化身",
	Velimar = "威利瑪",
	ArcaneKeys = "祕法鑰匙",
	clues = "線索",

	InfernalTome = "煉獄秘典",
	MagicalLantern = "魔法燈籠",
	NightshadeRefreshments = "夜影餐點",
	StarlightRoseBrew = "星輝玫瑰酒",
	UmbralBloom = "暗影之花",
	WaterloggedScroll = "浸水的卷軸",
	BazaarGoods = "市集商品",
	LifesizedNightborneStatue = "等身大小的夜裔雕像",
	DiscardedJunk = "拋棄的雜物",
	WoundedNightborneCivilian = "受傷的夜裔平民",

	announce_buff_items = "通告增益物品",
	announce_buff_items_desc = "通告此地城所有可用的增益物品，並通告誰可以使用。",

	available = "%s|cffffffff%s|r可用", -- Context: item is available to use
	usableBy = "使用者：%s", -- Context: item is usable by someone

	custom_on_use_buff_items = "立即使用增益物品",
	custom_on_use_buff_items_desc = "啟用此選項後，自動確認使用物品前的對話選項並使用物品，這不包含二王前使用會引來守衛的物品。",

	spy_helper = "間諜事件助手",
	spy_helper_desc = "在一個訊息視窗內顯示隊伍得到間諜的線索，並通告線索給其他隊員。",

	clueFound = "找到第%d/5條線索：|cffffffff%s|r",
	spyFound = "間諜被%s找到了！",
	spyFoundChat = "我找到間諜了，快來！",
	spyFoundPattern = "別太快下定論。", -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	hints = {
		[1] = "斗篷",
		[2] = "沒有斗蓬",
		[3] = "腰袋",
		[4] = "藥水瓶",
		[5] = "長袖",
		[6] = "短袖",
		[7] = "手套",
		[8] = "沒有手套",
		[9] = "男性",
		[10] = "女性",
		[11] = "淺色上衣",
		[12] = "深色上衣",
		[13] = "無藥水瓶",
		[14] = "書本",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	--warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	archdruid_glaidalis_warmup_trigger = "污染者…我能聞到你血液裡的夢魘。離開這片林地，否則就面對大自然的憤怒吧！",

	mindshattered_screecher = "碎心尖嘯鴞",
	dreadsoul_ruiner = "懼魂毀滅者",
	dreadsoul_poisoner = "懼魂投毒者",
	crazed_razorbeak = "瘋狂的鋒喙角鷹獸",
	festerhide_grizzly = "瘡皮灰熊",
	vilethorn_blossom = "惡刺蘭花",
	rotheart_dryad = "腐心林精",
	rotheart_keeper = "腐心看守者",
	nightmare_dweller = "夢魘居者",
	bloodtainted_fury = "污血怒靈",
	bloodtainted_burster = "污血爆靈",
	taintheart_summoner = "腐心召喚師",
	dreadfire_imp = "懼火小鬼",
	tormented_bloodseeker = "痛苦的覓血蝙蝠",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	throw = "投擲",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	--wrangler = "Hatecoil Wrangler",
	--stormweaver = "Hatecoil Stormweaver",
	--crusher = "Hatecoil Crusher",
	--oracle = "Hatecoil Oracle",
	--siltwalker = "Mak'rana Siltwalker",
	--tides = "Restless Tides",
	--arcanist = "Hatecoil Arcanist",
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
	--mug_of_mead = "Mug of Mead",
	--valarjar_thundercaller = "Valarjar Thundercaller",
	--storm_drake = "Storm Drake",
	--stormforged_sentinel = "Stormforged Sentinel",
	--valarjar_runecarver = "Valarjar Runecarver",
	--valarjar_mystic = "Valarjar Mystic",
	--valarjar_purifier = "Valarjar Purifier",
	--valarjar_shieldmaiden = "Valarjar Shieldmaiden",
	--valarjar_aspirant = "Valarjar Aspirant",
	--solsten = "Solsten",
	--olmyr = "Olmyr the Enlightened",
	--valarjar_marksman = "Valarjar Marksman",
	--gildedfur_stag = "Gildedfur Stag",
	--angerhoof_bull = "Angerhoof Bull",
	--valarjar_trapper = "Valarjar Trapper",
	--fourkings = "The Four Kings",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	--custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter.",
	opera_hall_wikket_story_text = "歌劇大廳：綠野巫蹤",
	--opera_hall_wikket_story_trigger = "Shut your jabber", -- Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "歌劇大廳：西荒故事",
	--opera_hall_westfall_story_trigger = "we meet two lovers", -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	opera_hall_beautiful_beast_story_text = "歌劇大廳：美女與猛獸",
	--opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage", -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	--barnes = "Barnes",
	--ghostly_philanthropist = "Ghostly Philanthropist",
	--skeletal_usher = "Skeletal Usher",
	--spectral_attendant = "Spectral Attendant",
	--spectral_valet = "Spectral Valet",
	--spectral_retainer = "Spectral Retainer",
	--phantom_guardsman = "Phantom Guardsman",
	--wholesome_hostess = "Wholesome Hostess",
	--reformed_maiden = "Reformed Maiden",
	--spectral_charger = "Spectral Charger",

	-- Return to Karazhan: Upper
	chess_event = "西洋棋事件",
	--king = "King",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	--cc = "Crowd Control",
	--cc_desc = "Timers and alerts for crowd control on the dinner guests.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	--name = "Nightbane",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	--soulguard = "Waterlogged Soul Guard",
	--champion = "Helarjar Champion",
	--mariner = "Night Watch Mariner",
	--swiftblade = "Seacursed Swiftblade",
	--mistmender = "Seacursed Mistmender",
	--mistcaller = "Helarjar Mistcaller",
	--skjal = "Skjal",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	rokmora_first_warmup_trigger = "納瓦羅格？！叛徒！你竟然帶領入侵者對抗我們？",
	rokmora_second_warmup_trigger = "就算這樣，我也樂見其成。羅克摩拉，碾碎他們！",

	vileshard_crawler = "邪裂爬行蛛",
	tarspitter_lurker = "噴油潛伏者",
	rockback_gnasher = "石背銳齒蜥",
	vileshard_hulk = "邪裂巨石怪",
	--vileshard_chunk = "Vileshard Chunk",
	understone_drummer = "底石擊鼓兵",
	mightstone_breaker = "力石破壞者",
	blightshard_shaper = "荒碎塑形者",
	stoneclaw_grubmaster = "石爪蟲王",
	tarspitter_grub = "噴油幼蟲",
	--rotdrool_grabber = "Rotdrool Grabber",
	understone_demolisher = "底石毀滅者",
	rockbound_trapper = "岩縛陷補者",
	emberhusk_dominator = "燼殼支配者",
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
	anomaly = "祕法異常體",
	shade = "扭曲之影",
	wraith = "凋萎者法力怨靈",
	blade = "憤怒守衛魔刃兵",
	--chaosbringer = "Eredar Chaosbringer",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "連環踢",

	light_dropped = "%s丟掉了光。",
	light_picked = "%s撿起了光。",

	warmup_trigger = "我已經拿到我要找的東西了。但為了你們，我最好還是留下來…斬草除根！",
	--warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark.",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	--warmup_trigger = "I will serve MY people, the exiled and the reviled.",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	infester = "魔誓感染者",
	myrmidon = "魔誓部屬",
	fury = "魔能怒衛",
	--mother = "Foul Mother",
	illianna = "刃舞者伊利安娜",
	mendacius = "驚懼領主曼達希斯",
	grimhorn = "『奴役者』恐角",
})
