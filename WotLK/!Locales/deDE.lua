-- Ahn'kahet: The Old Kingdom

local L = BigWigs:NewBossLocale("Ahn'kahet Trash", "deDE")
if not L then return end
if L then
	L.spellflinger = "Zauberwerfer der Ahn'kahar"
	L.eye = "Auge von Taldaram"
	L.darkcaster = "Zwielichtdunkelzauberer"
end

-- Gundrak

L = BigWigs:NewBossLocale("Gal'darah", "deDE")
if L then
	L.forms = "Formen"
	L.forms_desc = "Warnen bevor Gal'darah seine Form ändert."

	L.form_rhino = "Dinoform"
	L.form_troll = "Trollform"
end

-- Halls of Lightning

L = BigWigs:NewBossLocale("Halls of Lightning Trash", "deDE")
if L then
	L.runeshaper = "Sturmgeschmiedeter Runenformer"
	L.sentinel = "Sturmgeschmiedete Schildwache"
end

-- Halls of Stone

L = BigWigs:NewBossLocale("Tribunal of Ages", "deDE")
if L then
	L.engage_trigger = "Haltet jetzt die Augen offen" -- Now keep an eye out! I'll have this licked in two shakes of a--
	L.defeat_trigger = "Die alten, magischen Finger" --  Ha! The old magic fingers finally won through! Now let's get down to--
	L.fail_trigger = "Noch nicht... noch nich--"

	L.timers = "Timer"
	L.timers_desc = "Timer für diverse eintretende Ereignisse."

	L.victory = "Sieg"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "deDE")
if L then
	L.custom_on_autotalk_desc = "Wählt direkt Chromies und Arthas' Dialogoptionen."

	L.gossip_available = "Dialog verfügbar"
	L.gossip_timer_trigger = "Wie schön, dass Ihr es geschafft habt, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "deDE")
if L then
	L.warmup_trigger = "Wir beenden das hier und jetzt, Mal'Ganis. Nur wir beide, sonst niemand."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "deDE")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	L.warmup_trigger = "eine große Finsternis"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "deDE")
if L then
	L.name = "Ewiger Verderber"
end

-- The Nexus

L = BigWigs:NewBossLocale("The Nexus Trash", "deDE")
if L then
	L.slayer = "Magiertöter"
	L.steward = "Bediensteter"
end

-- The Violet Hold

L = BigWigs:NewBossLocale("Xevozz", "deDE")
if L then
	L.sphere_name = "Sphäre des Astraleums"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "deDE")
if L then
	L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "deDE")
if L then
	L.portals_desc = "Informationen über Portale."
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "deDE")
if L then
	L.custom_on_autotalk_desc = "Wählt direkt die Dialogoption zum Starten von Begegnungen."
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "deDE")
if L then
	L.berserker = "Berserker der Ymirjar"
end
