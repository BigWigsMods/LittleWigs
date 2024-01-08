local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "deDE")
if not L then return end
if L then
	L.nazjar_oracle = "Orakel der Naz'jar"
	L.vicious_snap_dragon = "Boshaftes Löwenmäulchen"
	L.nazjar_sentinel = "Schildwache der Naz'jar"
	L.nazjar_ravager = "Verheerer der Naz'jar"
	L.nazjar_tempest_witch = "Sturmhexe der Naz'jar"
	L.faceless_seer = "Gesichtsloser Seher"
	L.faceless_watcher = "Gesichtsloser Beobachter"
	L.tainted_sentry = "Besudelter Wachposten"

	L.ozumat_warmup_trigger = "Die Bestie ist zurück! Das Wasser darf nicht verschmutzt werden!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "deDE")
if L then
	L.high_tide_trigger1 = "Zu den Waffen, meine Diener! Entsteigt den eisigen Tiefen!"
	L.high_tide_trigger2 = "Vernichtet die Eindringlinge! Überlasst sie den Großen Dunklen Weiten!"
end

L = BigWigs:NewBossLocale("Ozumat", "deDE")
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoption zum Beginn des Kampfes."
end
