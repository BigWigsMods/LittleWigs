local L = BigWigs:NewBossLocale("Viceroy Nezhar", "zhCN")
if not L then return end
if L then
	L.tentacles = "触须"
	L.guards = "影卫"
	L.interrupted = "%s已打断%s（%.1f秒剩余）！"
end

L = BigWigs:NewBossLocale("L'ura", "zhCN")
if L then
	--L.warmup_text = "L'ura Active"
	--L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	--L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
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
	--L.conjurer = "Shadowguard Conjurer"
	--L.weaver = "Grand Shadow-Weaver"
end
