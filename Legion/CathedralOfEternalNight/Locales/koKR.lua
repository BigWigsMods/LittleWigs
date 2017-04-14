local L = BigWigs:NewBossLocale("Mephistroth", "koKR")
if not L then return end
if L then
	L.custom_on_time_lost = "그림자 소실 단계 동안 잃어버린 시간"
	L.custom_on_time_lost_desc = "그림자 소실 단계 동안 잃어버린 시간을 바에 |cffff0000붉은색|r으로 표시합니다."
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "koKR")
if L then
	L.felguard = "지옥수호병 파괴자"
	L.soulmender = "지옥불길 영혼치유사"
	L.temptress = "지옥불길 요녀"
	--L.botanist = "Felborne Botanist"
	L.orbcaster = "지옥길잡이 보주술사"
	L.waglur = "와글루르"
	L.gazerax = "가제락스"
end
