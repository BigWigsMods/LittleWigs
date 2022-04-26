local L = BigWigs:NewBossLocale("Myza's Oasis", "frFR")
if not L then return end
if L then
	 L.add_wave_killed = "Vague d'adds tuée (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "frFR")
if L then
	--L.zophex_warmup_trigger = "Surrender... all... contraband..."
	L.soazmi_warmup_trigger = "Pardonnez notre intrusion, So’leah. J’espère que nous ne vous dérangeons pas."
	--L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	--L.trading_game = "Trading Game"
	--L.trading_game_desc = "Alerts with the right password during the Trading Game."
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	--[[L.password_triggers = {
		"Ivory Shell",
		"Amber Sunset",
		"Crimson Knife",
		"Emerald Ocean",
		"Golden Sands",
		"Jade Palm",
		"Pale Flower",
		"Pewter Stone",
		"Ruby Gem",
		"Sapphire Oasis"
	}]]--

	L.interrogation_specialist = "Spécialiste en interrogatoire"
	L.portalmancer_zohonn = "Portomancien Zo'honn"
	L.armored_overseer_tracker_zokorss = "Surveillant cuirassé / Pisteur Zo'korss"
	L.tracker_zokorss = "Pisteur Zo'korss"
	L.ancient_core_hound = "Ancien chien du magma"
	L.enraged_direhorn = "Navrecorne enragé"
	L.cartel_muscle = "Gros-bras du cartel"
	L.cartel_smuggler = "Contrebandier du cartel"
	L.support_officer = "Agent de soutien"
	L.defective_sorter = "Trieur défectueux"
	L.market_peacekeeper = "Garde-paix du marché"
	L.veteran_sparkcaster = "Embraseur vétéran"
	L.commerce_enforcer = "Massacreur du marché"
	L.commerce_enforcer_commander_zofar = "Massacreur du marché / Commandant Zo'far"
	L.commander_zofar = "Commandant Zo'far"

	L.murkbrine_scalebinder = "Lieur d'écailles bourbe-sel"
	L.murkbrine_shellcrusher = "Brise-conque bourbe-sel"
	L.coastwalker_goliath = "Goliath marche-côte"
	L.stormforged_guardian = "Gardien forge-foudren"
	L.burly_deckhand = "Matelot costaud"
	L.adorned_starseer = "Stellomancien distingué"
	L.focused_ritualist = "Ritualiste concentré"
	L.devoted_accomplice = "Complice loyal"
end
