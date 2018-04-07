local L = BigWigs:NewBossLocale("Cordana Felsong", "zhCN")
if not L then return end
if L then
	L.kick_combo = "连环踢"

	L.light_dropped = "%s 丢掉了艾露恩之光。"
	L.light_picked = "%s 拾取了艾露恩之光。"

	L.warmup_text = "科达娜·邪歌激活"
	L.warmup_trigger = "我拿到想要的东西了。但我要留下来了结你们……永除后患！"
	L.warmup_trigger_2 = "你们掉进了我的陷阱。让我看看你们在黑暗中的本事吧。"
end

L = BigWigs:NewBossLocale("Glazer", "zhCN")
if L then
	L.radiation_level = "%s：%d%%"
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "zhCN")
if L then
	L.warmup_trigger = "我为人民而战，为那些被放逐和唾弃的人而战。"
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "zhCN")
if L then
	L.infester = "魔誓寄生者"
	L.myrmidon = "魔誓侍从"
	L.fury = "灌魔之怒"
	L.mother = "邪母"
	L.illianna = "刃舞者伊莲娜"
	L.mendacius = "恐惧魔王孟达休斯"
	L.grimhorn = "奴役者格里霍恩"
end
