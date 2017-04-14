local L = BigWigs:NewBossLocale("Odyn", "zhCN")
if not L then return end
if L then
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
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "zhCN")
if L then
	L.fourkings = "四王"
	L.olmyr = "启迪者奥米尔"
	L.purifier = "瓦拉加尔净化者"
	L.thundercaller = "瓦拉加尔唤雷者"
	L.mystic = "瓦拉加尔秘法师"
	L.aspirant = "瓦拉加尔候选者"
end
