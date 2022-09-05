local L = BigWigs:NewBossLocale("Karazhan Trash", "itIT")
if not L then return end
if L then
	-- Opera Event
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Teatro: Il Mago di Hoz"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Teatro: Mrrgria"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Teatro: La Bella e il Bruto"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Filantropo Fantasma"
	L.skeletal_usher = "Usciere Scheletrico"
	L.spectral_attendant = "Attendente Spettrale"
	L.spectral_valet = "Maschera Spettrale"
	L.spectral_retainer = "Lacchè Spettrale"
	L.phantom_guardsman = "Armigero Fantasma"
	L.wholesome_hostess = "Cameriera Integerrima"
	L.reformed_maiden = "Dama Ravveduta"
	L.spectral_charger = "Gran Destriero Spettrale"

	-- Return to Karazhan: Upper
	L.chess_event = "Evento degli Scacchi"
	L.king = "Re"
end

L = BigWigs:NewBossLocale("Moroes", "itIT")
if L then
	L.cc = "Controllo delle Creature"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "itIT")
if L then
	L.name = "Noctumor"
end
