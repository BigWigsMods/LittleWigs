local L = BigWigs:NewBossLocale("Augh", "zhCN")
if not L then return end
if L then
	L.bossName = "奥弗"
end

L = BigWigs:NewBossLocale("Siamat", "zhCN")
if L then
	L.engage_trigger = "呼啸的南风，助你的主人一臂之力吧！"
	L.servant = "召唤仆从"
	L.servant_desc = "当召唤希亚玛特的仆从时发出警报。"
end
