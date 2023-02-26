local L = BigWigs:NewBossLocale("Odyn", "deDE")
if not L then return end
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoption zum Starten des Kampfes."

	L.gossip_available = "Dialog verfügbar"
	L.gossip_trigger = "Höchst beeindruckend! Ich hielt die Kräfte der Valarjar stets für unerreicht... und dennoch steht Ihr hier vor mir."

	L[197963] = "|cFF800080Oben rechts|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500Unten rechts|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00Unten links|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FFOben links|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000Oben|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "deDE")
if L then
	L.warmup_text = "Gottkönig Skovald aktiv"
	L.warmup_trigger = "Die Sieger haben ihren Anspruch geltend gemacht, Skovald, wie es ihr Recht ist. Euer Protest kommt zu spät."
	L.warmup_trigger_2 = "Wenn sie die Aegis nicht aus freien Stücken übergeben... dann soll ihr Tod mir diesen Dienst erweisen!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "deDE")
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoption zum Starten der Kämpfe."

	L.mug_of_mead = "Metkrug"
	L.valarjar_thundercaller = "Donnerrufer der Valarjar"
	L.storm_drake = "Sturmdrache"
	L.stormforged_sentinel = "Sturmgeschmiedeter Wächter"
	L.valarjar_runecarver = "Runenmetz der Valarjar"
	L.valarjar_mystic = "Mystiker der Valarjar"
	L.valarjar_purifier = "Läuterer der Valarjar"
	L.valarjar_shieldmaiden = "Schildmaid der Valarjar"
	L.valarjar_aspirant = "Aspirantin der Valarjar"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr der Erleuchtete"
	L.valarjar_marksman = "Schützin der Valarjar"
	L.gildedfur_stag = "Goldfellhirsch"
	L.angerhoof_bull = "Zornhufbulle"
	L.valarjar_trapper = "Fallensteller der Valarjar"
	L.fourkings = "Die Vier Könige"
end
