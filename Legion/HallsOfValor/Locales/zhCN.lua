local L = BigWigs:NewBossLocale("Odyn", "zhCN")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择对话选项开始战斗。"

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
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择地下城内多个对话选项。"

	L.fourkings = "四王"
	L.olmyr = "启迪者奥米尔"
	L.purifier = "瓦拉加尔净化者"
	L.thundercaller = "瓦拉加尔唤雷者"
	L.mystic = "瓦拉加尔秘法师"
	L.aspirant = "瓦拉加尔候选者"
	L.drake = "风暴幼龙"
	L.marksman = "瓦拉加尔神射手"
	L.trapper = "瓦拉加尔捕兽者"
	L.sentinel = "雷铸斥候"
end
