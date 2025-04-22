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
	L.forms = "변신"
	L.forms_desc = "갈다라가 변신하기 전에 경고합니다."

	L.form_rhino = "코뿔소 변신"
	L.form_troll = "트롤 변신"
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
	L.engage_trigger = "이제 잘 보시라고요" -- Now keep an eye out! I'll have this licked in two shakes of a--
	L.defeat_trigger = "늙은이의 노련한 손길" --  Ha! The old magic fingers finally won through! Now let's get down to--
	L.fail_trigger = "아직은 아니야... 아직은 아니--"

	L.timers = "타이머"
	L.timers_desc = "발생하는 다양한 이벤트에 대한 타이머."

	L.victory = "승리"
end

-- The Culling of Stratholme

L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "koKR")
if L then
	L.custom_on_autotalk_desc = "크로미와 아서스의 대화 옵션을 즉시 선택합니다."

	L.gossip_available = "대화 가능"
	L.gossip_timer_trigger = "드디어 나타나셨군, 우서."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "koKR")
if L then
	L.warmup_trigger = "이제 결판을 낼 때다, 말가니스! 너와, 내가 말이다..."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "koKR")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	L.warmup_trigger = "오늘"
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
	L.sphere_name = "마력의 구슬"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "koKR")
if L then
	L.short_name = "주라마트"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "koKR")
if L then
	L.portals_desc = "소환문에 대한 정보."
end

-- Trial of the Champion

L = BigWigs:NewBossLocale("Trial of the Champion Trash", "koKR")
if L then
	L.custom_on_autotalk_desc = "즉시 대화 옵션을 선택하여 전투를 시작합니다."
end

-- Utgarde Pinnacle

L = BigWigs:NewBossLocale("Utgarde Pinnacle Trash", "koKR")
if L then
	L.berserker = "이미야르 광전사"
end
