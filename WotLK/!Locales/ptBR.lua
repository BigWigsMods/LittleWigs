-- Ahn'kahet: The Old Kingdom

local L = BigWigs:NewBossLocale("Ahn'kahet Trash", "ptBR")
if not L then return end
if L then
	L.spellflinger = "Sortílego Ahn'kahar"
	L.eye = "Olho de Taldaram"
	L.darkcaster = "Taumaturgo do Crepúsculo"
end

-- Gundrak

L = BigWigs:NewBossLocale("Gal'darah", "ptBR")
if L then
	L.forms = "Formas"
	L.forms_desc = "Avisar antes de Gal'darah mudar de forma."

	L.form_rhino = "Forma de Rinoceronte"
	L.form_troll = "Forma de Troll"
end

-- Halls of Lightning

L = BigWigs:NewBossLocale("Halls of Lightning Trash", "ptBR")
if L then
	L.runeshaper = "Traçarrunas Forjado em Tempestade"
	L.sentinel = "Sentinela Forjada em Tempestade"
end

-- Halls of Stone

L = BigWigs:NewBossLocale("Tribunal of Ages", "ptBR")
if L then
	--L.engage_trigger = "Now keep an eye out" -- Now keep an eye out! I'll have this licked in two shakes of a--
	--L.defeat_trigger = "The old magic fingers" --  Ha! The old magic fingers finally won through! Now let's get down to--
	--L.fail_trigger = "Not yet... not ye--"

	--L.timers = "Timers"
	--L.timers_desc = "Timers for various events that take place."

	--L.victory = "Victory"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "ptBR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	--L.gossip_available = "Gossip available"
	--L.gossip_timer_trigger = "Glad you could make it, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "ptBR")
if L then
	--L.warmup_trigger = "We're going to finish this right now, Mal'Ganis. Just you... and me."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "ptBR")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	--L.warmup_trigger = "on this day"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "ptBR")
if L then
	L.name = "Corruptor Infinito"
end

-- The Nexus

L = BigWigs:NewBossLocale("The Nexus Trash", "ptBR")
if L then
	L.slayer = "Matador de Magos"
	L.steward = "Administrador"
end

-- The Violet Hold

L = BigWigs:NewBossLocale("Xevozz", "ptBR")
if L then
	--L.sphere_name = "Ethereal Sphere"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "ptBR")
if L then
	--L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "ptBR")
if L then
	--L.portals_desc = "Information about portals."
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "ptBR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select gossip option to start encounters."
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "ptBR")
if L then
	L.berserker = "Berserker Ymarjar"
end
