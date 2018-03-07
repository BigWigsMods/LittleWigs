local L = BigWigs:NewBossLocale("Vexallus", "koKR")
if not L then return end
if L then
	L.adds = "순수한 에너지"
	L.adds_desc = "순수한 에너지가 소환되면 경보합니다."
	L.adds_message = "순수한 에너지 소환됨!"
	L.adds_trigger = "순수한 힘을 방출합니다!"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "koKR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"
end
