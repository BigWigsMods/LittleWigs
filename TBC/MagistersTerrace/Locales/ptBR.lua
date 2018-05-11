local L = BigWigs:NewBossLocale("Vexallus", "ptBR")
if not L then return end
if L then
	L.energy_discharged = "%s descarregado" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "ptBR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	L.warmup_trigger = "Não fiquem aí, com essa cara de arrogância!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "ptBR")
if L then
	L.mage_guard = "Guarda Mago Gumélion"
	L.magister = "Magíster Gumélion"
	L.keeper = "Guardião Gumélion"
end
