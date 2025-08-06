-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "zhCN")
if L then
	L.tugar = "图加·鲜血图腾"
	L.jormog = "“巨兽”乔莫格"

	L.remaining = "鳞片剩余"

	L.submerge = "下潜"
	L.submerge_desc = "下潜到地下，召唤飞掠蛛蛋和落下尖刺。"

	L.charge_desc = "当乔莫格下潜时，它会定期向你的方向冲锋。"

	L.rupture = "{243382}（X）"
	L.rupture_desc = "会在身下出现一个 X 形状的邪能破裂。5秒后将破裂地面，向上发射尖刺并击退在上面的玩家。"

	L.totem_warning = "图腾击中你！"
end

L = BigWigs:NewBossLocale("Raest", "zhCN")
if L then
	L.name = "莱斯特·法师之矛"

	L.handFromBeyond = "异世之手"

	L.rune_desc = "在地面上放置一个召唤符文。如果没有站在上面会出现梦魇之物。"

	L.warmup_text = "卡兰姆·法师之矛激活"
	L.warmup_trigger = "你真蠢，居然跟着我来到这里，兄弟。扭曲虚空滋养了我的力量。我的强大已经超出了你的想象！"
	L.warmup_trigger2 = "杀了入侵者，兄弟！"
end

L = BigWigs:NewBossLocale("Kruul", "zhCN")
if L then
	L.name = "魔王库鲁尔"
	L.inquisitor = "审判官瓦里斯"
	L.velen = "先知维伦"

	L.warmup_trigger = "傲慢的蠢货！我掌握着千万世界的灵魂之力！"
	L.win_trigger = "那好吧。你们别想再挡路了。"

	L.nether_aberration_desc = "在房间内召唤传送门，出现虚空畸变怪。"

	L.smoldering_infernal = "阴燃的地狱火"
	L.smoldering_infernal_desc = "召唤一个阴燃的地狱火。"
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "zhCN")
if L then
	L.erdris = "艾德里斯·索恩领主"

	L.warmup_trigger = "你来的正是时候"
	L.warmup_trigger2 = "出……出什么事了？" -- Stage 5

	L.mage = "腐化的幽灵法师"
	L.soldier = "腐化的幽灵士兵"
	L.arbalest = "腐化的幽灵弩手"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "zhCN")
if L then
	L.name = "大法师克希雷姆"
	L.corruptingShadows = "腐蚀暗影"

	L.warmup_trigger1 = "掌握了聚焦之虹" -- 你太迟了，恶魔猎手！掌握了聚焦之虹，我就能直接从艾泽拉斯的魔网中抽取奥术能量来强化自身的法力！
	L.warmup_trigger2 = "被抽干魔力后，我的恶魔主人" -- 被抽干魔力后，我的恶魔主人就能占领你们的世界……我也将获得无穷的力量！
end

L = BigWigs:NewBossLocale("Agatha", "zhCN")
if L then
	L.name = "阿加莎"
	L.imp_servant = "小鬼仆从"
	L.fuming_imp = "阴燃的小鬼"
	L.levia = "莱维娅" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	L.warmup_trigger1 = "你太迟了！莱维娅的力量归我了！有了她的知识，我的人就能潜入肯瑞托，从内部瓦解它！" -- 35
	L.warmup_trigger2 = "此刻，我的萨亚德正在诱惑软弱的法师，你的盟友会自愿倒向军团！" -- 16
	L.warmup_trigger3 = "但，你得先为抢走我的宠物付出代价！" -- 3

	L.stacks = "层数"
end

L = BigWigs:NewBossLocale("Sigryn", "zhCN")
if L then
	L.sigryn = "希格林"
	L.jarl = "维尔布兰德族长"
	L.faljar = "符文先知法尔加"

	L.warmup_trigger = "什么？外来者来阻止我了？"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "zhCN")
if L then
	L.custom_on_autotalk_desc = "立即选择辛克莱尔中尉对话选项开始突袭紫罗兰监狱。"
	L.keeper = "传送门看护者"
	L.guardian = "传送门守卫者"
	L.infernal = "炽热的地狱火"
end

L = BigWigs:NewBossLocale("Thalena", "zhCN")
if L then
	L.essence = "精华"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "zhCN")
if L then
	L.ghostly_retainer = "幽灵家臣"
	L.ghostly_protector = "幽灵卫兵"
	L.ghostly_councilor = "幽灵顾问"
	L.lord_etheldrin_ravencrest = "艾瑟德林·拉文凯斯领主"
	L.lady_velandras_ravencrest = "薇兰达斯·拉文凯斯夫人"
	L.rook_spiderling = "鸦堡小蜘蛛"
	L.soultorn_champion = "失魂的勇士"
	L.risen_scout = "复活的斥候"
	L.risen_archer = "复活的弓箭手"
	L.risen_arcanist = "复活的奥术师"
	L.wyrmtongue_scavenger = "虫语清道夫"
	L.bloodscent_felhound = "血气地狱犬"
	L.felspite_dominator = "魔怨支配者"
	L.risen_swordsman = "复活的剑士"
	L.risen_lancer = "复活的长枪兵"

	L.door_open_desc = "显示通往隐秘小径门打开的计时条。"
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "zhCN")
if L then
	L.phase_2_trigger = "够了！我受够了。"
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "zhCN")
if L then
	L.custom_on_time_lost = "暗影消退计时"
	L.custom_on_time_lost_desc = "显示暗影消退为|cffff0000红色|r计时条。"
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "zhCN")
if L then
	L.custom_on_autotalk_desc = "立即选择阿格拉玛之盾对话开始与多玛塔克斯战斗。"

	L.missing_aegis = "你没站在盾内" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "盾：降低治疗"
	L.aegis_damage = "盾：降低伤害"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "zhCN")
if L then
	L.dulzak = "杜尔扎克"
	L.wrathguard = "愤怒卫士入侵者"
	L.felguard = "恶魔卫士毁灭者"
	L.soulmender = "鬼火慰魂者"
	L.temptress = "鬼焰女妖"
	L.botanist = "邪脉植物学家"
	L.orbcaster = "邪足晶球法师"
	L.waglur = "瓦格鲁尔"
	L.scavenger = "虫语清道夫"
	L.gazerax = "加泽拉克斯"
	L.vilebark = "邪皮行者"

	L.throw_tome = "投掷宝典" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "zhCN")
if L then
	L.duskwatch_sentry = "暮色卫队哨兵"
	L.duskwatch_reinforcement = "暮色卫队援军"
	L.Guard = "暮色卫队卫兵"
	L.Construct = "构造体卫兵"
	L.Enforcer = "邪缚执行者"
	L.Hound = "军团猎犬"
	L.Mistress = "暗影女妖"
	L.Gerenth = "邪恶的格伦斯"
	L.Jazshariu = "加兹沙尤"
	L.Imacutya = "依玛库塔"
	L.Baalgar = "警惕的巴尔戈"
	L.Inquisitor = "警觉的审判者"
	L.BlazingImp = "炽燃小鬼"
	L.Energy = "被束缚的能量"
	L.Manifestation = "奥术化身"
	L.Wyrm = "法力浮龙"
	L.Arcanist = "暮色卫队奥术师"
	L.InfernalImp = "地狱火小鬼"
	L.Malrodi = "奥术师玛洛迪"
	L.Velimar = "威利玛"
	L.ArcaneKeys = "魔法钥匙"
	L.clues = "线索"

	L.InfernalTome = "地狱火宝典"
	L.MagicalLantern = "魔法灯笼"
	L.NightshadeRefreshments = "夜影小食"
	L.StarlightRoseBrew = "星光玫瑰茶"
	L.UmbralBloom = "深黯之花"
	L.WaterloggedScroll = "浸水的卷轴"
	L.BazaarGoods = "集市货物"
	L.LifesizedNightborneStatue = "夜之子等身雕像"
	L.DiscardedJunk = "丢弃的垃圾"
	L.WoundedNightborneCivilian = "受伤的夜之子平民"

	L.announce_buff_items = "通报增益物品"
	L.announce_buff_items_desc = "通报此地下城所有可用的增益物品，并通报谁可以使用。"

	L.available = "%s|cffffffff%s|r可用" -- Context: item is available to use
	L.usableBy = "使用者：%s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "立即使用增益物品"
	L.custom_on_use_buff_items_desc = "启用此选项后，自动确认使用物品前的对话选项并使用物品，这不包含二号首领前使用会引来守卫的物品。"

	L.spy_helper = "密探事件助手"
	L.spy_helper_desc = "在一个信息窗口显示队伍得到密探线索，并通报线索给其他队员。"

	L.clueFound = "找到第%d/5条线索：|cffffffff%s|r"
	L.spyFound = "间谍被%s找到了！"
	L.spyFoundChat = "间谍已找到，快来！"
	L.spyFoundPattern = "喂喂，别急着下结论" -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	L.hints[1] = "斗篷"
	L.hints[2] = "没斗篷"
	L.hints[3] = "腰包"
	L.hints[4] = "药水"
	L.hints[5] = "长袖"
	L.hints[6] = "短袖"
	L.hints[7] = "手套"
	L.hints[8] = "没手套"
	L.hints[9] = "男性"
	L.hints[10] = "女性"
	L.hints[11] = "浅色上衣"
	L.hints[12] = "深色上衣"
	L.hints[13] = "没药水"
	L.hints[14] = "带书"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "zhCN")
if L then
	L.warmup_trigger = "显然你又失败了，麦兰杜斯。我给你一个机会。干掉这些外来者，我得回暗夜要塞了。"
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "zhCN")
if L then
	L.archdruid_glaidalis_warmup_trigger = "污染者……你们的血液带着梦魇的恶臭。滚出森林，不然就承受自然之怒吧！"

	L.mindshattered_screecher = "精神错乱的尖啸夜枭"
	L.dreadsoul_ruiner = "恐魂毁灭者"
	L.dreadsoul_poisoner = "恐魂施毒者"
	L.crazed_razorbeak = "发狂的锋喙狮鹫"
	L.festerhide_grizzly = "烂皮灰熊"
	L.vilethorn_blossom = "邪棘魔花"
	L.rotheart_dryad = "腐心树妖"
	L.rotheart_keeper = "腐心守护者"
	L.nightmare_dweller = "梦魇住民"
	L.bloodtainted_fury = "污血之怒"
	L.bloodtainted_burster = "污血爆裂者"
	L.taintheart_summoner = "污心召唤师"
	L.dreadfire_imp = "骇火小鬼"
	L.tormented_bloodseeker = "痛苦的吸血蝠"
end

L = BigWigs:NewBossLocale("Oakheart", "zhCN")
if L then
	L.throw = "投掷"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "zhCN")
if L then
	L.wrangler = "积怨牧鱼者"
	L.stormweaver = "积怨织雷者"
	L.crusher = "积怨碾压者"
	L.oracle = "积怨神谕者"
	L.siltwalker = "玛拉纳沙地行者"
	L.tides = "焦躁的海潮元素"
	L.arcanist = "积怨奥术师"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "zhCN")
if L then
	L.custom_on_show_helper_messages = "静电新星和凝聚闪电帮助信息"
	L.custom_on_show_helper_messages_desc = "启用此选项当首领开始施放|cff71d5ff静电新星|r或|cff71d5ff凝聚闪电|r时添加告知自身水中或沙丘安全的信息。"

	L.water_safe = "%s（水中安全）"
	L.land_safe = "%s（沙丘安全）"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "zhCN")
if L then
	L.gossip_available = "可对话"
	L.gossip_trigger = "真了不起！没想到还有人能对抗瓦拉加尔的力量……而他们就站在我面前。"

	L[197963] = "|cFF800080右上|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500右下|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00左下|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FF左上|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000上|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "zhCN")
if L then
	L.warmup_text = "神王斯科瓦尔德激活"
	L.warmup_trigger = "按照传统，它已经属于胜利者了。斯科瓦尔德，你的抗议来得太迟了。"
	L.warmup_trigger_2 = "如果这些所谓的“勇士”不肯放弃圣盾……那就让他们去死吧！"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "zhCN")
if L then
	L.mug_of_mead = "一杯蜜酒"
	L.valarjar_thundercaller = "瓦拉加尔唤雷者"
	L.storm_drake = "风暴幼龙"
	L.stormforged_sentinel = "雷铸斥候"
	L.valarjar_runecarver = "瓦拉加尔刻符者"
	L.valarjar_mystic = "瓦拉加尔秘法师"
	L.valarjar_purifier = "瓦拉加尔净化者"
	L.valarjar_shieldmaiden = "瓦拉加尔女武神"
	L.valarjar_aspirant = "瓦拉加尔候选者"
	L.solsten = "索斯坦"
	L.olmyr = "启迪者奥米尔"
	L.valarjar_marksman = "瓦拉加尔神射手"
	L.gildedfur_stag = "金鬃雄鹿"
	L.angerhoof_bull = "怒蹄公牛"
	L.valarjar_trapper = "瓦拉加尔捕兽者"
	L.fourkings = "四王"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "zhCN")
if L then
	-- Opera Event
	L.custom_on_autotalk_desc = "立即选择巴内斯对话选项开始歌剧院战斗。"
	L.opera_hall_wikket_story_text = "歌剧院：魔法坏女巫"
	L.opera_hall_wikket_story_trigger = "唱戏的家伙少废话" -- 唱戏的家伙少废话，美猴王有了个新想法！
	L.opera_hall_westfall_story_text = "歌剧院：西部故事"
	L.opera_hall_westfall_story_trigger = "我们将认识一对分属哨兵岭敌对双方的有情人" -- 今天……我们将认识一对分属哨兵岭敌对双方的有情人。
	L.opera_hall_beautiful_beast_story_text = "歌剧院：美女与野兽"
	L.opera_hall_beautiful_beast_story_trigger = "将上演爱情与愤怒的传奇" -- 今晚……将上演爱情与愤怒的传奇，它将再次证明，美不是肤浅的东西。

	-- Return to Karazhan: Lower
	L.barnes = "巴内斯"
	L.ghostly_philanthropist = "幽灵慈善家"
	L.skeletal_usher = "骷髅招待员"
	L.spectral_attendant = "鬼魅随从"
	L.spectral_valet = "鬼灵侍从"
	L.spectral_retainer = "鬼灵家仆"
	L.phantom_guardsman = "幻影卫兵"
	L.wholesome_hostess = "保守的女招待"
	L.reformed_maiden = "贞善女士"
	L.spectral_charger = "鬼灵战马"

	-- Return to Karazhan: Upper
	L.chess_event = "国际象棋"
	L.king = "国王"
end

L = BigWigs:NewBossLocale("Moroes", "zhCN")
if L then
	L.cc = "群体控制"
	L.cc_desc = "群体控制晚餐客人的计时器和警报。"
end

L = BigWigs:NewBossLocale("Nightbane", "zhCN")
if L then
	L.name = "夜之魇"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "zhCN")
if L then
	L.soulguard = "浸水的灵魂卫士"
	L.champion = "海拉加尔勇士"
	L.mariner = "守夜水手"
	L.swiftblade = "海咒快刀手"
	L.mistmender = "海咒雾疗师"
	L.mistcaller = "海拉加尔召雾者"
	L.skjal = "斯卡加尔"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "zhCN")
if L then
	L.rokmora_first_warmup_trigger = "纳瓦罗格？！叛徒！你想带领这些入侵者对抗我们吗？！"
	L.rokmora_second_warmup_trigger = "无论如何，我都会好好享受它每一刻的。洛克莫拉，碾碎他们！"

	L.vileshard_crawler = "邪裂蜘蛛"
	L.tarspitter_lurker = "喷油潜伏者"
	L.rockback_gnasher = "岩背啮咬者"
	L.vileshard_hulk = "邪裂巨人"
	L.vileshard_chunk = "邪裂巨人"
	L.understone_drummer = "顶石游荡者"
	L.mightstone_breaker = "巨石破坏者"
	L.blightshard_shaper = "枯碎塑造者"
	L.stoneclaw_grubmaster = "石爪虫王"
	L.tarspitter_grub = "喷油蛆虫"
	L.rotdrool_grabber = "腐涎劫掠者"
	L.understone_demolisher = "顶石粉碎者"
	L.rockbound_trapper = "缚石捕兽者"
	L.emberhusk_dominator = "烬壳统御者"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "zhCN")
if L then
	L.hands = "石手" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "zhCN")
if L then
	L.guards = "影卫"
	L.interrupted = "%s已打断%s（%.1f秒剩余）！"
end

L = BigWigs:NewBossLocale("L'ura", "zhCN")
if L then
	L.warmup_text = "鲁拉激活"
	L.warmup_trigger = "如此混乱……如此痛苦。我从未体验过这种感受。"
	L.warmup_trigger_2 = "这些可以稍后再想。但它必须死。"
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "zhCN")
if L then
	L.custom_on_autotalk_desc = "立即选择奥蕾莉亚·风行者对话选项。"
	L.gossip_available = "可对话"
	L.alleria_gossip_trigger = "跟我走！" -- Allerias yell after the first boss is defeated

	L.alleria = "奥蕾莉亚·风行者"
	L.subjugator = "影卫征服者"
	L.voidbender = "影卫缚灵师"
	L.conjurer = "影卫召唤师"
	L.weaver = "大织影者"
end

-- The Arcway

L = BigWigs:NewBossLocale("The Arcway Trash", "zhCN")
if L then
	L.anomaly = "奥术畸体"
	L.shade = "迁跃之影"
	L.wraith = "枯法法力怨灵"
	L.blade = "愤怒卫士邪刃者"
	L.chaosbringer = "艾瑞达混沌使者"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "zhCN")
if L then
	L.kick_combo = "连环踢"

	L.light_dropped = "%s 丢掉了艾露恩之光。"
	L.light_picked = "%s 拾取了艾露恩之光。"

	L.warmup_trigger = "我拿到想要的东西了。但我要留下来了结你们……永除后患！"
	L.warmup_trigger_2 = "你们掉进了我的陷阱。让我看看你们在黑暗中的本事吧。"
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "zhCN")
if L then
	L.warmup_trigger = "我为人民而战，为那些被放逐和唾弃的人而战。"
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "zhCN")
if L then
	L.infester = "魔誓寄生者"
	L.myrmidon = "魔誓侍从"
	L.fury = "灌魔之怒"
	L.mother = "邪母"
	L.illianna = "刃舞者伊莲娜"
	L.mendacius = "恐惧魔王孟达休斯"
	L.grimhorn = "奴役者格里霍恩"
end
