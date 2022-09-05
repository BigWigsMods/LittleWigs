local L = BigWigs:NewBossLocale("Karazhan Trash", "ptBR")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "Conversa Automática"
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de conversa com Barnes para iniciar o encontro no Salão de Ópera."
	L.opera_hall_wikket_story_text = "Salão de Ópera: Wikket"
	L.opera_hall_wikket_story_trigger = "Pare de falatório" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Salão de Ópera: História de Westfall"
	L.opera_hall_westfall_story_trigger = "nós encontramos dois amantes" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Salão de Ópera: A Bela e a Fera"
	L.opera_hall_beautiful_beast_story_trigger = "um conto de romance e raiva" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Filantropo Fantasma"
	L.skeletal_usher = "Porteiro Cadavérico"
	L.spectral_attendant = "Criado Espectral"
	L.spectral_valet = "Pajem Espectral"
	L.spectral_retainer = "Escudeiro Espectral"
	L.phantom_guardsman = "Guarda Fantasma"
	L.wholesome_hostess = "Anfitriã Respeitável"
	L.reformed_maiden = "Donzela Reabilitada"
	L.spectral_charger = "Corcel Espectral"

	-- Return to Karazhan: Upper
	L.chess_event = "Evento de Xadrez"
	L.king = "Rei"
end

L = BigWigs:NewBossLocale("Moroes", "ptBR")
if L then
	L.cc = "Controle Coletivo"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "ptBR")
if L then
	L.name = "Nocturno"
end
