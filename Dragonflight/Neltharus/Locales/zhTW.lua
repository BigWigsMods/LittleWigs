local L = BigWigs:NewBossLocale("Neltharus Trash", "zhTW")
if not L then return end
if L then
	L.custom_on_autotalk = "自動對話"
	L.custom_on_autotalk_desc = "自動對話獲得專業增益。"

	--L.burning_chain = "Burning Chain"
	L.qalashi_warden = "喀拉希守望者"
	L.qalashi_hunter = "喀拉希獵人"
	L.overseer_lahar = "監督者來哈爾"
	L.qalashi_trainee = "喀拉希新兵"
	L.qalashi_bonetender = "喀拉希癒骨者"
	L.qalashi_irontorch = "喀拉希鐵炬"
	L.qalashi_bonesplitter = "喀拉希碎骨者"
	L.qalashi_lavabearer = "喀拉希熔岩纏繞者"
	L.irontorch_commander = "鐵炬指揮官"
	L.qalashi_blacksmith = "喀拉希鐵匠"
	L.forgewrought_monstrosity = "爐鑄巨怪"
	L.qalashi_plunderer = "喀拉希盜掠者"
	L.qalashi_thaumaturge = "喀拉希奇術師"
	L.apex_blazewing = "至尊焰翼"
	L.qalashi_lavamancer = "喀拉希熔岩法師"
end

L = BigWigs:NewBossLocale("Chargath, Bane of Scales", "zhTW")
if L then
	L.slow = "鎖鏈"
end

L = BigWigs:NewBossLocale("Warlord Sargha", "zhTW")
if L then
	L.magical_implements_desc = "寶藏堆中藏著可以削減熔岩護盾的魔法器具。"
	L.magma_shield = "熔岩護盾：使用魔法器具"
end
