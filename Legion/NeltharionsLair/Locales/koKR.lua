local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "koKR")
if not L then return end
if L then
	L.breaker = "막돌 파괴자"
	L.hulk = "악성수정 괴수"
	L.gnasher = "돌가죽 뾰족니악어"
	L.trapper = "돌갑옷 속박투사"
end

L = BigWigs:NewBossLocale("Rokmora", "koKR")
if L then
	L.warmup_text = "로크모라 활성화"
	L.warmup_trigger = "나바로그? 이 배신자! 감히 침입자들을 끌고 여기 오다니!"
	L.warmup_trigger_2 = "어느 쪽이든, 매 순간을 다 즐겨 주지. 로크모라, 박살내라!"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "koKR")
if L then
	L.totems = "토템"
	L.bellow = "{193375} (토템)" -- Bellow of the Deeps (Totems)
end
