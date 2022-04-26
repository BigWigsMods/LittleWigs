local L = BigWigs:NewBossLocale("Myza's Oasis", "deDE")
if not L then return end
if L then
	L.add_wave_killed = "Add Welle getötet (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "deDE")
if L then
	--L.zophex_warmup_trigger = "Surrender... all... contraband..."
	--L.soazmi_warmup_trigger = "Excuse our intrusion, So'leah. I hope we caught you at an inconvenient time."
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

	L.interrogation_specialist = "Verhörspezialist"
	L.portalmancer_zohonn = "Portalmagier Zo'honn"
	L.armored_overseer_tracker_zokorss = "Gepanzerter Aufseher / Fährtenleser Zo'korss"
	L.tracker_zokorss = "Fährtenleser Zo'korss"
	L.ancient_core_hound = "Uralter Kernhund"
	L.enraged_direhorn = "Wütendes Terrorhorn"
	L.cartel_muscle = "Kartellkraftprotz"
	L.cartel_smuggler = "Kartellschmuggler"
	L.support_officer = "Unterstützungsoffizier"
	L.defective_sorter = "Defekter Sortierer"
	L.market_peacekeeper = "Friedensbewahrer des Marktes"
	L.veteran_sparkcaster = "Erfahrener Funkenzauberer"
	L.commerce_enforcer = "Handelsvollstrecker"
	L.commerce_enforcer_commander_zofar = "Handelsvollstrecker / Kommandant Zo'far"
	L.commander_zofar = "Kommandant Zo'far"

	L.murkbrine_scalebinder = "Schuppenbinder der Finstergischt"
	L.murkbrine_shellcrusher = "Panzerbrecher der Finstergischt"
	L.coastwalker_goliath = "Küstenschreitergoliath"
	L.stormforged_guardian = "Sturmgeschmiedeter Wächter"
	L.burly_deckhand = "Bulliger Deckmatrose"
	L.adorned_starseer = "Geschmückter Sternenseher"
	L.focused_ritualist = "Fokussierter Ritualist"
	L.devoted_accomplice = "Hingebungsvoller Komplize"
end
