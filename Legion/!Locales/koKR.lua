-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "koKR")
if L then
	L.tugar = "투가르 블러드토템"
	L.jormog = "거수 요르모그"

	L.remaining = "비늘 남음"

	L.submerge = "숨기"
	L.submerge_desc = "땅 속으로 숨습니다, 담즙뱉기 지네 알을 소환하고 종유석을 떨어뜨립니다."

	L.charge_desc = "요르모그가 숨으면 주기적으로 당신에게 돌진합니다."

	L.rupture = "{243382} (X)"
	L.rupture_desc = "당신 밑에 X자 모양의 지옥 파열이 나타납니다. 5초 후 지면을 파열시켜 종유석이 솟아오르며 플레이어를 밀쳐냅니다."

	L.totem_warning = "토템이 당신을 공격합니다!"
end

L = BigWigs:NewBossLocale("Raest", "koKR")
if L then
	L.name = "라이스트 메이지스피어"

	L.handFromBeyond = "저 너머의 손"

	L.rune_desc = "지면에 소환의 룬이 생성됩니다. 사라질 때까지 악몽의 피조물이 생성됩니다."

	L.warmup_text = "카람 메이지스피어 활성화"
	L.warmup_trigger = "날 따라오다니 어리석군. 뒤틀린 황천이 내게 힘을 준다. 난 이미 너희의 상상 이상으로 강해졌다!"
	L.warmup_trigger2 = "침입자를 처단하라, 형제여!"
end

L = BigWigs:NewBossLocale("Kruul", "koKR")
if L then
	L.name = "대군주 크룰"
	L.inquisitor = "심문관 바리스"
	L.velen = "예언자 벨렌"

	L.warmup_trigger = "오만하고 멍청한 것들! 나에게는 수천 개의 세계에서 얻은 영혼의 힘이 흘러넘친다!"
	L.win_trigger = "그래, 좋아. 더 이상 우릴 가로막지 못하게 해 주지."

	L.nether_aberration_desc = "방 안에 황천 흉물을 생성하는 차원문을 소환합니다."

	L.smoldering_infernal = "이글거리는 지옥불정령"
	L.smoldering_infernal_desc = "이글거리는 지옥불정령을 소환합니다."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "koKR")
if L then
	L.erdris = "군주 에르드리스 쏜"

	L.warmup_trigger = "적절한 시간에 왔습니다."
	L.warmup_trigger2 = "무슨... 일이 일어나는 거지?" --Stage 5 Warm up

	L.mage = "타락한 되살아난 마법사"
	L.soldier = "타락한 되살아난 병사"
	L.arbalest = "타락한 되살아난 석궁병"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "koKR")
if L then
	L.name = "대마법사 실렘"
	L.corruptingShadows = "타락의 그림자"

	L.warmup_trigger1 = "너무 늦었다! 집중의 눈동자를 내가 통재하는 한" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	L.warmup_trigger2 = "마법을 빼앗긴 너의 세계를 나의 악마 주인님께서 손쉽게 파괴하실 거다" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "koKR")
if L then
	L.name = "아가타"
	L.imp_servant = "임프 하수인"
	L.fuming_imp = "독기 뿜는 임프"
	L.levia = "레비아" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	L.warmup_trigger1 = "너무 늦었다! 레비아의 힘은 내 것이다! 내 하수인들이 그 힘을 이용하여 키린 토에 침투하고, 내부로부터 붕괴시킬 것이다!" -- 35
	L.warmup_trigger2 = "지금도 내 세이야드는 의지가 약한 마법사들을 유혹하고 있다. 네 동맹은 제 발로 군단에 굴복할 것이다!" -- 16
	L.warmup_trigger3 = "하지만 먼저 내 장난감을 건드린 네 녀석을 벌해야겠지." -- 3

	L.stacks = "중첩"
end

L = BigWigs:NewBossLocale("Sigryn", "koKR")
if L then
	L.sigryn = "시그린"
	L.jarl = "야를 벨브란드"
	L.faljar = "룬의 현자 팔리아르"

	L.warmup_trigger = "뭐지? 이방인이 날 막으러 오다니?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "koKR")
if L then
	L.custom_on_autotalk_desc = "보랏빛 요새 침공을 시작하는 부관 신클래리의 대화 선택지를 즉시 선택합니다."
	L.keeper = "차원문 수호병"
	L.guardian = "차원문 수호자"
	L.infernal = "타오르는 지옥불정령"
end

L = BigWigs:NewBossLocale("Thalena", "koKR")
if L then
	L.essence = "정수"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "koKR")
if L then
	L.ghostly_retainer = "유령 수행원"
	L.ghostly_protector = "유령 수호자"
	L.ghostly_councilor = "유령 의원"
	L.lord_etheldrin_ravencrest = "군주 에델드린 레이븐크레스트"
	L.lady_velandras_ravencrest = "여군주 벨란드라스 레이븐크레스트"
	L.rook_spiderling = "탑 새끼거미"
	L.soultorn_champion = "영혼 찢긴 용사"
	L.risen_scout = "되살아난 정찰병"
	L.risen_archer = "되살아난 궁수"
	L.risen_arcanist = "되살아난 비전술사"
	L.wyrmtongue_scavenger = "고룡혓바닥 청소부"
	L.bloodscent_felhound = "피비린내 지옥사냥개"
	L.felspite_dominator = "지옥원한 통솔자"
	L.risen_swordsman = "되살아난 검사"
	L.risen_lancer = "되살아난 창기병"

	L.door_open_desc = "숨겨진 통로의 문이 열렸을 때를 나타내는 막대를 표시합니다."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "koKR")
if L then
	L.phase_2_trigger = "됐다! 슬슬 싫증이 나는군."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "koKR")
if L then
	L.custom_on_time_lost = "그림자 소실 단계 동안 잃어버린 시간"
	L.custom_on_time_lost_desc = "그림자 소실 단계 동안 잃어버린 시간을 바에 |cffff0000붉은색|r으로 표시합니다."
	L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "koKR")
if L then
	L.custom_on_autotalk_desc = "도마트락스 전투를 시작하는 아그라마르의 아이기스 대화 선택지를 즉시 선택합니다."

	L.missing_aegis = "아이기스 효과 없음!" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "아그라마르의 아이기스: 힐량 감소"
	L.aegis_damage = "아그라마르의 아이기스: 데미지 감소"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "koKR")
if L then
	L.dulzak = "둘자크"
	L.wrathguard = "지옥수호병 침략자"
	L.felguard = "지옥수호병 파괴자"
	L.soulmender = "지옥불길 영혼치유사"
	L.temptress = "지옥불길 요녀"
	L.botanist = "지옥살이 식물학자"
	L.orbcaster = "지옥길잡이 보주술사"
	L.waglur = "와글루르"
	L.scavenger = "고룡혓바닥 청소부"
	L.gazerax = "가제락스"
	L.vilebark = "썩은나무껍질 방랑자"

	L.throw_tome = "고서 던지기" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "koKR")
if L then
	L.duskwatch_sentry = "황혼감시대 보초병"
	L.duskwatch_reinforcement = "황혼감시대 지원병"
	L.Guard = "황혼감시대 경비병"
	L.Construct = "수호의 피조물"
	L.Enforcer = "지옥결속 집행자"
	L.Hound = "군단 지옥사냥개"
	L.Mistress = "그림자 여주인"
	L.Gerenth = "흉측한 게렌스"
	L.Jazshariu = "자즈샤리우"
	L.Imacutya = "이마쿠티아"
	L.Baalgar = "경계자 바알가르"
	L.Inquisitor = "감시하는 심문관"
	L.BlazingImp = "이글거리는 임프"
	L.Energy = "속박된 마력"
	L.Manifestation = "비전 현신"
	L.Wyrm = "마나 지룡"
	L.Arcanist = "황혼감시대 비전술사"
	L.InfernalImp = "지옥불 임프"
	L.Malrodi = "비전술사 말로디"
	L.Velimar = "벨리마르"
	L.ArcaneKeys = "비전 열쇠"
	L.clues = "단서"

	L.InfernalTome = "지옥불 고서"
	L.MagicalLantern = "마법 초롱"
	L.NightshadeRefreshments = "어둠그늘 간식"
	L.StarlightRoseBrew = "별빛 장미 차"
	L.UmbralBloom = "그림자 꽃"
	L.WaterloggedScroll = "물에 젖은 두루마리"
	L.BazaarGoods = "장터 물품"
	L.LifesizedNightborneStatue = "실물 크기의 나이트본 석상"
	L.DiscardedJunk = "버려진 쓰레기"
	L.WoundedNightborneCivilian = "부상당한 나이트본 시민"

	L.announce_buff_items = "강화 효과 아이템 알리기"
	L.announce_buff_items_desc = "던전 내의 모든 강화 효과 아이템과 아이템을 누가 사용할 수 있는 지 알립니다."

	L.available = "%s|cffffffff%s|r 사용 가능" -- Context: item is available to use
	L.usableBy = "사용 가능: %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "강화 효과 아이템 즉시 사용"
	L.custom_on_use_buff_items_desc = "이 옵션을 사용하면 던전 내 곳곳에 있는 강화 효과 아이템을 즉시 사용합니다. 두번째 우두머리 전의 수호병을 유인하는 아이템은 사용하지 않습니다."

	L.spy_helper = "첩자 이벤트 도우미"
	L.spy_helper_desc = "당신의 파티가 수집한 첩자에 대한 모든 단서를 표시하는 정보 상자를 표시합니다. 단서들은 파티원들에게 대화로도 전송됩니다."

	L.clueFound = "단서 발견 (%d/5): |cffffffff%s|r"
	L.spyFound = "%s|1이;가; 첩자 발견!"
	L.spyFoundChat = "첩자 찾았어요!"
	L.spyFoundPattern = "자, 너무 그렇게 다그치지 마십시오" -- 자, 너무 그렇게 다그치지 마십시오, [player] 님. 어디 조용한 곳으로 가서 다시 얘기해 보는 게 어떻겠습니까? 따라오시죠...

	L.hints[1] = "망토"
	L.hints[2] = "망토 없음"
	L.hints[3] = "주머니"
	L.hints[4] = "물약"
	L.hints[5] = "긴 소매"
	L.hints[6] = "짧은 소매"
	L.hints[7] = "장갑"
	L.hints[8] = "장갑 없음"
	L.hints[9] = "남자"
	L.hints[10] = "여자"
	L.hints[11] = "밝은색 조끼"
	L.hints[12] = "어두운색 조끼"
	L.hints[13] = "물약 없음"
	L.hints[14] = "책"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "koKR")
if L then
	L.warmup_trigger = "또 실패했구나 멜란드루스. 이번이 네 잘못을 바로잡을 기회다. 이 외부인들을 제거해라. 난 밤의 요새로 돌아가겠다."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "koKR")
if L then
	L.archdruid_glaidalis_warmup_trigger = "타락한 자들아... 너희 피에서 악몽의 냄새가 난다. 이 숲에서 꺼지지 않으면, 자연의 분노를 맛보게 되리라!"

	L.mindshattered_screecher = "정신파괴 비명날개"
	L.dreadsoul_ruiner = "공포영혼 파멸자"
	L.dreadsoul_poisoner = "공포영혼 독살자"
	L.crazed_razorbeak = "광기 어린 뾰족부리"
	L.festerhide_grizzly = "고름가죽 불곰"
	L.vilethorn_blossom = "썩은가시 꽃"
	L.rotheart_dryad = "썩은심장 드리아드"
	L.rotheart_keeper = "썩은심장 수호자"
	L.nightmare_dweller = "악몽 외눈박이"
	L.bloodtainted_fury = "피로 물든 격노"
	L.bloodtainted_burster = "피로 물든 파괴자"
	L.taintheart_summoner = "타락심장 소환사"
	L.dreadfire_imp = "공포화염 임프"
	L.tormented_bloodseeker = "고통의 흡혈박쥐"
end

L = BigWigs:NewBossLocale("Oakheart", "koKR")
if L then
	L.throw = "던지기"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "koKR")
if L then
	L.wrangler = "증오갈퀴 사냥꾼"
	L.stormweaver = "증오갈퀴 폭풍술사"
	L.crusher = "증오갈퀴 분쇄자"
	L.oracle = "증오갈퀴 점쟁이"
	L.siltwalker = "마크라나 진흙방랑자"
	L.tides = "안식 없는 조류"
	L.arcanist = "증오갈퀴 비전술사"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "koKR")
if L then
	L.custom_on_show_helper_messages = "정전기 회오리/집중된 번개 도우미"
	L.custom_on_show_helper_messages_desc = "이 옵션을 활성화하면 보스가 |cff71d5ff정전기 회오리|r 나 |cff71d5ff집중된 번개|r 를 시전할때 땅/물 중 어디가 안전한지 알려주는 도우미 메세지를 표시합니다."

	L.water_safe = "%s (물이 안전!)"
	L.land_safe = "%s (땅이 안전!)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "koKR")
if L then
	L.gossip_available = "대화 가능"
	L.gossip_trigger = "정말 놀랍군! 발라리아르의 힘에 견줄 만큼 강력한 자를 보게 될 줄은 몰랐거늘, 이렇게 너희가 나타나다니."

	L[197963] = "|cFF800080우측 상단|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500우측 하단|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00좌측 하단|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FF좌측 상단|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000상단|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "koKR")
if L then
	L.warmup_text = "신왕 스코발드 활성화"
	L.warmup_trigger = "스코발드, 아이기스는 이미 주인을 찾았다. 자격이 충분한 용사들이지. 네 권리를 주장하기엔 너무 늦었어."
	L.warmup_trigger_2 = "이 가짜 용사들이 아이기스를 포기하지 않는다면... 목숨을 포기해야 할 거다!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "koKR")
if L then
	L.mug_of_mead = "벌꿀술 잔"
	L.valarjar_thundercaller = "발라리아르 천둥술사"
	L.storm_drake = "폭풍 비룡"
	L.stormforged_sentinel = "폭풍벼림 파수병"
	L.valarjar_runecarver = "발라리아르 룬조각사"
	L.valarjar_mystic = "발라리아르 비술사"
	L.valarjar_purifier = "발라리아르 정화자"
	L.valarjar_shieldmaiden = "발라리아르 방패여전사"
	L.valarjar_aspirant = "발라리아르 지원자"
	L.solsten = "솔스텐"
	L.olmyr = "깨달은 자 올미르"
	L.valarjar_marksman = "발라리아르 명사수"
	L.gildedfur_stag = "금빛털가죽 순록"
	L.angerhoof_bull = "화난발굽 황소"
	L.valarjar_trapper = "발라리아르 덫사냥꾼"
	L.fourkings = "네명의 왕"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "koKR")
if L then
	-- Opera Event
	L.custom_on_autotalk_desc = "오페라 극장 우두머리 전투를 시작하는 반즈의 대화 선택지를 즉시 고릅니다."
	L.opera_hall_wikket_story_text = "오페라 극장: 우끼드"
	L.opera_hall_wikket_story_trigger = "주둥이 닫아라" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "오페라 극장: 서부 몰락지대 이야기"
	L.opera_hall_westfall_story_trigger = "한 쌍의 연인을 만납니다" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "오페라 극장: 미녀와 짐승"
	L.opera_hall_beautiful_beast_story_trigger = "낭만과 분노의 이야기" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "반즈"
	L.ghostly_philanthropist = "유령 자선가"
	L.skeletal_usher = "해골 안내인"
	L.spectral_attendant = "수행원 유령"
	L.spectral_valet = "유령 종업원"
	L.spectral_retainer = "유령 당원"
	L.phantom_guardsman = "유령 경비병"
	L.wholesome_hostess = "건전한 시녀"
	L.reformed_maiden = "교화된 무희"
	L.spectral_charger = "유령 준마"

	-- Return to Karazhan: Upper
	L.chess_event = "체스 이벤트"
	L.king = "킹"
end

L = BigWigs:NewBossLocale("Moroes", "koKR")
if L then
	L.cc = "군중 제어"
	L.cc_desc = "유령 손님의 군중을 통제하기 위한 타이머와 알림."
end

L = BigWigs:NewBossLocale("Nightbane", "koKR")
if L then
	L.name = "파멸의 어둠"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "koKR")
if L then
	L.soulguard = "물에 젖은 영혼 경비병"
	L.champion = "헬라리아르 용사"
	L.mariner = "어둠의 순찰대 갑판원"
	L.swiftblade = "바다의 저주를 받은 쾌속검날"
	L.mistmender = "바다의 저주를 받은 안개치유사"
	L.mistcaller = "헬라리아르 안개소환사"
	L.skjal = "스키알"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "koKR")
if L then
	L.rokmora_first_warmup_trigger = "나바로그? 이 배신자! 감히 침입자들을 끌고 여기 오다니!"
	L.rokmora_second_warmup_trigger = "어느 쪽이든, 매 순간을 다 즐겨 주지. 로크모라, 박살내라!"

	L.vileshard_crawler = "악성수정 게"
	L.tarspitter_lurker = "타르쐐기 잠복벌레"
	L.rockback_gnasher = "돌가죽 뾰족니악어"
	L.vileshard_hulk = "악성수정 괴수"
	L.vileshard_chunk = "악성수정 덩치"
	L.understone_drummer = "아랫돌 북장이"
	L.mightstone_breaker = "막돌 파괴자"
	L.blightshard_shaper = "역병수정 조물사"
	L.stoneclaw_grubmaster = "돌발톱 벌레 조련사"
	L.tarspitter_grub = "타르쐐기 유충"
	L.rotdrool_grabber = "올가미 부식벌레"
	L.understone_demolisher = "아랫돌 파괴자"
	L.rockbound_trapper = "돌갑옷 속박투사"
	L.emberhusk_dominator = "잿불껍질 통솔자"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "koKR")
if L then
	L.hands = "손" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "koKR")
if L then
	L.guards = "어둠수호병 공허지기"
	L.interrupted = "%s|1이;가; %s|1을;를; 시전 방해했습니다 (%.1f초 남음)!"
end

L = BigWigs:NewBossLocale("L'ura", "koKR")
if L then
	L.warmup_text = "르우라 활성화"
	L.warmup_trigger = "이 혼돈... 이 고통. 이런 건 느낀 적이 없어."
	L.warmup_trigger_2 = "허나 사색은 미뤄두지. 이 존재는 죽어야 한다."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "koKR")
if L then
	L.custom_on_autotalk_desc = "알레리아 윈드러너의 대화 선택지를 즉시 고릅니다."
	L.gossip_available = "대화 가능"
	L.alleria_gossip_trigger = "따라오세요!" -- Allerias yell after the first boss is defeated

	L.alleria = "알레리아 윈드러너"
	L.subjugator = "어둠수호병 정복자"
	L.voidbender = "어둠수호병 공허술사"
	L.conjurer = "어둠수호병 창조술사"
	L.weaver = "대흑마술사"
end

-- The Arcway

L = BigWigs:NewBossLocale("The Arcway Trash", "koKR")
if L then
	L.anomaly = "비전 변형물"
	L.shade = "뒤틀린 그림자"
	L.wraith = "메마른 마나 망령"
	L.blade = "격노수호병 지옥검사"
	L.chaosbringer = "에레다르 혼돈인도자"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "koKR")
if L then
	L.kick_combo = "발차기 연계"

	L.light_dropped = "%s님이 빛을 떨어뜨렸습니다."
	L.light_picked = "%s님이 빛을 주웠습니다."

	L.warmup_trigger = "난 이미 원하는 걸 손에 넣었다. 그저 기다렸을 뿐... 너희를 확실히 끝장낼 순간을 말이다!"
	L.warmup_trigger_2 = "바보 녀석들이 내 덫에 걸려들었구나. 어둠 속에서 얼마나 잘 싸우는지 보자."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "koKR")
if L then
	L.warmup_trigger = "나는 추방당하고 버려진 \"나의\" 일족을 섬기겠다."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "koKR")
if L then
	L.infester = "지옥서약 감염자"
	L.myrmidon = "지옥서약 미르미돈"
	L.fury = "지옥 마력 격노병"
	L.mother = "부정한 어미"
	L.illianna = "칼춤꾼 일리아나"
	L.mendacius = "공포군주 멘다시우스"
	L.grimhorn = "험악뿔 구속자"
end
