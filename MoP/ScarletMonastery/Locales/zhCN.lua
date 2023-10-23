local L = BigWigs:NewBossLocale("Brother Korloff", "zhCN")
if not L then return end
if L then
	L.engage_yell = "我要粉碎你。"
end

local L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "zhCN")
if L then
	L.engage_yell = "我就是传说！"
end

local L = BigWigs:NewBossLocale("Thalnos the Soulrender", "zhCN")
if L then
	L.engage_yell = "让你们也尝尝我无尽的痛苦！"
end

local L = BigWigs:NewBossLocale("The Headless Horseman", "zhCN")
if not L then return end
if L then
	L.the_headless_horseman = "无头骑士"
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "自动接受柳魔人的诅咒，并自动开始首领战。"
	L.curses_desc = "获得柳魔人的诅咒时通知你。"
end
