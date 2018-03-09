local L = BigWigs:NewBossLocale("Vexallus", "zhCN")
if not L then return end
if L then
	L.energy_discharged = "放射出%s" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "zhCN")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "zhCN")
if L then
	L.mage_guard = "炎刃魔法卫兵"
	L.magister = "炎刃魔导师"
	L.keeper = "炎刃守护者"
end
