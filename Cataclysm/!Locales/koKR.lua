-- End Time

local L = BigWigs:NewBossLocale("Echo of Baine", "koKR")
if not L then return end
if L then
	L.totemDrop = "토템 떨어짐"
	L.totemThrow = "%s 토템 던지기"
end

-- Grim Batol

L = BigWigs:NewBossLocale("Erudax", "koKR")
if L then
	L.summon = "얼굴 없는 타락자 소환"
	L.summon_desc = "에루닥스가 얼굴 없는 타락자를 소환하면 경보."
	L.summon_message = "얼굴 없는 타락자 소환됨"
	L.summon_trigger = "가 얼굴 없는 수호자를 소환합니다!"
end

L = BigWigs:NewBossLocale("Grim Batol Trash", "koKR")
if L then
	L.twilight_earthcaller = "황혼의 대지술사"
	L.twilight_brute = "황혼의 투사"
	L.twilight_destroyer = "황혼의 파괴자"
	L.twilight_overseer = "황혼의 감독관"
	L.twilight_beguiler = "황혼의 현혹술사"
	L.molten_giant = "용암거인"
	L.twilight_warlock = "황혼의 흑마법사"
	L.twilight_flamerender = "황혼의 화염분쇄자"
	L.twilight_lavabender = "황혼의 용암술사"
	L.faceless_corruptor = "얼굴 없는 타락자"
end

-- Hour of Twilight

L = BigWigs:NewBossLocale("The Hour of Twilight Trash", "koKR")
if L then
	L.custom_on_autotalk_desc = "스랄의 대화 옵션을 즉시 선택합니다."
end

-- Lost City of the Tol'vir

L = BigWigs:NewBossLocale("Siamat", "koKR")
if L then
	L.servant = "하수인 소환"
	L.servant_desc = "시아마트의 하수인이 소환되면 경보합니다."
end

-- Shadowfang Keep

L = BigWigs:NewBossLocale("Lord Walden", "koKR")
if L then
	-- %s will be either "Toxic Coagulant" or "Toxic Catalyst"
	L.coagulant = "%s: 이동하여 해제"
	L.catalyst = "%s: 치명타 버프"
	L.toxin_healer_message = "%s: 전원 도트"
end

-- The Stonecore

L = BigWigs:NewBossLocale("Corborus", "koKR")
if L then
	L.burrow = "잠복/출현"
	L.burrow_desc = "코보루스가 잠복하거나 지상으로 나타나면 경보합니다."
	L.burrow_message = "코보루스 잠복!"
	L.burrow_warning = "5초 후 잠복!"
	L.emerge_message = "코보루스 출현!"
	L.emerge_warning = "5초 후 출현!"
end

-- Throne of the Tides

L = BigWigs:NewBossLocale("Throne of the Tides Trash", "koKR")
if L then
	L.nazjar_oracle = "나즈자르 예언자"
	L.vicious_snap_dragon = "흉포한 치악룡"
	L.nazjar_sentinel = "나즈자르 파수꾼"
	L.nazjar_ravager = "나즈자르 괴멸자"
	L.nazjar_tempest_witch = "나즈자르 폭풍우 마녀"
	L.faceless_seer = "얼굴 없는 선견자"
	L.faceless_watcher = "얼굴 없는 감시자"
	L.tainted_sentry = "타락한 파수병"

	L.ozumat_warmup_trigger = "야수가 돌아왔다! 놈이 물을 오염시키게 두면 안 된다!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "koKR")
if L then
	L.high_tide_trigger1 = "무기를 들어라, 부하들아! 얼어붙은 나락에서 일어나라!"
	L.high_tide_trigger2 = "침입자를 처단하라! 놈들을 끝없는 어둠 너머로 보내버려라!"
end

-- The Vortex Pinnacle

L = BigWigs:NewBossLocale("The Vortex Pinnacle Trash", "koKR")
if L then
	L.armored_mistral = "무장한 광풍"
	L.gust_soldier = "돌풍 병사"
	L.wild_vortex = "거친 소용돌이"
	L.lurking_tempest = "숨어있는 폭풍우"
	L.cloud_prince = "구름 왕자"
	L.turbulent_squall = "휘몰아치는 돌풍"
	L.empyrean_assassin = "창공의 암살자"
	L.young_storm_dragon = "어린 폭풍 용"
	L.executor_of_the_caliph = "통치자의 집행관"
	L.temple_adept = "사원 숙련사제"
	L.servant_of_asaad = "아사드의 하수인"
	L.minister_of_air = "바람의 대신"
end

-- Well of Eternity

L = BigWigs:NewBossLocale("Well Of Eternity Trash", "koKR")
if L then
	L.custom_on_autotalk_desc = "즉시 일리단의 대화 옵션을 선택합니다."
end

-- Zul'Aman

L = BigWigs:NewBossLocale("Daakara", "koKR")
if L then
	L[42594] = "곰 변신" -- short form for "Essence of the Bear"
	L[42607] = "스라소니 변신"
	L[42606] = "독수리 변신"
	L[42608] = "용매 변신"
end

L = BigWigs:NewBossLocale("Halazzi", "koKR")
if L then
	L.spirit_message = "영혼 단계"
	L.normal_message = "일반 단계"
end

L = BigWigs:NewBossLocale("Nalorakk", "koKR")
if L then
	L.troll_message = "트롤 모습"
	L.troll_trigger = "날로라크 나가신다!"
end

-- Zul'Gurub

L = BigWigs:NewBossLocale("Jin'do the Godbreaker", "koKR")
if L then
	L.barrier_down_message = "방벽 깨짐, %d개 남음" -- short name for "Brittle Barrier" (97417)
end
