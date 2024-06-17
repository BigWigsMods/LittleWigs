local L = BigWigs:NewBossLocale("High Sage Viryx", "deDE")
if not L then return end
if L then
	L.custom_on_markadd = "Sonnenzeloten markieren"
	L.custom_on_markadd_desc = "Markiert den Sonnenzeloten mit {rt8}, benötigt Assistent oder Leiter."

	L.construct = "Schildkonstrukt der Himmelsnadel" -- NPC ID 76292
end
