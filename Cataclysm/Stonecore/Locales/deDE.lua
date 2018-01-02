local L = BigWigs:NewBossLocale("Corborus", "deDE")
if not L then return end
if L then
	L.burrow = "Auf-/Abtauchen"
	L.burrow_desc = "Warnt, wenn Corborus auf- oder abtaucht."
	L.burrow_message = "Corborus taucht ab!"
	L.burrow_warning = "Abtauchen in 5 sek!"
	L.emerge_message = "Corborus taucht auf!"
	L.emerge_warning = "Auftauchen in 5 sek!"
end
