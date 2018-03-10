local L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "zhCN")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
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
