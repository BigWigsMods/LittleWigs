local L = BigWigs:NewBossLocale("Vexallus", "esES") or BigWigs:NewBossLocale("Vexallus", "esMX")
if not L then return end
if L then
	--L.adds. = "Pure Energy"
	--L.adds_desc = "Warn when Pure Energy is discharged."
	--L.adds_message = "Pure Energy discharged!"
	--L.adds_trigger = "discharges pure energy!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "esES") or BigWigs:NewBossLocale("Magisters' Terrace Trash", "esMX")
if L then
	L.mage_guard = "Guardia mago Filosol"
	L.magister = "Magister Filosol"
	L.keeper = "Vigilante Filosol"
end
