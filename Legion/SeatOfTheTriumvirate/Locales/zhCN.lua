local L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "zhCN")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择奥蕾莉亚·风行者对话选项。"
	L.gossip_available = "可对话"
	L.alleria_gossip_trigger = "下令吧，英雄们，我们马上开始突袭。" -- Allerias yell after the first boss is defeated

	L.alleria = "奥蕾莉亚·风行者"
	L.subjugator = "影卫征服者"
	L.voidbender = "影卫缚灵师"
end
