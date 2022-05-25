local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "esMX")
if not L then return end
if L then
	L.zophex_warmup_trigger = "Entrega... todo... el contrabando..."
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "esMX")
if L then
	L.achillite_warmup_trigger = "¿Las bestias devastadoras no os dejan vivir? ¡Tenemos la solución!"
	L.venza_goldfuse_warmup_trigger = "¡Es mi oportunidad! ¡El hacha será mía!"
end

L = BigWigs:NewBossLocale("Mailroom Mayhem", "esMX")
if L then
	L.delivery_portal = "Portal de entrega"
	--L.delivery_portal_desc = "Shows a timer for when the Delivery Portal will change locations."
end

L = BigWigs:NewBossLocale("Myza's Oasis", "esMX")
if L then
	-- L.add_wave_killed = "Add wave killed (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "esMX")
if L then
	--L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	L.soazmi_warmup_trigger = "Disculpa la intrusión, So'leah. Espero que sea un momento inoportuno." -- TODO unverified
	--L.trading_game = "Trading Game"
	--L.trading_game_desc = "Alerts with the right password during the Trading Game."
	L.custom_on_autotalk = "Hablar automáticamente"
	--L.custom_on_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	L.password_triggers = {
		["Caparazón de marfil"] = true,
		["Oasis de zafiro"] = true,
		["Palmera de jade"] = true,
		["Arena dorada"] = true,
		["Puesta de sol ambarina"] = true,
		["Océano esmeralda"] = true,
		["Gema de rubí"] = true,
		["Piedra de peltre"] = true,
		["Flor pálida"] = true,
		["Cuchillo carmesí"] = true
	}

	L.interrogation_specialist = "Especialista en interrogatorios"
	L.portalmancer_zohonn = "Portalmante Zo'honn"
	L.armored_overseer_tracker_zokorss = "Sobrestante acorazado / Rastreador Zo'korss"
	L.tracker_zokorss = "Rastreador Zo'korss"
	L.ancient_core_hound = "Can del Núcleo anciano"
	L.enraged_direhorn = "Cuernoatroz iracundo"
	L.cartel_muscle = "Matón del cártel"
	L.cartel_smuggler = "Contrabandista del cártel"
	L.support_officer = "Oficial de apoyo"
	L.defective_sorter = "Clasificador defectuoso"
	L.market_peacekeeper = "Pacificador del mercado"
	L.veteran_sparkcaster = "Chispaturgo veterano"
	L.commerce_enforcer = "Déspota comercial"
	L.commerce_enforcer_commander_zofar = "Déspota comercial / Comandante Zo'far"
	L.commander_zofar = "Comandante Zo'far"

	L.tazavesh_soleahs_gambit = "Tazavesh: Gambito de So'leah"
	L.murkbrine_scalebinder = "Sujetascamas Salmuerasucia"
	L.murkbrine_shellcrusher = "Rompeconchas Salmuerasucia"
	L.coastwalker_goliath = "Goliat caminacostas"
	L.stormforged_guardian = "Guardián Tronaforjado"
	L.burly_deckhand = "Marinero de cubierta fornido"
	L.adorned_starseer = "Vidente estelar adornado"
	L.focused_ritualist = "Ritualista enfocado"
	L.devoted_accomplice = "Cómplice devoto"
end
