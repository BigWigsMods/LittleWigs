local L = BigWigs:NewBossLocale("Odyn", "koKR")
if not L then return end
if L then
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
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "koKR")
if L then
        L.fourkings = "네명의 왕"
        L.olmyr = "깨달은 자 올미르"
        L.purifier = "발라리아르 정화자"
        L.thundercaller = "발라리아르 천둥술사"
        L.mystic = "발라리아르 비술사"
        L.aspirant = "발라리아르 지원자"
end
