local L = BigWigs:NewBossLocale("Vexallus", "koKR")
if not L then return end
if L then
	L.energy_discharged = "%s 소환됨" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "koKR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "koKR")
if L then
	L.mage_guard = "태양칼날단 마법수호병"
	L.magister = "태양칼날단 마법학자"
	L.keeper = "태양칼날단 수호자"
end
