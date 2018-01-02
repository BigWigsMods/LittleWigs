local L = BigWigs:NewBossLocale("Corborus", "frFR")
if not L then return end
if L then
	L.burrow = "Fouir/Émergence"
	L.burrow_desc = "Prévient quand Corborus s'enterre ou émerge."
	L.burrow_message = "Corborus s'enterre"
	L.burrow_warning = "Fouir dans 5 sec. !"
	L.emerge_message = "Corborus émerge !"
	L.emerge_warning = "Émergence dans 5 sec. !"
end
