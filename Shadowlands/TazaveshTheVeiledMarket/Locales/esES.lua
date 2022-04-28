local L = BigWigs:NewBossLocale("Myza's Oasis", "esES") or BigWigs:NewBossLocale("Myza's Oasis", "esMX")
if not L then return end
if L then
	-- L.add_wave_killed = "Add wave killed (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "esES") or BigWigs:NewBossLocale("Tazavesh Trash", "esMX")
if L then
	L.zophex_warmup_trigger = "Entrega... todo... el contrabando..."
	--L.menagerie_warmup_trigger1 = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	L.menagerie_warmup_trigger2 = "¿Las bestias devastadoras no os dejan vivir? ¡Tenemos la solución!"
	L.menagerie_warmup_trigger3 = "¡Es mi oportunidad! ¡El hacha será mía!"
	L.soazmi_warmup_trigger = "Disculpa la intrusión, So'leah. Espero que sea un momento inoportuno."
	--L.trading_game = "Trading Game"
	--L.trading_game_desc = "Alerts with the right password during the Trading Game."
	L.custom_on_autotalk = "Hablar automáticamente"
	--L.custom_on_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	--[[L.password_triggers = {
		["Ivory Shell"] = true,
		["Sapphire Oasis"] = true,
		["Jade Palm"] = true,
		["Golden Sands"] = true,
		["Amber Sunset"] = true,
		["Emerald Ocean"] = true,
		["Ruby Gem"] = true,
		["Pewter Stone"] = true,
		["Pale Flower"] = true,
		["Crimson Knife"] = true
	}]]--

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

	L.murkbrine_scalebinder = "Sujetascamas Salmuerasucia"
	L.murkbrine_shellcrusher = "Rompeconchas Salmuerasucia"
	L.coastwalker_goliath = "Goliat caminacostas"
	L.stormforged_guardian = "Guardián Tronaforjado"
	L.burly_deckhand = "Marinero de cubierta fornido"
	L.adorned_starseer = "Vidente estelar adornado"
	L.focused_ritualist = "Ritualista enfocado"
	L.devoted_accomplice = "Cómplice devoto"
end
