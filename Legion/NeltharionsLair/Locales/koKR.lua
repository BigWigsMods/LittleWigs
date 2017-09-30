local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "koKR")
if not L then return end
if L then
	L.breaker = "막돌 파괴자"
	L.hulk = "악성수정 괴수"
	--L.gnasher = "Rockback Gnasher"
	--L.trapper = "Rockbound Trapper"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "koKR")
if L then
  L.totems = "토템"
  L.bellow = "{193375} (토템)" -- Bellow of the Deeps (Totems)
end
