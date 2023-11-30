local L = BigWigs:NewBossLocale("Court of Stars Trash", "koKR")
if not L then return end
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
