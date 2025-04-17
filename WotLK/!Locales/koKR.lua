-- Ahn'kahet: The Old Kingdom

local L = BigWigs:NewBossLocale("Ahn'kahet Trash", "koKR")
if not L then return end
if L then
	L.spellflinger = "안카하르 주문술사"
	L.eye = "탈다람의 눈"
	L.darkcaster = "황혼의 암흑술사"
end

-- Gundrak

L = BigWigs:NewBossLocale("Gal'darah", "koKR")
if L then
	--L.forms = "Forms"
	--L.forms_desc = "Warn before Gal'darah changes forms."

	--L.form_rhino = "Rhino Form"
	--L.form_troll = "Troll Form"
end

-- Halls of Lightning

L = BigWigs:NewBossLocale("Halls of Lightning Trash", "koKR")
if L then
	L.runeshaper = "폭풍벼림 룬세공사"
	L.sentinel = "폭풍벼림 파수병"
end

-- Halls of Stone

L = BigWigs:NewBossLocale("Tribunal of Ages", "koKR")
if L then
	--L.engage_trigger = "Now keep an eye out" -- Now keep an eye out! I'll have this licked in two shakes of a--
	--L.defeat_trigger = "The old magic fingers" --  Ha! The old magic fingers finally won through! Now let's get down to--
	--L.fail_trigger = "Not yet... not ye--"

	--L.timers = "Timers"
	--L.timers_desc = "Timers for various events that take place."

	--L.victory = "Victory"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "koKR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	L.gossip_available = "대화 가능"
	--L.gossip_timer_trigger = "Glad you could make it, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "koKR")
if L then
	--L.warmup_trigger = "We're going to finish this right now, Mal'Ganis. Just you... and me."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "koKR")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	--L.warmup_trigger = "on this day"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "koKR")
if L then
	L.name = "무한의 타락자"
end

-- The Nexus

L = BigWigs:NewBossLocale("The Nexus Trash", "koKR")
if L then
	L.slayer = "마법사 사냥개"
	L.steward = "청지기"
end

-- The Violet Hold

L = BigWigs:NewBossLocale("Xevozz", "koKR")
if L then
	--L.sphere_name = "Ethereal Sphere"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "koKR")
if L then
	--L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "koKR")
if L then
	--L.portals = "Portals"
	--L.portals_desc = "Information about portals."
	L.boss_message = "우두머리"
	L.portal_bar = "차원문"
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "koKR")
if L then
	--L.custom_on_autotalk_desc = "Instantly select gossip option to start encounters."
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "koKR")
if L then
	L.berserker = "이미야르 광전사"
end
