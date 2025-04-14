-- Auchindoun

local L = BigWigs:NewBossLocale("Auchindoun Trash", "koKR")
if not L then return end
if L then
	L.abyssal = "지옥살이 심연불정령"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "koKR")
if L then
	L.bloodmaul_enforcer = "피망치 집행자"
	L.bloodmaul_overseer = "피망치 감독관"
	L.bloodmaul_warder = "피망치 교도관"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "koKR")
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

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "koKR")
if L then
	--L.sphere_fail_message = "Shield was broken - They're all healing :("
end

L = BigWigs:NewBossLocale("Oshir", "koKR")
if L then
	--L.freed = "Freed after %.1f sec!"
	L.wolves = "늑대"
	L.rylak = "라일라크"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "koKR")
if L then
	L.gromkar_battlemaster = "그롬카르 전투대장"
	L.gromkar_flameslinger = "그롬카르 화염 궁수"
	L.gromkar_technician = "그롬카르 기술자"
	L.siegemaster_olugar = "공성전문가 오루가"
	L.pitwarden_gwarnok = "구덩이감시자 그왈노크"
	L.ogron_laborer = "오그론 일꾼"
	L.gromkar_chainmaster = "그롬카르 사슬대장"
	L.thunderlord_wrangler = "천둥군주 사냥꾼"
	L.rampaging_clefthoof = "광란의 갈래발굽"
	L.ironwing_flamespitter = "강철날개 화염라일라크"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Sadana Bloodfury", "koKR")
if L then
	--L.custom_on_markadd = "Mark the Dark Communion Add"
	--L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
end

L = BigWigs:NewBossLocale("Bonemaw", "koKR")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "땅속 숨기"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "koKR")
if L then
	L.shadowmoon_bonemender = "어둠달 뼛조각치유사"
	L.reanimated_ritual_bones = "되살린 의식 해골"
	L.void_spawn = "공허의 피조물"
	L.shadowmoon_loyalist = "어둠달 충성주의자"
	L.defiled_spirit = "더럽혀진 영혼"
	L.shadowmoon_dominator = "어둠달 통솔자"
	L.shadowmoon_exhumer = "어둠달 도굴꾼"
	L.exhumed_spirit = "도굴된 영혼"
	L.monstrous_corpse_spider = "기괴한 시체 거미"
	L.carrion_worm = "청소부 벌레"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "koKR")
if L then
	--L.custom_on_markadd = "Mark the Solar Zealot"
	--L.custom_on_markadd_desc = "Mark the Solar Zealot with {rt8}, requires promoted or leader."

	L.construct = "하늘탑 보호 피조물" -- NPC ID 76292
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "koKR")
if L then
	--L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "koKR")
if L then
	L.dreadpetal = "공포꽃잎"
	L.everbloom_naturalist = "상록숲 식물학자"
	L.everbloom_cultivator = "상록숲 경작자"
	L.rockspine_stinger = "바위등뼈 쐐기벌레"
	L.everbloom_mender = "상록숲 치유사"
	L.gnarlroot = "옹이뿌리"
	L.melded_berserker = "식물에 잠식당한 광전사"
	L.twisted_abomination = "뒤틀린 흉물"
	L.infested_icecaller = "감염된 얼음소환사"
	L.putrid_pyromancer = "타락의 화염술사"
	L.addled_arcanomancer = "정신이상의 비전역술사"

	--L.gate_open_desc = "Show a bar indicating when Undermage Kesalon will open the gate to Yalnu."
	--L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "koKR")
if L then
	L.counduitLeft = "수송관 %d개 남음"
end
