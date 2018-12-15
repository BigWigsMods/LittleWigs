local L = BigWigs:NewBossLocale("Aqu'sirr", "zhCN")
if not L then return end
if L then
	L.warmup_trigger = "污染了这片圣地"
end

L = BigWigs:NewBossLocale("Lord Stormsong", "zhCN")
if L then
	L.warmup_trigger_horde = "我要把你们的躯体扔入黑暗的深渊"
	-- L.warmup_trigger_alliance = "Master! Stop this madness at once! The Kul Tiran fleet must not fall to darkness!"
end
