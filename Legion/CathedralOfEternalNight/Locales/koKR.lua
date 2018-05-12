local L = BigWigs:NewBossLocale("Mephistroth", "koKR")
if not L then return end
if L then
	L.custom_on_time_lost = "그림자 소실 단계 동안 잃어버린 시간"
	L.custom_on_time_lost_desc = "그림자 소실 단계 동안 잃어버린 시간을 바에 |cffff0000붉은색|r으로 표시합니다."
end

L = BigWigs:NewBossLocale("Domatrax", "koKR")
if L then
	L.custom_on_autotalk = "자동 대화"
	L.custom_on_autotalk_desc = "도마트락스 전투를 시작하는 아그라마르의 아이기스 대화 선택지를 즉시 선택합니다."

	L.missing_aegis = "아이기스 효과 없음!" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "아그라마르의 아이기스: 힐량 감소"
	L.aegis_damage = "아그라마르의 아이기스: 데미지 감소"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "koKR")
if L then
	L.dulzak = "둘자크"
	L.wrathguard = "지옥수호병 침략자"
	L.felguard = "지옥수호병 파괴자"
	L.soulmender = "지옥불길 영혼치유사"
	L.temptress = "지옥불길 요녀"
	L.botanist = "지옥살이 식물학자"
	L.orbcaster = "지옥길잡이 보주술사"
	L.waglur = "와글루르"
	L.scavenger = "고룡혓바닥 청소부"
	L.gazerax = "가제락스"
	L.vilebark = "썩은나무껍질 방랑자"

	L.throw_tome = "고서 던지기" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end
