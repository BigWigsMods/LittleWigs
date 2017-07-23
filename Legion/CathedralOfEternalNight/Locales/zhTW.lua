local L = BigWigs:NewBossLocale("Mephistroth", "zhTW")
if not L then return end
if L then
	L.custom_on_time_lost = "黑暗漸隱期間計時器"
	L.custom_on_time_lost_desc = "將黑暗漸隱持續時間的計時器顯示為|cffff0000紅色|r。"
end

L = BigWigs:NewBossLocale("Domatrax", "zhTW")
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramars gossip option to start the Domatrax encounter."
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "zhTW")
if L then
	--L.dulzak = "Dul'zak"
	L.felguard = "惡魔守衛摧毀者"
	L.soulmender = "獄炎魔能使者"
	L.temptress = "獄炎妖女"
	L.botanist = "魔裔植物學家"
	L.orbcaster = "獄炎補魂者"
	--L.waglur = "Wa'glur"
	L.gazerax = "賈澤拉克斯"
end
