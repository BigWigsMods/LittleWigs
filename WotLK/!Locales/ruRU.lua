-- Ahn'kahet: The Old Kingdom

local L = BigWigs:NewBossLocale("Ahn'kahet Trash", "ruRU")
if not L then return end
if L then
	L.spellflinger = "Ан'кахарский метатель заклинаний"
	L.eye = "Глаз Талдарама"
	L.darkcaster = "Сумеречный черный маг"
end

-- Gundrak

L = BigWigs:NewBossLocale("Gal'darah", "ruRU")
if L then
	--L.forms = "Forms"
	--L.forms_desc = "Warn before Gal'darah changes forms."

	--L.form_rhino = "Rhino Form"
	--L.form_troll = "Troll Form"
end

-- Halls of Lightning

L = BigWigs:NewBossLocale("Halls of Lightning Trash", "ruRU")
if L then
	L.runeshaper = "Рунодел клана Закаленных Бурей"
	L.sentinel = "Часовой клана Закаленных Бурей"
end

-- Halls of Stone

L = BigWigs:NewBossLocale("Tribunal of Ages", "ruRU")
if L then
	L.engage_trigger = "Теперь будьте внимательны" -- Теперь будьте внимательны! Не успеете и глазом моргнуть, как...
	L.defeat_trigger = "Мои старые добрые пальцы" --  Ха! Мои старые добрые пальцы наконец-то одолели эту преграду! Теперь, перейдем к...
	L.fail_trigger = "Еще не время... еще не..."

	--L.timers = "Timers"
	--L.timers_desc = "Timers for various events that take place."

	L.victory = "Победа"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "ruRU")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	--L.gossip_available = "Gossip available"
	L.gossip_timer_trigger = "Я рад, что ты пришел, Утер!"
end

L = BigWigs:NewBossLocale("Mal'Ganis", "ruRU")
if L then
	L.warmup_trigger = "Мы покончим с этим сейчас же, Мал'Ганис. Один на один."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "ruRU")
if L then
	-- Принц Артас Менетил, в этот самый день могущественное зло поглотило твою душу. Смерть, которую ты должен был принести другим, сегодня придет за тобой.
	L.warmup_trigger = "в этот самый день"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "ruRU")
if L then
	L.name = "Осквернитель из рода Бесконечности"
end

-- The Nexus

L = BigWigs:NewBossLocale("The Nexus Trash", "ruRU")
if L then
	L.slayer = "Убийца магов"
	L.steward = "Распорядитель"
end

-- The Violet Hold

L = BigWigs:NewBossLocale("Xevozz", "ruRU")
if L then
	L.sphere_name = "Бесплотная сфера"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "ruRU")
if L then
	--L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "ruRU")
if L then
	--L.portals_desc = "Information about portals."
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "ruRU")
if L then
	--L.custom_on_autotalk_desc = "Instantly select gossip option to start encounters."
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "ruRU")
if L then
	L.berserker = "Имирьярский берсерк"
end
