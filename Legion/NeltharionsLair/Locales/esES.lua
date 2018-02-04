local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "esES") or BigWigs:NewBossLocale("Neltharions Lair Trash", "esMX")
if not L then return end
if L then
	L.breaker = "Destructor de Petrofuerza"
	--L.hulk = "Vileshard Hulk"
	--L.gnasher = "Rockback Gnasher"
	--L.trapper = "Rockbound Trapper"
end

L = BigWigs:NewBossLocale("Rokmora", "esES") or BigWigs:NewBossLocale("Rokmora", "esMX")
if L then
	--L.warmup_text = "Rokmora Active"
	--L.warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	--L.warmup_trigger_2 = "Either way, I will enjoy every moment of it. Rokmora, crush them!"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "esES") or BigWigs:NewBossLocale("Ularogg Cragshaper", "esMX")
if L then
	--L.totems = "Totems"
	--L.bellow = "{193375} (Totems)" -- Bellow of the Deeps (Totems)
end
