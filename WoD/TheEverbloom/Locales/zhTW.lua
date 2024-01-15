local L = BigWigs:NewBossLocale("Witherbark", "zhTW")
if not L then return end
if L then
	L.energyStatus = "元水之珠到達枯木: %d%% 能量"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "zhTW")
if L then
	L.dreadpetal = "恐瓣花"
	L.everbloom_naturalist = "永茂林自然療者"
	L.everbloom_cultivator = "永茂林護林者"
	--L.rockspine_stinger = "Rockspine Stinger"
	L.everbloom_mender = "永茂林治癒者"
	L.gnarlroot = "瘤根"
	L.melded_berserker = "混形狂戰士"
	--L.twisted_abomination = "Twisted Abomination"
	L.infested_icecaller = "被感染的喚冰師"
	L.putrid_pyromancer = "腐爛的火占師"
	L.addled_arcanomancer = "混亂的秘卜師"

	L.gate_open_desc = "顯示一個計時條指示黑暗法師克薩隆將開啟往亞爾努的傳送門。"
	L.yalnu_warmup_trigger = "我們一定要阻止這隻怪物，不能讓他逃脫！"
end
