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
	L.custom_off_autotalk = "自动对话"
	--L.custom_off_autotalk_desc = "Automatically accept the curses from the Wicker Men."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end
