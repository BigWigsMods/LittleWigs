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

L = BigWigs:NewBossLocale("Shrine of the Storm Trash", "zhCN")
if L then
	L.templar = "神殿骑士"
	L.spiritualist = "海贤灵魂师"
	L.galecaller_apprentice = "唤风者学徒"
	L.windspeaker = "风语者海蒂丝"
	L.ironhull_apprentice = "铁舟学徒"
	L.runecarver = "刻符者食客"
	L.guardian_elemental = "元素卫士"
	L.ritualist = "深海祭师"
	L.cultist = "深渊祭师"
	L.depthbringer = "溺水的深渊使者"
	L.living_current = "活体激流"
	L.enforcer = "海贤执行者"
end
