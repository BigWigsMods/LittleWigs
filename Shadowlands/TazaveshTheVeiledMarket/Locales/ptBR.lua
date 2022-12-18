local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "ptBR")
if not L then return end
if L then
	L.zophex_warmup_trigger = "Entregue... todo... o contrabando..."
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "ptBR")
if L then
	L.achillite_warmup_trigger = "Problemas com feras desgovernadas? Nós temos a solução!"
	L.venza_goldfuse_warmup_trigger = "É a minha chance! Esse machado será meu!"
end

L = BigWigs:NewBossLocale("Mailroom Mayhem", "ptBR")
if L then
	L.delivery_portal = "Portal de Entrega"
	--L.delivery_portal_desc = "Shows a timer for when the Delivery Portal will change locations."
end

L = BigWigs:NewBossLocale("Myza's Oasis", "ptBR")
if L then
	L.add_wave_killed = "Onda de adds derrotada (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "ptBR")
if L then
	--L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	L.soazmi_warmup_trigger = "Lamento a intrusão, So'leah. Espero que o momento seja bem inoportuno."
	L.portal_authority = "Autoridade do Portal de Tazavesh"
	L.custom_on_portal_autotalk = "Conversa automática"
	--L.custom_on_portal_autotalk_desc = "Instantly open portals back to the entrance when talking to Broker NPCs."
	--L.trading_game = "Trading Game"
	--L.trading_game_desc = "Alerts with the right password during the Trading Game."
	L.custom_on_trading_game_autotalk = "Conversa automática"
	--L.custom_on_trading_game_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	L.password_triggers = {
		["Concha de Marfim"] = 53259,
		["Oásis de Safira"] = 53260,
		["Palmeira de Jade"] = 53261,
		["Areia Dourada"] = 53262,
		["Âmbar Crepúsculo"] = 53263,
		["Oceano Esmeralda"] = 53264,
		["Gema de Rubi"] = 53265,
		["Pedra de Estanho"] = 53266,
		["Flor Pálida"] = 53267,
		["Faca Carmesim"] = 53268
	}

	L.interrogation_specialist = "Especialista em Interrogatório"
	L.portalmancer_zohonn = "Portalmante Zo'honn"
	L.armored_overseer_tracker_zokorss = "Feitor Blindado / Rastreador Zo'korss"
	L.tracker_zokorss = "Rastreador Zo'korss"
	L.ancient_core_hound = "Cão-magma Ancião"
	L.enraged_direhorn = "Escornante Enfurecido"
	L.cartel_muscle = "Jagunço do Cartel"
	L.cartel_smuggler = "Contrabandista do Cartel"
	L.support_officer = "Oficial de Apoio"
	L.defective_sorter = "Separador Defeituoso"
	L.market_peacekeeper = "Pacificador do Mercado"
	L.veteran_sparkcaster = "Lançafagulha Veterano"
	L.commerce_enforcer = "Impositor do Comércio"
	L.commerce_enforcer_commander_zofar = "Impositor do Comércio / Comandante Zo'far"
	L.commander_zofar = "Comandante Zo'far"

	L.tazavesh_soleahs_gambit = "Tazavesh: Gambito de So'leah"
	L.murkbrine_scalebinder = "Torce-escamas Lodorrento"
	L.murkbrine_shellcrusher = "Parte-cascos Lodorrento"
	L.coastwalker_goliath = "Golias Costâmbulo"
	L.stormforged_guardian = "Guardião Forjado em Tempestade"
	L.burly_deckhand = "Marujo Parrudo"
	L.adorned_starseer = "Clarividente Adornado"
	L.focused_ritualist = "Ritualista Concentrado"
	L.devoted_accomplice = "Cúmplice Devoto"
end
