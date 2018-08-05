local L = BigWigs:NewBossLocale("Cordana Felsong", "koKR")
if not L then return end
if L then
	L.kick_combo = "발차기 연계"

	L.light_dropped = "%s님이 빛을 떨어뜨렸습니다."
	L.light_picked = "%s님이 빛을 주웠습니다."

	L.warmup_text = "콜다나 펠송 활성화"
	L.warmup_trigger = "난 이미 원하는 걸 손에 넣었다. 그저 기다렸을 뿐... 너희를 확실히 끝장낼 순간을 말이다!"
	L.warmup_trigger_2 = "바보 녀석들이 내 덫에 걸려들었구나. 어둠 속에서 얼마나 잘 싸우는지 보자."
end

L = BigWigs:NewBossLocale("Glazer", "koKR")
if L then
	--L.radiation_level = "%s: %d%%"
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "koKR")
if L then
	L.warmup_trigger = [[나는 추방당하고 버려진 "나의" 일족을 섬기겠다.]]
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "koKR")
if L then
	L.infester = "지옥서약 감염자"
	L.myrmidon = "지옥서약 미르미돈"
	L.fury = "지옥 마력 격노병"
	L.mother = "부정한 어미"
	L.illianna = "칼춤꾼 일리아나"
	L.mendacius = "공포군주 멘다시우스"
	L.grimhorn = "험악뿔 구속자"
end
