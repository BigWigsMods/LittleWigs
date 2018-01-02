local L = BigWigs:NewBossLocale("Corborus", "esES") or BigWigs:NewBossLocale("Corborus", "esMX")
if not L then return end
if L then
	L.burrow = "Esconderse/emerger"
	L.burrow_desc = "Avisar cuando Corborus se esconde o emerge."
	L.burrow_message = "Corborus se esconde"
	L.burrow_warning = "¡Se esconde en 5 seg!"
	L.emerge_message = "¡Corborus emerge!"
	L.emerge_warning = "¡Emerge en 5 seg!"
end
