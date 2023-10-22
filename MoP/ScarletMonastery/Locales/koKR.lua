local L = BigWigs:NewBossLocale("Brother Korloff", "koKR")
if not L then return end
if L then
	L.engage_yell = "내가 널 부숴주마."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "koKR")
if L then
	L.engage_yell = "내 전설은 지금부터 시작이다!"
end

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "koKR")
if L then
	L.engage_yell = "내 끝없는 고통을 너희들에게도 나눠주마!"
end

local L = BigWigs:NewBossLocale("The Headless Horseman", "koKR")
if not L then return end
if L then
	L.the_headless_horseman = "저주받은 기사"
	L.custom_on_autotalk = "자동 대화"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end
