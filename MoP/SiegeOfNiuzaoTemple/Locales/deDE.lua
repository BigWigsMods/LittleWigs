local L = BigWigs:NewBossLocale("Commander Vo'jak", "deDE")
if not L then return end
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoption zum Starten des Kampfes."
end
