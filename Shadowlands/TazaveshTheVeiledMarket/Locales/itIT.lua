local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "itIT")
if not L then return end
if L then
	L.zophex_warmup_trigger = "Consegnate... tutto... il contrabbando..."
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "itIT")
if L then
	L.achillite_warmup_trigger = "Delle bestie sfrenate vi rovinano la giornata? Abbiamo la soluzione!"
	L.venza_goldfuse_warmup_trigger = "È la mia occasione! Quell'ascia è mia!"
end

L = BigWigs:NewBossLocale("Mailroom Mayhem", "itIT")
if L then
	L.delivery_portal = "Portale di Consegna"
	--L.delivery_portal_desc = "Shows a timer for when the Delivery Portal will change locations."
end

L = BigWigs:NewBossLocale("Myza's Oasis", "itIT")
if L then
	-- L.add_wave_killed = "Add wave killed (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "itIT")
if L then
	--L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	--L.soazmi_warmup_trigger = "Excuse our intrusion, So'leah. I hope we caught you at an inconvenient time."
	L.portal_authority = "Amministratrice del Portale di Tazavesh"
	--L.custom_on_portal_autotalk = "Autotalk"
	--L.custom_on_portal_autotalk_desc = "Instantly open portals back to the entrance when talking to Broker NPCs."
	--L.trading_game = "Trading Game"
	--L.trading_game_desc = "Alerts with the right password during the Trading Game."
	--L.custom_on_trading_game_autotalk = "Autotalk"
	--L.custom_on_trading_game_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	L.password_triggers = {
		["Guscio d'Avorio"] = 53259,
		["Oasi di Zaffiro"] = 53260,
		["Palma di Giada"] = 53261,
		["Sabbia Dorata"] = 53262,
		["Tramonto d'Ambra"] = 53263,
		["Oceano di Smeraldo"] = 53264,
		["Gemma Rubino"] = 53265,
		["Pietra di Peltro"] = 53266,
		["Fiore Pallido"] = 53267,
		["Coltello Cremisi"] = 53268
	}

	L.interrogation_specialist = "Specialista in Interrogatori"
	L.portalmancer_zohonn = "Portalmante Zo'honn"
	L.armored_overseer_tracker_zokorss = "Sovrintendente Corazzato / Braccatore Zo'korss"
	L.tracker_zokorss = "Braccatore Zo'korss"
	L.ancient_core_hound = "Segugio del Nucleo Antico"
	L.enraged_direhorn = "Cornofurente Rabbioso"
	L.cartel_muscle = "Forzuto del Cartello"
	L.cartel_smuggler = "Contrabbandiere del Cartello"
	L.support_officer = "Ufficiale Ausiliario"
	L.defective_sorter = "Smistatore Difettoso"
	L.market_peacekeeper = "Pacificatore del Mercato"
	L.veteran_sparkcaster = "Lanciafaville Veterano"
	L.commerce_enforcer = "Esecutore del Commercio"
	L.commerce_enforcer_commander_zofar = "Esecutore del Commercio / Comandante Zo'far"
	L.commander_zofar = "Comandante Zo'far"

	L.tazavesh_soleahs_gambit = "Tazavesh: Azzardo di So'leah"
	L.murkbrine_scalebinder = "Vincolascaglie Acquasporca"
	L.murkbrine_shellcrusher = "Frantumagusci Acquasporca"
	L.coastwalker_goliath = "Mastodonte Calcacoste"
	L.stormforged_guardian = "Guardiano Forgiatuono"
	L.burly_deckhand = "Mozzo Smilzo"
	L.adorned_starseer = "Veggente Stellare Decorato"
	L.focused_ritualist = "Ritualista Concentrato"
	L.devoted_accomplice = "Complice Devoto"
end
