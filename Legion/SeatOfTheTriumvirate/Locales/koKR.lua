local L = BigWigs:NewBossLocale("Viceroy Nezhar", "koKR")
if not L then return end
if L then
	L.tentacles = "암영 촉수"
	L.guards = "어둠수호병 공허지기"
	L.interrupted = "%s|1이;가; %s|1을;를; 시전 방해했습니다 (%.1f초 남음)!"
end

L = BigWigs:NewBossLocale("L'ura", "koKR")
if L then
	--L.warmup_text = "L'ura Active"
	--L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	--L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "koKR")
if L then
	L.custom_on_autotalk = "자동 대화"
	L.custom_on_autotalk_desc = "알레리아 윈드러너의 대화 선택지를 즉시 고릅니다."
	L.gossip_available = "대화 가능"
	L.alleria_gossip_trigger = "따라오세요!" -- Allerias yell after the first boss is defeated

	L.alleria = "알레리아 윈드러너"
	L.subjugator = "어둠수호병 정복자"
	L.voidbender = "어둠수호병 공허술사"
	--L.conjurer = "Shadowguard Conjurer"
	--L.weaver = "Grand Shadow-Weaver"
end
