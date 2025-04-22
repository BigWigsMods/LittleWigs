-- Ahn'kahet: The Old Kingdom

local L = BigWigs:NewBossLocale("Ahn'kahet Trash", "zhCN")
if not L then return end
if L then
	L.spellflinger = "安卡哈爆法者"
	L.eye = "塔达拉姆之眼"
	L.darkcaster = "暮光黑暗法师"
end

-- Gundrak

L = BigWigs:NewBossLocale("Gal'darah", "zhCN")
if L then
	L.forms = "形态"
	L.forms_desc = "当迦尔达拉转换形态前发出警报。"

	L.form_rhino = "犀牛形态"
	L.form_troll = "巨魔形态"
end

-- Halls of Lightning

L = BigWigs:NewBossLocale("Halls of Lightning Trash", "zhCN")
if L then
	L.runeshaper = "雷铸符文师"
	L.sentinel = "雷铸斥候"
end

-- Halls of Stone

L = BigWigs:NewBossLocale("Tribunal of Ages", "zhCN")
if L then
	L.engage_trigger = "你们帮我看着点外面" -- 嗯，你们帮我看着点外面。我这样的强者只要锤两下就能搞定这破烂……
	L.defeat_trigger = "看来还是我这把老骨头厉害呀" --  哈！看来还是我这把老骨头厉害呀！然后再看看这里……
	L.fail_trigger = "还没"

	L.timers = "计时器"
	L.timers_desc = "发生各种事件的计时器。"

	L.victory = "胜利"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "zhCN")
if L then
	L.custom_on_autotalk_desc = "立即选择克罗米和阿尔萨斯对话选项。"

	L.gossip_available = "可对话"
	L.gossip_timer_trigger = "乌瑟尔，你总算及时赶到了。"
end

L = BigWigs:NewBossLocale("Mal'Ganis", "zhCN")
if L then
	L.warmup_trigger = "让我们来做个了断吧，玛尔加尼斯。"
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "zhCN")
if L then
	-- 阿尔萨斯·米奈希尔王子殿下，今天，你的灵魂已经被某种强大的黑暗力量侵蚀。你想要以死亡净化这座城市，现在你也要面对毁灭的命运了。
	L.warmup_trigger = "你的灵魂已经被某种强大的黑暗力量侵蚀"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "zhCN")
if L then
	L.name = "永恒腐蚀者"
end

-- The Nexus

L = BigWigs:NewBossLocale("The Nexus Trash", "zhCN")
if L then
	L.slayer = "法师杀手"
	L.steward = "管家"
end

-- The Violet Hold

L = BigWigs:NewBossLocale("Xevozz", "zhCN")
if L then
	L.sphere_name = "灵体之球"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "zhCN")
if L then
	L.short_name = "祖拉玛特"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "zhCN")
if L then
	L.portals_desc = "传送门相关信息。"
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "zhCN")
if L then
	L.custom_on_autotalk_desc = "立即选择对话选项开始战斗。"
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "zhCN")
if L then
	L.berserker = "伊米亚狂战士"
end
