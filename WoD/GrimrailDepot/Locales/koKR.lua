local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "koKR")
if not L then return end
if L then
	--L.dropped = "%s dropped!"
	L.add_trigger1 = "가라, 얘들아!"
	L.add_trigger2 = "모조리 없애라."

	L.waves[1] = "1x 그롬카르 폭파병, 1x 그롬카르 사수"
	L.waves[2] = "1x 그롬카르 사수, 1x 그롬카르 폭탄병"
	L.waves[3] = "강철 보병"
	L.waves[4] = "2x 그롬카르 폭파병"
	L.waves[5] = "강철 보병"
	L.waves[6] = "2x 그롬카르 사수"
	L.waves[7] = "강철 보병"
	L.waves[8] = "1x 그롬카르 폭파병, 1x 그롬카르 폭탄병"
	L.waves[9] = "3x 그롬카르 폭파병, 1x 그롬카르 사수"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "koKR")
if L then
	L.grimrail_technician = "파멸철로 기술자"
	L.grimrail_overseer = "파멸철로 감독관"
	L.gromkar_gunner = "그롬카르 사수"
	L.gromkar_cinderseer = "그롬카르 잿불현자"
	L.gromkar_boomer = "그롬카르 폭파병"
	L.gromkar_hulk = "그롬카르 거한"
	L.gromkar_far_seer = "그롬카르 선견자"
	L.gromkar_captain = "그롬카르 대장"
	L.grimrail_scout = "파멸철로 정찰병"
end
