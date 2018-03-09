local L = BigWigs:NewBossLocale("Vexallus", "frFR")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "frFR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "frFR")
if L then
	L.mage_guard = "Garde mage lamesoleil"
	L.magister = "Magistère lamesoleil"
	L.keeper = "Gardien lamesoleil"
end
