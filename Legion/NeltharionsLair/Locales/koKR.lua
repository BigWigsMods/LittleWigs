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
	--L.warmup_text = "Rokmora Active"
	--L.warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	--L.warmup_trigger_2 = "Either way, I will enjoy every moment of it. Rokmora, crush them!"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "koKR")
if L then
	L.totems = "토템"
	L.bellow = "{193375} (토템)" -- Bellow of the Deeps (Totems)
end
