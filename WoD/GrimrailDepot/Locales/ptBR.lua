local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "ptBR")
if not L then return end
if L then
	L.dropped = "%s soltou-se!"
	L.add_trigger1 = "Chumbo neles, rapaziada!"
	L.add_trigger2 = "Quero ver força total."

	L.waves[1] = "1x Detonador Grom'kar, 1x Artilheiro Grom'kar"
	L.waves[2] = "1x Artilheiro Grom'kar, 1x Granadeiro Grom'kar"
	L.waves[3] = "Infantaria de Ferro"
	L.waves[4] = "2x Detonador Grom'kar"
	L.waves[5] = "Infantaria de Ferro"
	L.waves[6] = "2x Artilheiro Grom'kar"
	L.waves[7] = "Infantaria de Ferro"
	L.waves[8] = "1x Detonador Grom'kar, 1x Granadeiro Grom'kar"
	L.waves[9] = "3x Detonador Grom'kar, 1x Artilheiro Grom'kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "ptBR")
if L then
	L.grimrail_technician = "Técnico do Carrilcruel"
	L.grimrail_overseer = "Supervisor do Carrilcruel"
	L.gromkar_gunner = "Artilheira Grom'kar"
	L.gromkar_cinderseer = "Mirabrasa Grom'kar"
	L.gromkar_boomer = "Detonador Grom'kar"
	L.gromkar_hulk = "Grandalhão de Grom'kar"
	L.gromkar_far_seer = "Clarividente Grom'kar"
	L.gromkar_captain = "Capitã Grom'kar"
	L.grimrail_scout = "Batedora do Carrilcruel"
end
