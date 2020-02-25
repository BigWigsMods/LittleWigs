local L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "deDE")
if not L then return end
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoptionen von Erozion, Thrall und Taretha."

	L.incendiary_bombs = "Brandbomben"
	L.incendiary_bombs_desc = "Eine Nachricht anzeigen wenn Brandbomben gelegt werden."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "deDE")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	L.warmup_trigger = "holt schnell"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "deDE")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	L.warmup_trigger = "Schwarzmoor Rede und Antwort stehen"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "deDE")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	L.trash_warmup_trigger = "lästigen Freunde"
	-- Enough, I will erase your very existence!
	L.boss_warmup_trigger = "Existenz auslöschen!"
end
