local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "deDE")
if not L then return end
if L then
	L.breaker = "Machtsteinbrecher"
	L.hulk = "Ekelsplittergigant"
	L.gnasher = "Steinrückenknirscher"
	L.trapper = "Steingebundener Fallensteller"
end

L = BigWigs:NewBossLocale("Rokmora", "deDE")
if L then
	L.warmup_text = "Rokmora aktiv"
	L.warmup_trigger = "Navarrogg?! Verräter! Ihr führt diese Eindringlinge gegen uns ins Feld?!"
	L.warmup_trigger_2 = "Sei's drum, ich werde jeden Moment davon genießen. Rokmora, zerschmettert sie!"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "deDE")
if L then
	L.totems = "Götzen"
	L.bellow = "{193375} (Götzen)" -- Bellow of the Deeps (Totems)
end
