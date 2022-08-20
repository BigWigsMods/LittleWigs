local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "ptBR")
if not L then return end
if L then
	L.comma = ", "
	L.dropped = "%s soltou-se!"
	--L.add_trigger1 = "Let 'em have it, boys!"
	--L.add_trigger2 = "Give 'em all ya got."
end

L = BigWigs:NewBossLocale("Skylord Tovra", "ptBR")
if L then
	L.rakun = "Rakun"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "ptBR")
if L then
	L.grimrail_technician = "Técnico do Carrilcruel"
	L.grimrail_overseer = "Supervisor do Carrilcruel"
	L.gromkar_gunner = "Artilheira Grom'kar"
	L.gromkar_cinderseer = "Mirabrasa Grom'kar"
	L.gromkar_boomer = "Detonador Grom'kar"
	L.gromkar_far_seer = "Clarividente Grom'kar"
	L.gromkar_captain = "Capitã Grom'kar"
	L.grimrail_scout = "Batedora do Carrilcruel"
end
