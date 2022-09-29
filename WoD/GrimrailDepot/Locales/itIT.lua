local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "itIT")
if not L then return end
if L then
	--L.dropped = "%s dropped!"
	L.add_trigger1 = "Facciamogliela vedere!"
	L.add_trigger2 = "Fate del vostro meglio!"

	L.waves[1] = "1x Bombarolo Grom'kar, 1x Artigliere Grom'kar"
	L.waves[2] = "1x Artigliere Grom'kar, 1x Granatiere Grom'kar"
	L.waves[3] = "Gregario di Ferro"
	L.waves[4] = "2x Bombarolo Grom'kar"
	L.waves[5] = "Gregario di Ferro"
	L.waves[6] = "2x Artigliere Grom'kar"
	L.waves[7] = "Gregario di Ferro"
	L.waves[8] = "1x Bombarolo Grom'kar, 1x Granatiere Grom'kar"
	L.waves[9] = "3x Bombarolo Grom'kar, 1x Artigliere Grom'kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "itIT")
if L then
	L.grimrail_technician = "Tecnico del Frecciacupa"
	L.grimrail_overseer = "Sovrintendente del Frecciacupa"
	L.gromkar_gunner = "Artigliere Grom'kar"
	L.gromkar_cinderseer = "Veggente delle Braci Grom'kar"
	L.gromkar_boomer = "Bombarolo Grom'kar"
	L.gromkar_hulk = "Energumeno Grom'kar"
	L.gromkar_far_seer = "Chiaroveggente Grom'kar"
	L.gromkar_captain = "Capitano Grom'kar"
	L.grimrail_scout = "Esploratore del Frecciacupa"
end
