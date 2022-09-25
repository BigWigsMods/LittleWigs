local L = BigWigs:NewBossLocale("Karazhan Trash", "frFR")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "Parler automatiquement"
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Opéra : Lokdu"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Opéra : De l’amour à la mer"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Opéra : La belle bête"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Philanthrope fantomatique"
	L.skeletal_usher = "Ouvreur squelettique"
	L.spectral_attendant = "Domestique spectral"
	L.spectral_valet = "Valet spectral"
	L.spectral_retainer = "Factotum spectral"
	L.phantom_guardsman = "Garde fantôme"
	L.wholesome_hostess = "Hôtesse saine"
	L.reformed_maiden = "Damoiselle repentie"
	L.spectral_charger = "Destrier spectral"

	-- Return to Karazhan: Upper
	L.chess_event = "Évènement de l’échiquier"
	L.king = "Roi"
end

L = BigWigs:NewBossLocale("Moroes", "frFR")
if L then
	L.cc = "Contrôle des foules"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "frFR")
if L then
	L.name = "Plaie-de-Nuit"
end
