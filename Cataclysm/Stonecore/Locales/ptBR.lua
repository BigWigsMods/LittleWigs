local L = BigWigs:NewBossLocale("Corborus", "ptBR")
if not L then return end
if L then
	L.burrow = "Afunda/emerge"
	L.burrow_desc = "Avisa quando Corborus afunda ou emerge."
	L.burrow_message = "Corborus afundou!"
	L.burrow_warning = "Afundará em 5 seg!"
	L.emerge_message = "Corborus emergiu!"
	L.emerge_warning = "Emergirá em 5 seg!"
end
