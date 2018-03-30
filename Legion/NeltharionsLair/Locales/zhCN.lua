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
	L.warmup_text = "洛克莫拉激活"
	L.warmup_trigger = "纳瓦罗格？！叛徒！你想带领这些入侵者对抗我们吗？！"
	L.warmup_trigger_2 = "无论如何，我都会好好享受它每一刻的。洛克莫拉，碾碎他们！"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "zhCN")
if L then
	L.totems = "雕像"
	L.bellow = "{193375}（雕像）" -- Bellow of the Deeps (Totems)
end
