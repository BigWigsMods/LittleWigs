local L = BigWigs:NewBossLocale("Karazhan Trash", "esMX")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "Hablar automáticamente"
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Sala de la Ópera: makaku"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Sala de la Ópera: Páramos de Poniente"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Sala de la Ópera: bestia hermosa"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Filántropo fantasmal"
	L.skeletal_usher = "Ujier esquelético"
	L.spectral_attendant = "Auxiliar espectral"
	L.spectral_valet = "Ayuda de cámara espectral"
	L.spectral_retainer = "Criado espectral"
	L.phantom_guardsman = "Aparición de custodio"
	L.wholesome_hostess = "Anfitriona saludable"
	L.reformed_maiden = "Doncella reformada"
	L.spectral_charger = "Destrero espectral"

	-- Return to Karazhan: Upper
	L.chess_event = "Evento del Ajedrez"
	L.king = "Rey"
end

L = BigWigs:NewBossLocale("Moroes", "esMX")
if L then
	L.cc = "Control de masas"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "esMX")
if L then
	L.name = "Nocturno"
end
