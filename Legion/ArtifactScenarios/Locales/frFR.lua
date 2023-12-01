local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "frFR")
if not L then return end
if L then
	L.tugar = "Tugar Totem-de-Sang"
	L.jormog = "Jormog le Béhémoth"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "frFR")
if L then
	L.name = "Raëst Magelance"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.killed = "%s killed"

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "frFR")
if L then
	L.name = "Généralissime Kruul"
	L.inquisitor = "Inquisiteur Variss"
	L.velen = "Prophète Velen"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "frFR")
if L then
	L.erdris = "Seigneur Erdris Epine"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Mage ressuscité corrompu"
	L.soldier = "Soldat ressuscité corrompu"
	L.arbalest = "Arbalestrier ressuscité corrompu"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "frFR")
if L then
	L.name = "Archimage Xylem"
	L.corruptingShadows = "Ombres corruptrices"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "frFR")
if L then
	L.name = "Agatha"
	L.imp_servant = "Diablotin serviteur"
	L.fuming_imp = "Diablotin furieux"
	L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	-- L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	-- L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	-- L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.absorb = "Absorb."
	L.stacks = "Cumuls"
end

L = BigWigs:NewBossLocale("Sigryn", "frFR")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Voyant des runes Faljar"

	-- L.warmup_trigger = "What's this? The outsider has come to stop me?"

	L.absorb = "Absorb."
end
