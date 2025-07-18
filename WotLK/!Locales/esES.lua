-- Ahn'kahet: The Old Kingdom

local L = BigWigs:NewBossLocale("Ahn'kahet Trash", "esES")
if not L then return end
if L then
	L.spellflinger = "Lanzahechizos Ahn'kahar"
	L.eye = "Ojo de Taldaram"
	L.darkcaster = "Taumaturgo oscuro Crepuscular"
end

-- Gundrak

L = BigWigs:NewBossLocale("Gal'darah", "esES")
if L then
	L.forms = "Formas"
	L.forms_desc = "Alertar antes de que Gal'darah cambie de formas."

	L.form_rhino = "Forma de rino"
	L.form_troll = "Forma de troll"
end

-- Halls of Lightning

L = BigWigs:NewBossLocale("Halls of Lightning Trash", "esES")
if L then
	L.runeshaper = "Creador de runas Tronaforjado"
	L.sentinel = "Centinela Tronaforjado"
end

-- Halls of Stone

L = BigWigs:NewBossLocale("Tribunal of Ages", "esES")
if L then
	L.engage_trigger = "¡Atentos!" -- Now keep an eye out! I'll have this licked in two shakes of a--
	L.defeat_trigger = "los viejos dedos mágicos" --  Ha! The old magic fingers finally won through! Now let's get down to--
	L.fail_trigger = "¡Aún no!... Aún no..."

	L.timers = "Temporizadores"
	L.timers_desc = "Temporizadores para varios eventos que ocurren."

	L.victory = "Victoria"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "esES")
if L then
	L.custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de Chromie y Arthas."

	L.gossip_available = "Conversación disponible"
	L.gossip_timer_trigger = "Me alegro que lo consiguieras, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "esES")
if L then
	L.warmup_trigger = "Vamos a poner fin a esto ahora. Mal'Ganis. Solos tú y yo."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "esES")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	L.warmup_trigger = "hoy"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "esES")
if L then
	L.name = "Corruptor Infinito"
end

-- The Nexus

L = BigWigs:NewBossLocale("The Nexus Trash", "esES")
if L then
	L.slayer = "Asesino de magos"
	L.steward = "Administrador"
end

-- The Violet Hold

L = BigWigs:NewBossLocale("Xevozz", "esES")
if L then
	L.sphere_name = "Esfera etérea"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "esES")
if L then
	L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "esES")
if L then
	L.portals_desc = "Información sobre los portales."
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "esES")
if L then
	L.custom_on_autotalk_desc = "Selecciona al instante la opción de conversar para comenzar los encuentros."
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "esES")
if L then
	L.berserker = "Rabioso Ymirjar"
end
