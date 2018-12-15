local L = BigWigs:NewBossLocale("Vexallus", "deDE")
if not L then return end
if L then
	L.energy_discharged = "%s beschworen" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider ", "deDE")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	 L.warmup_trigger = "Bildet Euch nichts ein!"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "deDE")
if L then
	L.mage_guard = "Magierwache der Sonnenklingen"
	L.magister = "Magister der Sonnenklingen"
	L.keeper = "Bewahrer der Sonnenklingen"
end
