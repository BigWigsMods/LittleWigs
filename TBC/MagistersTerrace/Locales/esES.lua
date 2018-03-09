local L = BigWigs:NewBossLocale("Vexallus", "esES") or BigWigs:NewBossLocale("Vexallus", "esMX")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "esES") or BigWigs:NewBossLocale("Kael'thas Sunstrider ", "esMX")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "esES") or BigWigs:NewBossLocale("Magisters' Terrace Trash", "esMX")
if L then
	L.mage_guard = "Guardia mago Filosol"
	L.magister = "Magister Filosol"
	L.keeper = "Vigilante Filosol"
end
