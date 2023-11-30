local L = BigWigs:NewBossLocale("Mephistroth", "zhTW")
if not L then return end
if L then
	L.custom_on_time_lost = "黑暗漸隱期間計時器"
	L.custom_on_time_lost_desc = "將黑暗漸隱持續時間的計時器顯示為|cffff0000紅色|r。"
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "zhTW")
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "zhTW")
if L then
	--L.dulzak = "Dul'zak"
	--L.wrathguard = "Wrathguard Invader"
	L.felguard = "惡魔守衛摧毀者"
	L.soulmender = "獄炎魔能使者"
	L.temptress = "獄炎妖女"
	L.botanist = "魔裔植物學家"
	L.orbcaster = "獄炎補魂者"
	--L.waglur = "Wa'glur"
	--L.scavenger = "Wyrmtongue Scavenger"
	L.gazerax = "賈澤拉克斯"
	--L.vilebark = "Vilebark Walker"

	--L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end
