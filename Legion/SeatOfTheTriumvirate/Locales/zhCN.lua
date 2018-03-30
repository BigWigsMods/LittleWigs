local L = BigWigs:NewBossLocale("Viceroy Nezhar", "zhCN")
if not L then return end
if L then
	L.tentacles = "触须"
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
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择奥蕾莉亚·风行者对话选项。"
	L.gossip_available = "可对话"
	L.alleria_gossip_trigger = "跟我走！" -- Allerias yell after the first boss is defeated

	L.alleria = "奥蕾莉亚·风行者"
	L.subjugator = "影卫征服者"
	L.voidbender = "影卫缚灵师"
	L.conjurer = "影卫召唤师"
	L.weaver = "大织影者"
end
