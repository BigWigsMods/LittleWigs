local L = BigWigs:NewBossLocale("Thalnos the Soulrender", "zhTW")
if not L then return end
if L then
	--L.engage_yell = "My endless agony shall be yours, as well!"
end

L = BigWigs:NewBossLocale("Brother Korloff", "zhTW")
if L then
	--L.engage_yell = "I will break you."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "zhTW")
if L then
	--L.engage_yell = "My legend begins NOW!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "zhTW")
if L then
	L.the_headless_horseman = "無頭騎士"
	L.custom_on_autotalk = "自動對話"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end
