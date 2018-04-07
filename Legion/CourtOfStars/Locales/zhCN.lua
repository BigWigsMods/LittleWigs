local L = BigWigs:NewBossLocale("Court of Stars Trash", "zhCN")
if not L then return end
if L then
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

	L.hints = {
		"斗篷",
		"没斗篷",
		"腰包",
		"药水",
		"长袖",
		"短袖",
		"手套",
		"没手套",
		"男性",
		"女性",
		"浅色上衣",
		"深色上衣",
		"没药水",
		"带书",
	}

	--[[ !!! IMPORTANT NOTE TO TRANSLATORS !!! ]]--
	--[[ The following translations have to exactly match the gossip text of the Chatty Rumormongers. ]]--

	-- Cape
	L["我听说那个密探喜欢穿斗篷。"] = 1
	L["有人提到那个密探之前是穿着斗篷来的。"] = 1

	-- No Cape
	L["我听说那个密探在来这里之前，把斗篷忘在王宫里了。"] = 2
	L["我听说那个密探讨厌斗篷，所以没有穿。"] = 2

	-- Pouch
	L["一个朋友说，那个密探喜欢黄金，所以在腰包里装满了金币。"] = 3
	L["我听说那个密探的腰包里装满了摆阔用的金币。"] = 3
	L["我听说那个密探总是带着一个魔法袋。"] = 3
	L["我听说那个密探的腰包上绣着精美的丝线。"] = 3

	-- Potions
	L["我听说那个密探买了一些药水……以防万一。"] = 4
	L["我敢肯定，那个密探的腰带上挂着药水。"] = 4
	L["我听说那个密探随身带着药水，这是为什么呢？"] = 4
	L["可别说是我告诉你的……那个密探伪装成了炼金师，腰带上挂着药水。"] = 4

	-- Long Sleeves
	L["上半夜的时候，我正巧瞥见那个密探穿着长袖衣服。"] = 5
	L["我听说那个密探今天穿着长袖外套。"] = 5
	L["有人说，那个密探今晚穿了一件长袖的衣服。"] = 5
	L["我的一个朋友说那个密探穿着长袖衣服。"] = 5

	-- Short Sleeves
	L["我听说那个密探喜欢清凉的空气，所以今晚没有穿长袖衣服。"] = 6
	L["我的一个朋友说，她看到了密探穿的衣服，是一件短袖上衣。"] = 6
	L["有人告诉我那个密探讨厌长袖的衣服。"] = 6
	L["我听说密探喜欢穿短袖服装，以免妨碍双臂的活动。"] = 6

	-- Gloves
	L["我听说那个密探总是带着手套。"] = 7
	L["有传言说那个密探总是带着手套。"] = 7
	L["有人说那个密探带着手套，以掩盖手上明显的疤痕。"] = 7
	L["我听说密探都会小心隐藏自己的双手。"] = 7

	-- No Gloves
	L["有传言说那个密探从来不戴手套。"] = 8
	L["我听说那个密探不喜欢戴手套。"] = 8
	L["我听说那个密探会尽量不戴手套，以防在快速行动时受到阻碍。"] = 8
	L["你知道吗……我在后头的房间里发现了一双多余的手套。那个密探现在可能就赤着双手在这附近转悠呢。"] = 8

	-- Male
	L["有个客人说她看见他和大魔导师一起走进了庄园。"] = 9
	L["我在别处听说那个密探不是女性。"] = 9
	L["我听说那个密探已经来了，而且他很英俊。"] = 9
	L["有个乐师说，他一直在打听这一带的消息。"] = 9

	-- Female
	L["有个客人先前看到她是和艾利桑德一起到达的。"] = 10
	L["我听说有个女人一直打听贵族区的情况……"] = 10
	L["有人说我们的新客人不是男性。"] = 10
	L["他们说那个密探已经来了，而且她是个大美人。"] = 10

	-- Light Vest
	L["那个间谍肯定更喜欢浅色的上衣。"] = 11
	L["我听说那个密探穿着一件浅色上衣来参加今晚的聚会。"] = 11
	L["大家都在说那个密探今晚没有穿深色的上衣。"] = 11

	-- Dark Vest
	L["我听说那个密探今晚所穿的外衣是浓密的暗深色。"] = 12
	L["那个密探喜欢深色的上衣……就像夜空一样深沉。"] = 12
	L["传说那个密探会避免穿浅色的服装，以便更好地混入人群。"] = 12
	L["那个间谍肯定更喜欢深色的服装。"] = 12

	-- No Potions
	L["我听说那个密探根本没带任何药水。"] = 13
	L["有个乐师告诉我，她看到那个密探扔掉了身上的最后一瓶药水，已经没有药水了。"] = 13

	-- Book
	L["我听说那个密探的腰带上，总是挂着一本写满机密的书。"] = 14
	L["据说那个密探喜欢读书，而且总是随身携带至少一本书。"] = 14
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "zhCN")
if L then
	L.warmup_trigger = "显然你又失败了，麦兰杜斯。我给你一个机会。干掉这些外来者，我得回暗夜要塞了。"
end
