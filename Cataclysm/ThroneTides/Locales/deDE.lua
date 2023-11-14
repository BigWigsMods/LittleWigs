local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "deDE")
if not L then return end
if L then
	L.nazjar_oracle = "Orakel der Naz'jar"
	--L.vicious_snap_dragon = "Vicious Snap Dragon"
	L.nazjar_sentinel = "Schildwache der Naz'jar"
	L.nazjar_ravager = "Verheerer der Naz'jar"
	L.nazjar_tempest_witch = "Sturmhexe der Naz'jar"
	L.faceless_seer = "Gesichtsloser Seher"
	L.faceless_watcher = "Gesichtsloser Beobachter"
	--L.tainted_sentry = "Tainted Sentry"
end

L = BigWigs:NewBossLocale("Ozumat", "deDE")
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoption zum Beginn des Kampfes."
end
