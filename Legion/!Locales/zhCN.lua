-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "图加·鲜血图腾",
	jormog = "“巨兽”乔莫格",

	remaining = "鳞片剩余",

	submerge = "下潜",
	submerge_desc = "下潜到地下，召唤飞掠蛛蛋和落下尖刺。",

	charge_desc = "当乔莫格下潜时，它会定期向你的方向冲锋。",

	rupture = "{243382}（X）",
	rupture_desc = "会在身下出现一个 X 形状的邪能破裂。5秒后将破裂地面，向上发射尖刺并击退在上面的玩家。",

	totem_warning = "图腾击中你！",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "莱斯特·法师之矛",

	handFromBeyond = "异世之手",

	rune_desc = "在地面上放置一个召唤符文。如果没有站在上面会出现梦魇之物。",

	warmup_text = "卡兰姆·法师之矛激活",
	warmup_trigger = "你真蠢，居然跟着我来到这里，兄弟。扭曲虚空滋养了我的力量。我的强大已经超出了你的想象！",
	warmup_trigger2 = "杀了入侵者，兄弟！",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "魔王库鲁尔",
	inquisitor = "审判官瓦里斯",
	velen = "先知维伦",

	warmup_trigger = "傲慢的蠢货！我掌握着千万世界的灵魂之力！",
	win_trigger = "那好吧。你们别想再挡路了。",

	nether_aberration_desc = "在房间内召唤传送门，出现虚空畸变怪。",

	smoldering_infernal = "阴燃的地狱火",
	smoldering_infernal_desc = "召唤一个阴燃的地狱火。",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "艾德里斯·索恩领主",

	warmup_trigger = "你来的正是时候",
	warmup_trigger2 = "出……出什么事了？", -- Stage 5

	mage = "腐化的幽灵法师",
	soldier = "腐化的幽灵士兵",
	arbalest = "腐化的幽灵弩手",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "大法师克希雷姆",
	corruptingShadows = "腐蚀暗影",

	warmup_trigger1 = "掌握了聚焦之虹", -- 你太迟了，恶魔猎手！掌握了聚焦之虹，我就能直接从艾泽拉斯的魔网中抽取奥术能量来强化自身的法力！
	warmup_trigger2 = "被抽干魔力后，我的恶魔主人", -- 被抽干魔力后，我的恶魔主人就能占领你们的世界……我也将获得无穷的力量！
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "阿加莎",
	imp_servant = "小鬼仆从",
	fuming_imp = "阴燃的小鬼",
	levia = "莱维娅", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	warmup_trigger1 = "你太迟了！莱维娅的力量归我了！有了她的知识，我的人就能潜入肯瑞托，从内部瓦解它！", -- 35
	warmup_trigger2 = "此刻，我的萨亚德正在诱惑软弱的法师，你的盟友会自愿倒向军团！", -- 16
	warmup_trigger3 = "但，你得先为抢走我的宠物付出代价！", -- 3

	stacks = "层数",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "希格林",
	jarl = "维尔布兰德族长",
	faljar = "符文先知法尔加",

	warmup_trigger = "什么？外来者来阻止我了？",
})

-- Assault on Violet Hold

BigWigsAPI.SetBossModuleLocale("Assault on Violet Hold Trash", {
	custom_on_autotalk_desc = "立即选择辛克莱尔中尉对话选项开始突袭紫罗兰监狱。",
	keeper = "传送门看护者",
	guardian = "传送门守卫者",
	infernal = "炽热的地狱火",
})

BigWigsAPI.SetBossModuleLocale("Thalena", {
	essence = "精华",
})

-- Black Rook Hold

BigWigsAPI.SetBossModuleLocale("Black Rook Hold Trash", {
	ghostly_retainer = "幽灵家臣",
	ghostly_protector = "幽灵卫兵",
	ghostly_councilor = "幽灵顾问",
	lord_etheldrin_ravencrest = "艾瑟德林·拉文凯斯领主",
	lady_velandras_ravencrest = "薇兰达斯·拉文凯斯夫人",
	rook_spiderling = "鸦堡小蜘蛛",
	soultorn_champion = "失魂的勇士",
	risen_scout = "复活的斥候",
	risen_archer = "复活的弓箭手",
	risen_arcanist = "复活的奥术师",
	wyrmtongue_scavenger = "虫语清道夫",
	bloodscent_felhound = "血气地狱犬",
	felspite_dominator = "魔怨支配者",
	risen_swordsman = "复活的剑士",
	risen_lancer = "复活的长枪兵",

	door_open_desc = "显示通往隐秘小径门打开的计时条。",
})

BigWigsAPI.SetBossModuleLocale("Kurtalos Ravencrest", {
	phase_2_trigger = "够了！我受够了。",
})

-- Cathedral of Eternal Night

BigWigsAPI.SetBossModuleLocale("Mephistroth", {
	custom_on_time_lost = "暗影消退计时",
	custom_on_time_lost_desc = "显示暗影消退为|cffff0000红色|r计时条。",
	time_lost = "%s |cffff0000(+%ds)|r",
})

BigWigsAPI.SetBossModuleLocale("Domatrax", {
	custom_on_autotalk_desc = "立即选择阿格拉玛之盾对话开始与多玛塔克斯战斗。",

	missing_aegis = "你没站在盾内", -- Aegis is a short name for Aegis of Aggramar
	aegis_healing = "盾：降低治疗",
	aegis_damage = "盾：降低伤害",
})

BigWigsAPI.SetBossModuleLocale("Cathedral of Eternal Night Trash", {
	dulzak = "杜尔扎克",
	wrathguard = "愤怒卫士入侵者",
	felguard = "恶魔卫士毁灭者",
	soulmender = "鬼火慰魂者",
	temptress = "鬼焰女妖",
	botanist = "邪脉植物学家",
	orbcaster = "邪足晶球法师",
	waglur = "瓦格鲁尔",
	scavenger = "虫语清道夫",
	gazerax = "加泽拉克斯",
	vilebark = "邪皮行者",

	throw_tome = "投掷宝典", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "暮色卫队哨兵",
	duskwatch_reinforcement = "暮色卫队援军",
	Guard = "暮色卫队卫兵",
	Construct = "构造体卫兵",
	Enforcer = "邪缚执行者",
	Hound = "军团猎犬",
	Mistress = "暗影女妖",
	Gerenth = "邪恶的格伦斯",
	Jazshariu = "加兹沙尤",
	Imacutya = "依玛库塔",
	Baalgar = "警惕的巴尔戈",
	Inquisitor = "警觉的审判者",
	BlazingImp = "炽燃小鬼",
	Energy = "被束缚的能量",
	Manifestation = "奥术化身",
	Wyrm = "法力浮龙",
	Arcanist = "暮色卫队奥术师",
	InfernalImp = "地狱火小鬼",
	Malrodi = "奥术师玛洛迪",
	Velimar = "威利玛",
	ArcaneKeys = "魔法钥匙",
	clues = "线索",

	InfernalTome = "地狱火宝典",
	MagicalLantern = "魔法灯笼",
	NightshadeRefreshments = "夜影小食",
	StarlightRoseBrew = "星光玫瑰茶",
	UmbralBloom = "深黯之花",
	WaterloggedScroll = "浸水的卷轴",
	BazaarGoods = "集市货物",
	LifesizedNightborneStatue = "夜之子等身雕像",
	DiscardedJunk = "丢弃的垃圾",
	WoundedNightborneCivilian = "受伤的夜之子平民",

	announce_buff_items = "通报增益物品",
	announce_buff_items_desc = "通报此地下城所有可用的增益物品，并通报谁可以使用。",

	available = "%s|cffffffff%s|r可用", -- Context: item is available to use
	usableBy = "使用者：%s", -- Context: item is usable by someone

	custom_on_use_buff_items = "立即使用增益物品",
	custom_on_use_buff_items_desc = "启用此选项后，自动确认使用物品前的对话选项并使用物品，这不包含二号首领前使用会引来守卫的物品。",

	spy_helper = "密探事件助手",
	spy_helper_desc = "在一个信息窗口显示队伍得到密探线索，并通报线索给其他队员。",

	clueFound = "找到第%d/5条线索：|cffffffff%s|r",
	spyFound = "间谍被%s找到了！",
	spyFoundChat = "间谍已找到，快来！",
	spyFoundPattern = "喂喂，别急着下结论", -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	hints = {
		[1] = "斗篷",
		[2] = "没斗篷",
		[3] = "腰包",
		[4] = "药水",
		[5] = "长袖",
		[6] = "短袖",
		[7] = "手套",
		[8] = "没手套",
		[9] = "男性",
		[10] = "女性",
		[11] = "浅色上衣",
		[12] = "深色上衣",
		[13] = "没药水",
		[14] = "带书",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	warmup_trigger = "显然你又失败了，麦兰杜斯。我给你一个机会。干掉这些外来者，我得回暗夜要塞了。",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	archdruid_glaidalis_warmup_trigger = "污染者……你们的血液带着梦魇的恶臭。滚出森林，不然就承受自然之怒吧！",

	mindshattered_screecher = "精神错乱的尖啸夜枭",
	dreadsoul_ruiner = "恐魂毁灭者",
	dreadsoul_poisoner = "恐魂施毒者",
	crazed_razorbeak = "发狂的锋喙狮鹫",
	festerhide_grizzly = "烂皮灰熊",
	vilethorn_blossom = "邪棘魔花",
	rotheart_dryad = "腐心树妖",
	rotheart_keeper = "腐心守护者",
	nightmare_dweller = "梦魇住民",
	bloodtainted_fury = "污血之怒",
	bloodtainted_burster = "污血爆裂者",
	taintheart_summoner = "污心召唤师",
	dreadfire_imp = "骇火小鬼",
	tormented_bloodseeker = "痛苦的吸血蝠",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	throw = "投掷",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "积怨牧鱼者",
	stormweaver = "积怨织雷者",
	crusher = "积怨碾压者",
	oracle = "积怨神谕者",
	siltwalker = "玛拉纳沙地行者",
	tides = "焦躁的海潮元素",
	arcanist = "积怨奥术师",
})

BigWigsAPI.SetBossModuleLocale("Lady Hatecoil", {
	custom_on_show_helper_messages = "静电新星和凝聚闪电帮助信息",
	custom_on_show_helper_messages_desc = "启用此选项当首领开始施放|cff71d5ff静电新星|r或|cff71d5ff凝聚闪电|r时添加告知自身水中或沙丘安全的信息。",

	water_safe = "%s（水中安全）",
	land_safe = "%s（沙丘安全）",
})

-- Halls of Valor

BigWigsAPI.SetBossModuleLocale("Odyn", {
	gossip_available = "可对话",
	gossip_trigger = "真了不起！没想到还有人能对抗瓦拉加尔的力量……而他们就站在我面前。",

	[197963] = "|cFF800080右上|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Right"
	[197964] = "|cFFFFA500右下|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Right"
	[197965] = "|cFFFFFF00左下|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Left"
	[197966] = "|cFF0000FF左上|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Left"
	[197967] = "|cFF008000上|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top"
})

BigWigsAPI.SetBossModuleLocale("God-King Skovald", {
	warmup_text = "神王斯科瓦尔德激活",
	warmup_trigger = "按照传统，它已经属于胜利者了。斯科瓦尔德，你的抗议来得太迟了。",
	warmup_trigger_2 = "如果这些所谓的“勇士”不肯放弃圣盾……那就让他们去死吧！",
})

BigWigsAPI.SetBossModuleLocale("Halls of Valor Trash", {
	mug_of_mead = "一杯蜜酒",
	valarjar_thundercaller = "瓦拉加尔唤雷者",
	storm_drake = "风暴幼龙",
	stormforged_sentinel = "雷铸斥候",
	valarjar_runecarver = "瓦拉加尔刻符者",
	valarjar_mystic = "瓦拉加尔秘法师",
	valarjar_purifier = "瓦拉加尔净化者",
	valarjar_shieldmaiden = "瓦拉加尔女武神",
	valarjar_aspirant = "瓦拉加尔候选者",
	solsten = "索斯坦",
	olmyr = "启迪者奥米尔",
	valarjar_marksman = "瓦拉加尔神射手",
	gildedfur_stag = "金鬃雄鹿",
	angerhoof_bull = "怒蹄公牛",
	valarjar_trapper = "瓦拉加尔捕兽者",
	fourkings = "四王",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	custom_on_autotalk_desc = "立即选择巴内斯对话选项开始歌剧院战斗。",
	opera_hall_wikket_story_text = "歌剧院：魔法坏女巫",
	opera_hall_wikket_story_trigger = "唱戏的家伙少废话", -- 唱戏的家伙少废话，美猴王有了个新想法！
	opera_hall_westfall_story_text = "歌剧院：西部故事",
	opera_hall_westfall_story_trigger = "我们将认识一对分属哨兵岭敌对双方的有情人", -- 今天……我们将认识一对分属哨兵岭敌对双方的有情人。
	opera_hall_beautiful_beast_story_text = "歌剧院：美女与野兽",
	opera_hall_beautiful_beast_story_trigger = "将上演爱情与愤怒的传奇", -- 今晚……将上演爱情与愤怒的传奇，它将再次证明，美不是肤浅的东西。

	-- Return to Karazhan: Lower
	barnes = "巴内斯",
	ghostly_philanthropist = "幽灵慈善家",
	skeletal_usher = "骷髅招待员",
	spectral_attendant = "鬼魅随从",
	spectral_valet = "鬼灵侍从",
	spectral_retainer = "鬼灵家仆",
	phantom_guardsman = "幻影卫兵",
	wholesome_hostess = "保守的女招待",
	reformed_maiden = "贞善女士",
	spectral_charger = "鬼灵战马",

	-- Return to Karazhan: Upper
	chess_event = "国际象棋",
	king = "国王",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "群体控制",
	cc_desc = "群体控制晚餐客人的计时器和警告。",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "夜之魇",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "浸水的灵魂卫士",
	champion = "海拉加尔勇士",
	mariner = "守夜水手",
	swiftblade = "海咒快刀手",
	mistmender = "海咒雾疗师",
	mistcaller = "海拉加尔召雾者",
	skjal = "斯卡加尔",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	rokmora_first_warmup_trigger = "纳瓦罗格？！叛徒！你想带领这些入侵者对抗我们吗？！",
	rokmora_second_warmup_trigger = "无论如何，我都会好好享受它每一刻的。洛克莫拉，碾碎他们！",

	vileshard_crawler = "邪裂蜘蛛",
	tarspitter_lurker = "喷油潜伏者",
	rockback_gnasher = "岩背啮咬者",
	vileshard_hulk = "邪裂巨人",
	vileshard_chunk = "邪裂巨人",
	understone_drummer = "顶石游荡者",
	mightstone_breaker = "巨石破坏者",
	blightshard_shaper = "枯碎塑造者",
	stoneclaw_grubmaster = "石爪虫王",
	tarspitter_grub = "喷油蛆虫",
	rotdrool_grabber = "腐涎劫掠者",
	understone_demolisher = "顶石粉碎者",
	rockbound_trapper = "缚石捕兽者",
	emberhusk_dominator = "烬壳统御者",
})

BigWigsAPI.SetBossModuleLocale("Ularogg Cragshaper", {
	hands = "石手", -- Short for "Stone Hands"
})

-- Seat of the Triumvirate

BigWigsAPI.SetBossModuleLocale("Viceroy Nezhar", {
	guards = "影卫",
	interrupted = "%s已打断%s（%.1f秒剩余）！",
})

BigWigsAPI.SetBossModuleLocale("L'ura", {
	warmup_text = "鲁拉激活",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	custom_on_autotalk_desc = "立即选择奥蕾莉亚·风行者对话选项。",
	gossip_available = "可对话",
	alleria_gossip_trigger = "跟我走！", -- Allerias yell after the first boss is defeated
	lura_warmup_trigger = "如此混乱……如此痛苦。我从未体验过这种感受。",
	lura_warmup_trigger_2 = "这些可以稍后再想。但它必须死。",

	alleria = "奥蕾莉亚·风行者",
	subjugator = "影卫征服者",
	voidbender = "影卫缚灵师",
	conjurer = "影卫召唤师",
	weaver = "大织影者",

	-- Midnight+
	void_rifts_closed = "关闭虚空裂隙",
	void_rifts_closed_desc = "当关闭虚空裂隙时显示警告。",
})

-- The Arcway

BigWigsAPI.SetBossModuleLocale("The Arcway Trash", {
	anomaly = "奥术畸体",
	shade = "迁跃之影",
	wraith = "枯法法力怨灵",
	blade = "愤怒卫士邪刃者",
	chaosbringer = "艾瑞达混沌使者",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "连环踢",

	light_dropped = "%s 丢掉了艾露恩之光。",
	light_picked = "%s 拾取了艾露恩之光。",

	warmup_trigger = "我拿到想要的东西了。但我要留下来了结你们……永除后患！",
	warmup_trigger_2 = "你们掉进了我的陷阱。让我看看你们在黑暗中的本事吧。",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	warmup_trigger = "我为人民而战，为那些被放逐和唾弃的人而战。",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	infester = "魔誓寄生者",
	myrmidon = "魔誓侍从",
	fury = "灌魔之怒",
	mother = "邪母",
	illianna = "刃舞者伊莲娜",
	mendacius = "恐惧魔王孟达休斯",
	grimhorn = "奴役者格里霍恩",
})
