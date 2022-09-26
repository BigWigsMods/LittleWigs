local L = BigWigs:NewBossLocale("Vexallus", "zhCN")
if not L then return end
if L then
	L.energy_discharged = "放射出%s" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "zhCN")
if L then
	-- 别拿那种眼神看着我！我知道你们在想些什么，但风暴要塞的失败早就过去了。你们真以为我会把命运交给一个又瞎又粗野又下贱的暗夜精灵杂种？
	L.warmup_trigger = "别拿那种眼神看着我！"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "zhCN")
if L then
	L.mage_guard = "炎刃魔法卫兵"
	L.magister = "炎刃魔导师"
	L.keeper = "炎刃守护者"
end
