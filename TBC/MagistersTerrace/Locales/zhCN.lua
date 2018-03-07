local L = BigWigs:NewBossLocale("Vexallus", "zhCN")
if not L then return end
if L then
	L.adds = "纯净能量"
	L.adds_desc = "当放射出纯净能量时发出警报。"
	L.adds_message = "放射出纯净能量！"
	L.adds_trigger = "放射出纯净的能量！"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "zhCN")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"
end
