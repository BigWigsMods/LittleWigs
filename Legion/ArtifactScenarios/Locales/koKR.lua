local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "koKR")
if not L then return end
if L then
	L.tugar = "투가르 블러드토템"
	L.jormog = "거수 요르모그"

	L.remaining = "비늘 남음"

	L.submerge = "숨기"
	L.submerge_desc = "땅 속으로 숨습니다, 담즙뱉기 지네 알을 소환하고 종유석을 떨어뜨립니다."

	L.charge_desc = "요르모그가 숨으면 주기적으로 당신에게 돌진합니다."

	L.rupture = "{243382} (X)"
	L.rupture_desc = "당신 밑에 X자 모양의 지옥 파열이 나타납니다. 5초 후 지면을 파열시켜 종유석이 솟아오르며 플레이어를 밀쳐냅니다."

	L.totem_warning = "토템이 당신을 공격합니다!"
end

L = BigWigs:NewBossLocale("Raest", "koKR")
if L then
	L.name = "라이스트 메이지스피어"

	L.handFromBeyond = "저 너머의 손"

	L.killed = "%s 처치"

	L.warmup_text = "카람 메이지스피어 활성화"
	L.warmup_trigger = "날 따라오다니 어리석군. 뒤틀린 황천이 내게 힘을 준다. 난 이미 너희의 상상 이상으로 강해졌다!"
	L.warmup_trigger2 = "침입자를 처단하라, 형제여!"
end

L = BigWigs:NewBossLocale("Kruul", "koKR")
if L then
	-- NPC Names
	L.name = "대군주 크룰"
	L.inquisitor = "심문관 바리스"
	L.velen = "예언자 벨렌"

	-- Triggers
	L.warmup_trigger = "오만하고 멍청한 것들! 나에게는 수천 개의 세계에서 얻은 영혼의 힘이 흘러넘친다!"

	-- Engage / Options
	L.engage_message = "대군주 크룰의 도전 전투 시작!"

	L.nether_aberration_desc = "방 안에 황천 흉물을 생성하는 차원문을 소환합니다."

	L.smoldering_infernal = "이글거리는 지옥불정령"
	L.smoldering_infernal_desc = "이글거리는 지옥불정령을 소환합니다."
end
