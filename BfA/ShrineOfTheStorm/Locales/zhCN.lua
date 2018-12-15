local L = BigWigs:NewBossLocale("Aqu'sirr", "zhCN")
if not L then return end
if L then
	L.warmup_trigger = "你们的到来，污染了这片圣地！"
end

L = BigWigs:NewBossLocale("Lord Stormsong", "zhCN")
if L then
	L.warmup_trigger_horde = "入侵者？！我要把你们的躯体扔入黑暗的深渊，让你们永世不得翻身！"
	L.warmup_trigger_alliance = "主人！马上停止这疯狂的行为！不要让库尔提拉斯的舰队堕入黑暗！"
end
