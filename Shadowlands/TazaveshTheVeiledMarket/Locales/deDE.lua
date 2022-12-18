local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "deDE")
if not L then return end
if L then
	L.zophex_warmup_trigger = "Gebt alle... Schmuggelware... ab..."
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "deDE")
if L then
	L.achillite_warmup_trigger = "Ruinieren Euch rasende Riesenbestien den Tag? Wir haben die Lösung!"
	L.venza_goldfuse_warmup_trigger = "Das ist meine Chance! Die Axt gehört mir!"
end

L = BigWigs:NewBossLocale("Mailroom Mayhem", "deDE")
if L then
	L.delivery_portal = "Zustellportal"
	L.delivery_portal_desc = "Zeigt einen Timer für die Änderung der Position des Zustellportals."
end

L = BigWigs:NewBossLocale("Myza's Oasis", "deDE")
if L then
	L.add_wave_killed = "Add Welle getötet (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "deDE")
if L then
	L.menagerie_warmup_trigger = "Und nun zu dem Posten, auf den alle warten! Die angeblich dämonenverfluchte Schneide des Vergessens!"
	L.soazmi_warmup_trigger = "Entschuldigt unser Eindringen, So'leah. Ich hoffe, wir stören."
	L.portal_authority = "Portalbehörde von Tazavesh"
	L.custom_on_portal_autotalk = "Automatisch ansprechen"
	L.custom_on_portal_autotalk_desc = "Portale zurück zum Eingang sofort öffnen wenn mit Mittlern gesprochen wird."
	L.trading_game = "Handels-Event"
	L.trading_game_desc = "Warnungen mit korrektem Password während des Handels-Event."
	L.custom_on_trading_game_autotalk = "Automatisch ansprechen"
	L.custom_on_trading_game_autotalk_desc = "Wählt direkt das korrekte Passwort nach Abschluss des Handels-Events."
	L.password_triggers = {
		["Elfenbeinmuschel"] = 53259,
		["Saphiroase"] = 53260,
		["Jadepalme"] = 53261,
		["Goldsand"] = 53262,
		["Berndämmerung"] = 53263,
		["Smaragdozean"] = 53264,
		["Rubinedelstein"] = 53265,
		["Zinngestein"] = 53266,
		["Fahlblume"] = 53267,
		["Purpurmesser"] = 53268
	}
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

	L.tazavesh_soleahs_gambit = "Tazavesh: So'leahs Schachzug"
	L.murkbrine_scalebinder = "Schuppenbinder der Finstergischt"
	L.murkbrine_shellcrusher = "Panzerbrecher der Finstergischt"
	L.coastwalker_goliath = "Küstenschreitergoliath"
	L.stormforged_guardian = "Sturmgeschmiedeter Wächter"
	L.burly_deckhand = "Bulliger Deckmatrose"
	L.adorned_starseer = "Geschmückter Sternenseher"
	L.focused_ritualist = "Fokussierter Ritualist"
	L.devoted_accomplice = "Hingebungsvoller Komplize"
end
