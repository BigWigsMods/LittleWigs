-- Ahn'kahet: The Old Kingdom

local L = BigWigs:NewBossLocale("Ahn'kahet Trash", "frFR")
if not L then return end
if L then
	L.spellflinger = "Lanceur de sorts ahn'kahar"
	L.eye = "Oeil de Taldaram"
	L.darkcaster = "Invocateur noir du Crépuscule"
end

-- Gundrak

L = BigWigs:NewBossLocale("Gal'darah", "frFR")
if L then
	L.forms = "Formes"
	L.forms_desc = "Avertis avant que Gal'darah change de forme."

	L.form_rhino = "Forme de Rhino"
	L.form_troll = "Forme de troll"
end

-- Halls of Lightning

L = BigWigs:NewBossLocale("Halls of Lightning Trash", "frFR")
if L then
	L.runeshaper = "Formerune forge-foudre"
	L.sentinel = "Sentinelle forge-foudre"
end

-- Halls of Stone

L = BigWigs:NewBossLocale("Tribunal of Ages", "frFR")
if L then
	--L.engage_trigger = "Now keep an eye out" -- Now keep an eye out! I'll have this licked in two shakes of a--
	--L.defeat_trigger = "The old magic fingers" --  Ha! The old magic fingers finally won through! Now let's get down to--
	--L.fail_trigger = "Not yet... not ye--"

	L.timers = "Compte à rebours"
	L.timers_desc = "Compte à rebours pour divers éléments ayant lieu."

	L.victory = "Victoire"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "frFR")
if L then
	L.custom_on_autotalk_desc = "Selectionne automatiquement les options de dialogue de Chromie et Arthas."

	L.gossip_available = "Dialogue disponible"
	--L.gossip_timer_trigger = "Glad you could make it, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "frFR")
if L then
	--L.warmup_trigger = "We're going to finish this right now, Mal'Ganis. Just you... and me."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "frFR")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	--L.warmup_trigger = "on this day"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "frFR")
if L then
	L.name = "Corrupteur infini"
end

-- The Nexus

L = BigWigs:NewBossLocale("The Nexus Trash", "frFR")
if L then
	L.slayer = "Pourfendeur de mages"
	L.steward = "Régisseur"
end

-- The Violet Hold

L = BigWigs:NewBossLocale("Xevozz", "frFR")
if L then
	L.sphere_name = "Sphère éthérée"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "frFR")
if L then
	L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "frFR")
if L then
	L.portals_desc = "Information sur les portails."
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "frFR")
if L then
	L.custom_on_autotalk_desc = "Selectionne automatiquement l'option de dialogue pour commencer les rencontres."
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "frFR")
if L then
	L.berserker = "Berserker ymirjar"
end
