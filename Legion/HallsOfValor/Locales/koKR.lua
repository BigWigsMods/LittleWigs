local L = BigWigs:NewBossLocale("Odyn", "koKR")
if not L then return end
if L then
	L.custom_on_autotalk = "자동 대화"
	L.custom_on_autotalk_desc = "전투를 시작하는 대화 선택지를 즉시 선택합니다."

	L.gossip_available = "대화 가능"
	--L.gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand."

	L[197963] = "|cFF800080우측 상단|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500우측 하단|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00좌측 하단|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FF좌측 상단|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000상단|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "koKR")
if L then
	L.warmup_text = "신왕 스코발드 활성화"
	L.warmup_trigger = "스코발드, 아이기스는 이미 주인을 찾았다. 자격이 충분한 용사들이지. 네 권리를 주장하기엔 너무 늦었어."
	--L.warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "koKR")
if L then
	L.custom_on_autotalk = "자동 대화"
	L.custom_on_autotalk_desc = "던전 내의 여러 대화 선택지를 즉시 선택합니다."

	L.fourkings = "네명의 왕"
	L.olmyr = "깨달은 자 올미르"
	L.purifier = "발라리아르 정화자"
	L.thundercaller = "발라리아르 천둥술사"
	L.mystic = "발라리아르 비술사"
	L.aspirant = "발라리아르 지원자"
	L.drake = "폭풍 비룡"
	L.marksman = "발라리아르 명사수"
	L.trapper = "발라리아르 덫사냥꾼"
	L.sentinel = "폭풍벼림 파수병"
end
