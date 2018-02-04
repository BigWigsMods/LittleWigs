local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "zhCN")
if not L then return end
if L then
	L.breaker = "巨石破坏者"
	L.hulk = "邪裂巨人"
	L.gnasher = "岩背啮咬者"
	L.trapper = "缚石捕兽者"
end

L = BigWigs:NewBossLocale("Rokmora", "zhCN")
if L then
	--L.warmup_text = "Rokmora Active"
	--L.warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	--L.warmup_trigger_2 = "Either way, I will enjoy every moment of it. Rokmora, crush them!"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "zhCN")
if L then
	L.totems = "雕像"
	L.bellow = "{193375}（雕像）" -- Bellow of the Deeps (Totems)
end
