local L = BigWigs:NewBossLocale("Karazhan Trash", "deDE")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt Barnes' Dialogoption zum Starten des Bosskampfes im Opernsaal."
	L.opera_hall_wikket_story_text = "Opernsaal: Wikket"
	L.opera_hall_wikket_story_trigger = "Halt die Gotsche" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Opernsaal: Westfall Story"
	L.opera_hall_westfall_story_trigger = "treffen wir auf zwei Liebende" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Opernsaal: Das schöne Biest"
	L.opera_hall_beautiful_beast_story_trigger = "eine Geschichte von Romantik und Wut" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Geisterhafter Philanthrop"
	L.skeletal_usher = "Skelettpförtner"
	L.spectral_attendant = "Spektraler Knecht"
	L.spectral_valet = "Spektraldiener"
	L.spectral_retainer = "Spektraler Anhänger"
	L.phantom_guardsman = "Phantomgardist"
	L.wholesome_hostess = "Sittsame Schankmaid"
	L.reformed_maiden = "Reformierte Jungfer"
	L.spectral_charger = "Spektrales Streitross"

	-- Return to Karazhan: Upper
	L.chess_event = "Das Schachspiel"
	L.king = "König"
end

L = BigWigs:NewBossLocale("Moroes", "deDE")
if L then
	L.cc = "Massenkontrolle"
	L.cc_desc = "Timer und Warnungen für die Massenkontrolle auf den Essensgästen."
end

L = BigWigs:NewBossLocale("Nightbane", "deDE")
if L then
	L.name = "Schrecken der Nacht"
end
