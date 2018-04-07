local L = BigWigs:NewBossLocale("Cordana Felsong", "zhTW")
if not L then return end
if L then
	L.kick_combo = "連環踢"

	L.light_dropped = "%s丟掉了光。"
	L.light_picked = "%s撿起了光。"

	L.warmup_text = "寇達娜．魔歌啟動"
	L.warmup_trigger = "我已經拿到我要找的東西了。但為了你們，我最好還是留下來…斬草除根！"
	--L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
end

L = BigWigs:NewBossLocale("Glazer", "zhTW")
if L then
	--L.radiation_level = "%s: %d%%"
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "zhTW")
if L then
	--L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "zhTW")
if L then
	L.infester = "魔誓感染者"
	L.myrmidon = "魔誓部屬"
	L.fury = "魔能怒衛"
	--L.mother = "Foul Mother"
	L.illianna = "刃舞者伊利安娜"
	L.mendacius = "驚懼領主曼達希斯"
	L.grimhorn = "『奴役者』恐角"
end
