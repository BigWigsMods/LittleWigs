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

	L.rune_desc = "지면에 소환의 룬이 생성됩니다. 사라질 때까지 악몽의 피조물이 생성됩니다."

	L.killed = "%s 처치"

	L.warmup_text = "카람 메이지스피어 활성화"
	L.warmup_trigger = "날 따라오다니 어리석군. 뒤틀린 황천이 내게 힘을 준다. 난 이미 너희의 상상 이상으로 강해졌다!"
	L.warmup_trigger2 = "침입자를 처단하라, 형제여!"
end

L = BigWigs:NewBossLocale("Kruul", "koKR")
if L then
	L.name = "대군주 크룰"
	L.inquisitor = "심문관 바리스"
	L.velen = "예언자 벨렌"

	L.warmup_trigger = "오만하고 멍청한 것들! 나에게는 수천 개의 세계에서 얻은 영혼의 힘이 흘러넘친다!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	L.nether_aberration_desc = "방 안에 황천 흉물을 생성하는 차원문을 소환합니다."

	L.smoldering_infernal = "이글거리는 지옥불정령"
	L.smoldering_infernal_desc = "이글거리는 지옥불정령을 소환합니다."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "koKR")
if L then
	L.erdris = "군주 에르드리스 쏜"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "타락한 되살아난 마법사"
	L.soldier = "타락한 되살아난 병사"
	L.arbalest = "타락한 되살아난 석궁병"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "koKR")
if L then
	L.name = "대마법사 실렘"
	L.corruptingShadows = "타락의 그림자"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "koKR")
if L then
	L.name = "아가타"
	L.imp_servant = "임프 하수인"
	L.fuming_imp = "독기 뿜는 임프"
	L.levia = "레비아" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	-- L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	-- L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	-- L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.absorb = "흡수"
	L.stacks = "중첩"
end

L = BigWigs:NewBossLocale("Sigryn", "koKR")
if L then
	L.sigryn = "시그린"
	L.jarl = "야를 벨브란드"
	L.faljar = "룬의 현자 팔리아르"

	-- L.warmup_trigger = "What's this? The outsider has come to stop me?"

	L.absorb = "흡수"
end
