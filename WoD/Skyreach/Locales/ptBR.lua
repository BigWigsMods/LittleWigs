local L = BigWigs:NewBossLocale("High Sage Viryx", "ptBR")
if not L then return end
if L then
	L.custom_on_markadd = "Marca do Zelote Solar"
	L.custom_on_markadd_desc = "Marca o Zelote Solar com {rt8}, requer promovido ou líder."

	L.construct = "Constructo-escudo de Beira-céu" -- NPC ID 76292
end
