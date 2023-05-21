local L = BigWigs:NewBossLocale("Neltharus Trash", "zhTW")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
	--L.custom_on_autotalk_desc = "Instantly selects the gossip options to get profession buffs."

	--L.qalashi_warden = "Qalashi Warden"
	--L.qalashi_hunter = "Qalashi Hunter"
	--L.overseer_lahar = "Overseer Lahar"
	--L.qalashi_trainee = "Qalashi Trainee"
	--L.qalashi_bonetender = "Qalashi Bonetender"
	--L.qalashi_irontorch = "Qalashi Irontorch"
	--L.qalashi_bonesplitter = "Qalashi Bonesplitter"
	--L.qalashi_lavabearer = "Qalashi Lavabearer"
	--L.irontorch_commander = "Irontorch Commander"
	--L.qalashi_blacksmith = "Qalashi Blacksmith"
	--L.forgewrought_monstrosity = "Forgewrought Monstrosity"
	--L.qalashi_plunderer = "Qalashi Plunderer"
	--L.qalashi_thaumaturge = "Qalashi Thaumaturge"
	--L.apex_blazewing = "Apex Blazewing"
	--L.qalashi_lavamancer = "Qalahsi Lavamancer"
end

L = BigWigs:NewBossLocale("Chargath, Bane of Scales", "zhTW")
if L then
	--L.slow = "Slow"
	L.boss = "首領"
end

L = BigWigs:NewBossLocale("Warlord Sargha", "zhTW")
if L then
	L.magical_implements_desc = "寶藏堆中藏著可以削減熔岩護盾的魔法器具。"
	L.magma_shield = "熔岩護盾：找出魔法器具"
end
