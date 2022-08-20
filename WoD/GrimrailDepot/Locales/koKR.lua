local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "koKR")
if not L then return end
if L then
	L.comma = ", "
	--L.dropped = "%s dropped!"
	--L.add_trigger1 = "Let 'em have it, boys!"
	--L.add_trigger2 = "Give 'em all ya got."
end

L = BigWigs:NewBossLocale("Skylord Tovra", "koKR")
if L then
	L.rakun = "라쿤"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "koKR")
if L then
	L.grimrail_technician = "파멸철로 기술자"
	L.grimrail_overseer = "파멸철로 감독관"
	L.gromkar_gunner = "그롬카르 사수"
	L.gromkar_cinderseer = "그롬카르 잿불현자"
	L.gromkar_boomer = "그롬카르 폭파병"
	L.gromkar_far_seer = "그롬카르 선견자"
	L.gromkar_captain = "그롬카르 대장"
	L.grimrail_scout = "파멸철로 정찰병"
end
