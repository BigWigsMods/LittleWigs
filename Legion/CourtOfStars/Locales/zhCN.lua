local L = BigWigs:NewBossLocale("Court of Stars Trash", "zhCN")
if not L then return end
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
