local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "itIT")
if not L then return end
if L then
	L.comma = ", "
	--L.dropped = "%s dropped!"
	--L.add_trigger1 = "Let 'em have it, boys!"
	--L.add_trigger2 = "Give 'em all ya got."
end

L = BigWigs:NewBossLocale("Skylord Tovra", "itIT")
if L then
	L.rakun = "Rakun"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "itIT")
if L then
	L.grimrail_technician = "Tecnico del Frecciacupa"
	L.grimrail_overseer = "Sovrintendente del Frecciacupa"
	L.gromkar_gunner = "Artigliere Grom'kar"
	L.gromkar_cinderseer = "Veggente delle Braci Grom'kar"
	L.gromkar_boomer = "Bombarolo Grom'kar"
	L.gromkar_far_seer = "Chiaroveggente Grom'kar"
	L.gromkar_captain = "Capitano Grom'kar"
	L.grimrail_scout = "Esploratore del Frecciacupa"
end
