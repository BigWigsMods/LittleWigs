local L = BigWigs:NewBossLocale("Seat Of The Triumvirate Trash", "koKR")
if not L then return end
if L then
	L.custom_on_autotalk = "자동 대화"
	L.custom_on_autotalk_desc = "알레리아 윈드러너의 대화 선택지를 즉시 고릅니다."
	L.gossip_available = "대화 가능"
	L.alleria_gossip_trigger = "따라오세요!" -- Allerias yell after the first boss is defeated

	L.alleria = "알레리아 윈드러너"
	L.subjugator = "어둠수호병 정복자"
	L.voidbender = "어둠수호병 공허술사"
end
