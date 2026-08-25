-- Artifact Scenarios

BigWigsAPI.SetBossModuleLocale("Tugar Bloodtotem", {
	tugar = "투가르 블러드토템",
	jormog = "거수 요르모그",

	remaining = "비늘 남음",

	submerge = "숨기",
	submerge_desc = "땅 속으로 숨습니다, 담즙뱉기 지네 알을 소환하고 종유석을 떨어뜨립니다.",

	charge_desc = "요르모그가 숨으면 주기적으로 당신에게 돌진합니다.",

	rupture = "{243382} (X)",
	rupture_desc = "당신 밑에 X자 모양의 지옥 파열이 나타납니다. 5초 후 지면을 파열시켜 종유석이 솟아오르며 플레이어를 밀쳐냅니다.",

	totem_warning = "토템이 당신을 공격합니다!",
})

BigWigsAPI.SetBossModuleLocale("Raest", {
	name = "라이스트 메이지스피어",

	handFromBeyond = "저 너머의 손",

	rune_desc = "지면에 소환의 룬이 생성됩니다. 사라질 때까지 악몽의 피조물이 생성됩니다.",

	warmup_text = "카람 메이지스피어 활성화",
	warmup_trigger = "날 따라오다니 어리석군. 뒤틀린 황천이 내게 힘을 준다. 난 이미 너희의 상상 이상으로 강해졌다!",
	warmup_trigger2 = "침입자를 처단하라, 형제여!",
})

BigWigsAPI.SetBossModuleLocale("Kruul", {
	name = "대군주 크룰",
	inquisitor = "심문관 바리스",
	velen = "예언자 벨렌",

	warmup_trigger = "오만하고 멍청한 것들! 나에게는 수천 개의 세계에서 얻은 영혼의 힘이 흘러넘친다!",
	win_trigger = "그래, 좋아. 더 이상 우릴 가로막지 못하게 해 주지.",

	nether_aberration_desc = "방 안에 황천 흉물을 생성하는 차원문을 소환합니다.",

	smoldering_infernal = "이글거리는 지옥불정령",
	smoldering_infernal_desc = "이글거리는 지옥불정령을 소환합니다.",
})

BigWigsAPI.SetBossModuleLocale("Lord Erdris Thorn", {
	erdris = "군주 에르드리스 쏜",

	warmup_trigger = "적절한 시간에 왔습니다.",
	warmup_trigger2 = "무슨... 일이 일어나는 거지?", --Stage 5 Warm up

	mage = "타락한 되살아난 마법사",
	soldier = "타락한 되살아난 병사",
	arbalest = "타락한 되살아난 석궁병",
})

BigWigsAPI.SetBossModuleLocale("Archmage Xylem", {
	name = "대마법사 실렘",
	corruptingShadows = "타락의 그림자",

	warmup_trigger1 = "너무 늦었다! 집중의 눈동자를 내가 통재하는 한", -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	warmup_trigger2 = "마법을 빼앗긴 너의 세계를 나의 악마 주인님께서 손쉽게 파괴하실 거다", -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
})

BigWigsAPI.SetBossModuleLocale("Agatha", {
	name = "아가타",
	imp_servant = "임프 하수인",
	fuming_imp = "독기 뿜는 임프",
	levia = "레비아", -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	warmup_trigger1 = "너무 늦었다! 레비아의 힘은 내 것이다! 내 하수인들이 그 힘을 이용하여 키린 토에 침투하고, 내부로부터 붕괴시킬 것이다!", -- 35
	warmup_trigger2 = "지금도 내 세이야드는 의지가 약한 마법사들을 유혹하고 있다. 네 동맹은 제 발로 군단에 굴복할 것이다!", -- 16
	warmup_trigger3 = "하지만 먼저 내 장난감을 건드린 네 녀석을 벌해야겠지.", -- 3

	stacks = "중첩",
})

BigWigsAPI.SetBossModuleLocale("Sigryn", {
	sigryn = "시그린",
	jarl = "야를 벨브란드",
	faljar = "룬의 현자 팔리아르",

	warmup_trigger = "뭐지? 이방인이 날 막으러 오다니?",
})

-- Assault on Violet Hold

BigWigsAPI.SetBossModuleLocale("Assault on Violet Hold Trash", {
	custom_on_autotalk_desc = "보랏빛 요새 침공을 시작하는 부관 신클래리의 대화 선택지를 즉시 선택합니다.",
	keeper = "차원문 수호병",
	guardian = "차원문 수호자",
	infernal = "타오르는 지옥불정령",
})

BigWigsAPI.SetBossModuleLocale("Thalena", {
	essence = "정수",
})

-- Black Rook Hold

BigWigsAPI.SetBossModuleLocale("Black Rook Hold Trash", {
	ghostly_retainer = "유령 수행원",
	ghostly_protector = "유령 수호자",
	ghostly_councilor = "유령 의원",
	lord_etheldrin_ravencrest = "군주 에델드린 레이븐크레스트",
	lady_velandras_ravencrest = "여군주 벨란드라스 레이븐크레스트",
	rook_spiderling = "탑 새끼거미",
	soultorn_champion = "영혼 찢긴 용사",
	risen_scout = "되살아난 정찰병",
	risen_archer = "되살아난 궁수",
	risen_arcanist = "되살아난 비전술사",
	wyrmtongue_scavenger = "고룡혓바닥 청소부",
	bloodscent_felhound = "피비린내 지옥사냥개",
	felspite_dominator = "지옥원한 통솔자",
	risen_swordsman = "되살아난 검사",
	risen_lancer = "되살아난 창기병",

	door_open_desc = "숨겨진 통로의 문이 열렸을 때를 나타내는 막대를 표시합니다.",
})

BigWigsAPI.SetBossModuleLocale("Kurtalos Ravencrest", {
	phase_2_trigger = "됐다! 슬슬 싫증이 나는군.",
})

-- Cathedral of Eternal Night

BigWigsAPI.SetBossModuleLocale("Mephistroth", {
	custom_on_time_lost = "그림자 소실 단계 동안 잃어버린 시간",
	custom_on_time_lost_desc = "그림자 소실 단계 동안 잃어버린 시간을 바에 |cffff0000붉은색|r으로 표시합니다.",
	time_lost = "%s |cffff0000(+%ds)|r",
})

BigWigsAPI.SetBossModuleLocale("Domatrax", {
	custom_on_autotalk_desc = "도마트락스 전투를 시작하는 아그라마르의 아이기스 대화 선택지를 즉시 선택합니다.",

	missing_aegis = "아이기스 효과 없음!", -- Aegis is a short name for Aegis of Aggramar
	aegis_healing = "아그라마르의 아이기스: 힐량 감소",
	aegis_damage = "아그라마르의 아이기스: 데미지 감소",
})

BigWigsAPI.SetBossModuleLocale("Cathedral of Eternal Night Trash", {
	dulzak = "둘자크",
	wrathguard = "지옥수호병 침략자",
	felguard = "지옥수호병 파괴자",
	soulmender = "지옥불길 영혼치유사",
	temptress = "지옥불길 요녀",
	botanist = "지옥살이 식물학자",
	orbcaster = "지옥길잡이 보주술사",
	waglur = "와글루르",
	scavenger = "고룡혓바닥 청소부",
	gazerax = "가제락스",
	vilebark = "썩은나무껍질 방랑자",

	throw_tome = "고서 던지기", -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
})

-- Court of Stars

BigWigsAPI.SetBossModuleLocale("Court of Stars Trash", {
	duskwatch_sentry = "황혼감시대 보초병",
	duskwatch_reinforcement = "황혼감시대 지원병",
	Guard = "황혼감시대 경비병",
	Construct = "수호의 피조물",
	Enforcer = "지옥결속 집행자",
	Hound = "군단 지옥사냥개",
	Mistress = "그림자 여주인",
	Gerenth = "흉측한 게렌스",
	Jazshariu = "자즈샤리우",
	Imacutya = "이마쿠티아",
	Baalgar = "경계자 바알가르",
	Inquisitor = "감시하는 심문관",
	BlazingImp = "이글거리는 임프",
	Energy = "속박된 마력",
	Manifestation = "비전 현신",
	Wyrm = "마나 지룡",
	Arcanist = "황혼감시대 비전술사",
	InfernalImp = "지옥불 임프",
	Malrodi = "비전술사 말로디",
	Velimar = "벨리마르",
	ArcaneKeys = "비전 열쇠",
	clues = "단서",

	InfernalTome = "지옥불 고서",
	MagicalLantern = "마법 초롱",
	NightshadeRefreshments = "어둠그늘 간식",
	StarlightRoseBrew = "별빛 장미 차",
	UmbralBloom = "그림자 꽃",
	WaterloggedScroll = "물에 젖은 두루마리",
	BazaarGoods = "장터 물품",
	LifesizedNightborneStatue = "실물 크기의 나이트본 석상",
	DiscardedJunk = "버려진 쓰레기",
	WoundedNightborneCivilian = "부상당한 나이트본 시민",

	announce_buff_items = "강화 효과 아이템 알리기",
	announce_buff_items_desc = "던전 내의 모든 강화 효과 아이템과 아이템을 누가 사용할 수 있는 지 알립니다.",

	available = "%s|cffffffff%s|r 사용 가능", -- Context: item is available to use
	usableBy = "사용 가능: %s", -- Context: item is usable by someone

	custom_on_use_buff_items = "강화 효과 아이템 즉시 사용",
	custom_on_use_buff_items_desc = "이 옵션을 사용하면 던전 내 곳곳에 있는 강화 효과 아이템을 즉시 사용합니다. 두번째 우두머리 전의 수호병을 유인하는 아이템은 사용하지 않습니다.",

	spy_helper = "첩자 이벤트 도우미",
	spy_helper_desc = "당신의 파티가 수집한 첩자에 대한 모든 단서를 표시하는 정보 상자를 표시합니다. 단서들은 파티원들에게 대화로도 전송됩니다.",

	clueFound = "단서 발견 (%d/5): |cffffffff%s|r",
	spyFound = "%s|1이;가; 첩자 발견!",
	spyFoundChat = "첩자 찾았어요!",
	spyFoundPattern = "자, 너무 그렇게 다그치지 마십시오", -- 자, 너무 그렇게 다그치지 마십시오, [player] 님. 어디 조용한 곳으로 가서 다시 얘기해 보는 게 어떻겠습니까? 따라오시죠...

	hints = {
		[1] = "망토",
		[2] = "망토 없음",
		[3] = "주머니",
		[4] = "물약",
		[5] = "긴 소매",
		[6] = "짧은 소매",
		[7] = "장갑",
		[8] = "장갑 없음",
		[9] = "남자",
		[10] = "여자",
		[11] = "밝은색 조끼",
		[12] = "어두운색 조끼",
		[13] = "물약 없음",
		[14] = "책",
	},
})

BigWigsAPI.SetBossModuleLocale("Advisor Melandrus", {
	warmup_trigger = "또 실패했구나 멜란드루스. 이번이 네 잘못을 바로잡을 기회다. 이 외부인들을 제거해라. 난 밤의 요새로 돌아가겠다.",
})

-- Darkheart Thicket

BigWigsAPI.SetBossModuleLocale("Darkheart Thicket Trash", {
	archdruid_glaidalis_warmup_trigger = "타락한 자들아... 너희 피에서 악몽의 냄새가 난다. 이 숲에서 꺼지지 않으면, 자연의 분노를 맛보게 되리라!",

	mindshattered_screecher = "정신파괴 비명날개",
	dreadsoul_ruiner = "공포영혼 파멸자",
	dreadsoul_poisoner = "공포영혼 독살자",
	crazed_razorbeak = "광기 어린 뾰족부리",
	festerhide_grizzly = "고름가죽 불곰",
	vilethorn_blossom = "썩은가시 꽃",
	rotheart_dryad = "썩은심장 드리아드",
	rotheart_keeper = "썩은심장 수호자",
	nightmare_dweller = "악몽 외눈박이",
	bloodtainted_fury = "피로 물든 격노",
	bloodtainted_burster = "피로 물든 파괴자",
	taintheart_summoner = "타락심장 소환사",
	dreadfire_imp = "공포화염 임프",
	tormented_bloodseeker = "고통의 흡혈박쥐",
})

BigWigsAPI.SetBossModuleLocale("Oakheart", {
	throw = "던지기",
})

-- Eye of Azshara

BigWigsAPI.SetBossModuleLocale("Eye of Azshara Trash", {
	wrangler = "증오갈퀴 사냥꾼",
	stormweaver = "증오갈퀴 폭풍술사",
	crusher = "증오갈퀴 분쇄자",
	oracle = "증오갈퀴 점쟁이",
	siltwalker = "마크라나 진흙방랑자",
	tides = "안식 없는 조류",
	arcanist = "증오갈퀴 비전술사",
})

BigWigsAPI.SetBossModuleLocale("Lady Hatecoil", {
	custom_on_show_helper_messages = "정전기 회오리/집중된 번개 도우미",
	custom_on_show_helper_messages_desc = "이 옵션을 활성화하면 보스가 |cff71d5ff정전기 회오리|r 나 |cff71d5ff집중된 번개|r 를 시전할때 땅/물 중 어디가 안전한지 알려주는 도우미 메세지를 표시합니다.",

	water_safe = "%s (물이 안전!)",
	land_safe = "%s (땅이 안전!)",
})

-- Halls of Valor

BigWigsAPI.SetBossModuleLocale("Odyn", {
	gossip_available = "대화 가능",
	gossip_trigger = "정말 놀랍군! 발라리아르의 힘에 견줄 만큼 강력한 자를 보게 될 줄은 몰랐거늘, 이렇게 너희가 나타나다니.",

	[197963] = "|cFF800080우측 상단|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Right"
	[197964] = "|cFFFFA500우측 하단|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Right"
	[197965] = "|cFFFFFF00좌측 하단|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Bottom Left"
	[197966] = "|cFF0000FF좌측 상단|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top Left"
	[197967] = "|cFF008000상단|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)", -- Translate "Top"
})

BigWigsAPI.SetBossModuleLocale("God-King Skovald", {
	warmup_text = "신왕 스코발드 활성화",
	warmup_trigger = "스코발드, 아이기스는 이미 주인을 찾았다. 자격이 충분한 용사들이지. 네 권리를 주장하기엔 너무 늦었어.",
	warmup_trigger_2 = "이 가짜 용사들이 아이기스를 포기하지 않는다면... 목숨을 포기해야 할 거다!",
})

BigWigsAPI.SetBossModuleLocale("Halls of Valor Trash", {
	mug_of_mead = "벌꿀술 잔",
	valarjar_thundercaller = "발라리아르 천둥술사",
	storm_drake = "폭풍 비룡",
	stormforged_sentinel = "폭풍벼림 파수병",
	valarjar_runecarver = "발라리아르 룬조각사",
	valarjar_mystic = "발라리아르 비술사",
	valarjar_purifier = "발라리아르 정화자",
	valarjar_shieldmaiden = "발라리아르 방패여전사",
	valarjar_aspirant = "발라리아르 지원자",
	solsten = "솔스텐",
	olmyr = "깨달은 자 올미르",
	valarjar_marksman = "발라리아르 명사수",
	gildedfur_stag = "금빛털가죽 순록",
	angerhoof_bull = "화난발굽 황소",
	valarjar_trapper = "발라리아르 덫사냥꾼",
	fourkings = "네명의 왕",
})

-- Return to Karazhan

BigWigsAPI.SetBossModuleLocale("Karazhan Trash", {
	-- Opera Event
	custom_on_autotalk_desc = "오페라 극장 우두머리 전투를 시작하는 반즈의 대화 선택지를 즉시 고릅니다.",
	opera_hall_wikket_story_text = "오페라 극장: 우끼드",
	opera_hall_wikket_story_trigger = "주둥이 닫아라", -- Shut your jabber, drama man! The Monkey King got another plan!
	opera_hall_westfall_story_text = "오페라 극장: 서부 몰락지대 이야기",
	opera_hall_westfall_story_trigger = "한 쌍의 연인을 만납니다", -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	opera_hall_beautiful_beast_story_text = "오페라 극장: 미녀와 짐승",
	opera_hall_beautiful_beast_story_trigger = "낭만과 분노의 이야기", -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	barnes = "반즈",
	ghostly_philanthropist = "유령 자선가",
	skeletal_usher = "해골 안내인",
	spectral_attendant = "수행원 유령",
	spectral_valet = "유령 종업원",
	spectral_retainer = "유령 당원",
	phantom_guardsman = "유령 경비병",
	wholesome_hostess = "건전한 시녀",
	reformed_maiden = "교화된 무희",
	spectral_charger = "유령 준마",

	-- Return to Karazhan: Upper
	chess_event = "체스 이벤트",
	king = "킹",
})

BigWigsAPI.SetBossModuleLocale("Moroes", {
	cc = "군중 제어",
	cc_desc = "유령 손님의 군중을 통제하기 위한 타이머와 알림.",
})

BigWigsAPI.SetBossModuleLocale("Nightbane", {
	name = "파멸의 어둠",
})

-- Maw of Souls

BigWigsAPI.SetBossModuleLocale("Maw of Souls Trash", {
	soulguard = "물에 젖은 영혼 경비병",
	champion = "헬라리아르 용사",
	mariner = "어둠의 순찰대 갑판원",
	swiftblade = "바다의 저주를 받은 쾌속검날",
	mistmender = "바다의 저주를 받은 안개치유사",
	mistcaller = "헬라리아르 안개소환사",
	skjal = "스키알",
})

-- Neltharion's Lair

BigWigsAPI.SetBossModuleLocale("Neltharions Lair Trash", {
	rokmora_first_warmup_trigger = "나바로그? 이 배신자! 감히 침입자들을 끌고 여기 오다니!",
	rokmora_second_warmup_trigger = "어느 쪽이든, 매 순간을 다 즐겨 주지. 로크모라, 박살내라!",

	vileshard_crawler = "악성수정 게",
	tarspitter_lurker = "타르쐐기 잠복벌레",
	rockback_gnasher = "돌가죽 뾰족니악어",
	vileshard_hulk = "악성수정 괴수",
	vileshard_chunk = "악성수정 덩치",
	understone_drummer = "아랫돌 북장이",
	mightstone_breaker = "막돌 파괴자",
	blightshard_shaper = "역병수정 조물사",
	stoneclaw_grubmaster = "돌발톱 벌레 조련사",
	tarspitter_grub = "타르쐐기 유충",
	rotdrool_grabber = "올가미 부식벌레",
	understone_demolisher = "아랫돌 파괴자",
	rockbound_trapper = "돌갑옷 속박투사",
	emberhusk_dominator = "잿불껍질 통솔자",
})

BigWigsAPI.SetBossModuleLocale("Ularogg Cragshaper", {
	hands = "손", -- Short for "Stone Hands"
})

-- Seat of the Triumvirate

BigWigsAPI.SetBossModuleLocale("Viceroy Nezhar", {
	guards = "어둠수호병 공허지기",
	interrupted = "%s|1이;가; %s|1을;를; 시전 방해했습니다 (%.1f초 남음)!",
})

BigWigsAPI.SetBossModuleLocale("L'ura", {
	warmup_text = "르우라 활성화",
})

BigWigsAPI.SetBossModuleLocale("Seat of the Triumvirate Trash", {
	-- Pre-Midnight
	custom_on_autotalk_desc = "알레리아 윈드러너의 대화 선택지를 즉시 고릅니다.",
	gossip_available = "대화 가능",
	alleria_gossip_trigger = "따라오세요!", -- Allerias yell after the first boss is defeated
	lura_warmup_trigger = "이 혼돈... 이 고통. 이런 건 느낀 적이 없어.",
	lura_warmup_trigger_2 = "허나 사색은 미뤄두지. 이 존재는 죽어야 한다.",

	alleria = "알레리아 윈드러너",
	subjugator = "어둠수호병 정복자",
	voidbender = "어둠수호병 공허술사",
	conjurer = "어둠수호병 창조술사",
	weaver = "대흑마술사",

	-- Midnight+
	void_rifts_closed = "공허의 균열 닫힘",
	void_rifts_closed_desc = "공허의 균열이 닫혔을 때 알림을 표시합니다.",
})

-- The Arcway

BigWigsAPI.SetBossModuleLocale("The Arcway Trash", {
	anomaly = "비전 변형물",
	shade = "뒤틀린 그림자",
	wraith = "메마른 마나 망령",
	blade = "격노수호병 지옥검사",
	chaosbringer = "에레다르 혼돈인도자",
})

-- Vault of the Wardens

BigWigsAPI.SetBossModuleLocale("Cordana Felsong", {
	kick_combo = "발차기 연계",

	light_dropped = "%s님이 빛을 떨어뜨렸습니다.",
	light_picked = "%s님이 빛을 주웠습니다.",

	warmup_trigger = "난 이미 원하는 걸 손에 넣었다. 그저 기다렸을 뿐... 너희를 확실히 끝장낼 순간을 말이다!",
	warmup_trigger_2 = "바보 녀석들이 내 덫에 걸려들었구나. 어둠 속에서 얼마나 잘 싸우는지 보자.",
})

BigWigsAPI.SetBossModuleLocale("Tirathon Saltheril", {
	warmup_trigger = "나는 추방당하고 버려진 \"나의\" 일족을 섬기겠다.",
})

BigWigsAPI.SetBossModuleLocale("Vault of the Wardens Trash", {
	infester = "지옥서약 감염자",
	myrmidon = "지옥서약 미르미돈",
	fury = "지옥 마력 격노병",
	mother = "부정한 어미",
	illianna = "칼춤꾼 일리아나",
	mendacius = "공포군주 멘다시우스",
	grimhorn = "험악뿔 구속자",
})
