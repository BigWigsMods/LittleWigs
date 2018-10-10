local L = BigWigs:NewBossLocale("High Sage Viryx", "deDE")
if not L then return end
if L then
	L.custom_on_markadd = "Sonnenzeloten markieren"
	L.custom_on_markadd_desc = "Markiert den Sonnenzeloten mit {rt8}, benötigt Assistent oder Leiter."

	L.add = "Konstrukt erscheint"
	L.add_desc = "Warnung für das Erscheinen des Schildkonstruktes."
end
