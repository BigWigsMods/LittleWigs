local L = BigWigs:NewBossLocale("Court of Stars Trash", "koKR")
if not L then return end
if L then
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

	L.hints = {
		"망토",
		"망토 없음",
		"주머니",
		"물약",
		"긴 소매",
		"짧은 소매",
		"장갑",
		"장갑 없음",
		"남자",
		"여자",
		"밝은색 조끼",
		"어두운색 조끼",
		"물약 없음",
		"책",
	}

	--[[ !!! IMPORTANT NOTE TO TRANSLATORS !!! ]]--
	--[[ The following translations have to exactly match the gossip text of the Chatty Rumormongers. ]]--

	-- Cape
	L.clue_1_1 = "그 첩자는 망토를 즐겨 입는다고 들었습니다."
	L.clue_1_2 = "그 첩자가 망토를 걸친 모습을 봤다는 사람이 있었습니다."

	-- No Cape
	L.clue_2_1 = "제가 듣기로는 그 첩자가 궁전에 망토를 벗어두고 여기 왔다고 합니다."
	L.clue_2_2 = "그 첩자는 망토를 싫어해서 절대로 입지 않는다고 합니다."

	-- Pouch
	L.clue_3_1 = "제 친구가 말하길, 그 첩자는 금을 너무 좋아해서 허리띠 주머니에도 금이 가득 들어 있다고 합니다."
	L.clue_3_2 = "그 첩자는 어찌나 사치스러운지 허리띠에 달린 주머니에 금화를 잔뜩 넣어서 다닌다고 합니다."
	L.clue_3_3 = "그 첩자는 마법의 주머니를 항상 가지고 다닌다고 들었습니다."
	L.clue_3_4 = "그 첩자는 허리띠 주머니도 휘황찬란한 자수로 꾸며져 있다고 합니다."

	-- Potions
	L.clue_4_1 = "그 첩자는 만약을 대비해... 물약 몇 개를 가져왔다고 합니다."
	L.clue_4_2 = "그 첩자는 허리띠에 물약을 매달고 있을 게 분명합니다."
	L.clue_4_3 = "그 첩자는 물약을 가지고 다닌데요. 이유가 뭘까요?"
	L.clue_4_4 = "이 얘기를 깜박할 뻔했네요... 그 첩자는 연금술사로 가장해 허리띠에 물약을 달고 다닌다고 합니다."

	-- Long Sleeves
	L.clue_5_1 = "초저녁에 첩자를 언뜻 보았는데... 긴 소매 옷을 입었던 것 같습니다."
	L.clue_5_2 = "오늘 밤 그 첩자는 소매가 긴 옷을 입었다고 들었어요."
	L.clue_5_3 = "오늘 밤 첩자는 긴 소매 옷을 입었다고 하더군요."
	L.clue_5_4 = "제 친구 말로는, 첩자가 긴 소매 옷을 입었다고 합니다."

	-- Short Sleeves
	L.clue_6_1 = "그 첩자는 시원한 걸 좋아해서 오늘 밤 짧은 소매를 입고 왔다고 들었습니다."
	L.clue_6_2 = "제 친구가 그 첩자가 입은 옷을 봤는데, 긴 소매는 아니었다는군요!"
	L.clue_6_3 = "그 첩자는 소매가 긴 옷을 입는 걸 정말 싫어한다고 합니다."
	L.clue_6_4 = "그 첩자는 팔을 빠르게 움직이려고 짧은 소매 옷만 고집한다고 합니다."

	-- Gloves
	L.clue_7_1 = "그 첩자는 항상 장갑을 낀다고 하더군요."
	L.clue_7_2 = "그 첩자는 항상 장갑을 낀다고 들었습니다."
	L.clue_7_3 = "그 첩자는 손에 있는 선명한 흉터를 가리려고 장갑을 낀다고 합니다."
	L.clue_7_4 = "제가 듣기로는, 그 첩자는 항상 신경 써서 손을 가린다고 합니다."

	-- No Gloves
	L.clue_8_1 = "그 첩자는 장갑을 끼는 일이 없다고 하더군요."
	L.clue_8_2 = "그 첩자는 장갑을 끼는 걸 싫어한다고 들었습니다."
	L.clue_8_3 = "그 첩자는 장갑을 끼지 않는답니다. 위급한 순간에 걸리적거려서 그렇겠지요."
	L.clue_8_4 = "안쪽 방에서 장갑 한 켤레를 발견했습니다. 첩자는 분명히 이 주변에 장갑을 끼지 않은 사람중 하나일 거예요."

	-- Male
	L.clue_9_1 = "한 남자가 대마법학자와 나란히 저택에 들어오는 걸 봤다는 얘기가 있더군요."
	L.clue_9_2 = "첩자가 여성이 아니라는 얘기를 들었습니다."
	L.clue_9_3 = "첩자가 나타났다고 합니다. 그 남자는 대단히 호감형이라고 하더군요."
	L.clue_9_4 = "한 연주자가 말하길, 그 남자가 끊임없이 그 지구에 관한 질문을 늘어놨다고 합니다."

	-- Female
	L.clue_10_1 = "아까 한 방문객이 그녀와 엘리산드가 함께 도착하는 걸 보았답니다."
	L.clue_10_2 = "어떤 여자가 귀족 지구에 관해 계속 묻고 다닌다고 하던데..."
	L.clue_10_3 = "그 불청객은 남자가 아니라는 말을 들었습니다."
	L.clue_10_4 = "첩자가 나타났다고 합니다. 그 여자는 아주 미인이라고 하더군요."

	-- Light Vest
	L.clue_11_1 = "그자는 첩자인데도 밝은색 조끼를 즐겨 입는다고 합니다."
	L.clue_11_2 = "오늘 밤 파티에 그 첩자는 밝은색 조끼를 입고 올 거라는 말을 들었습니다."
	L.clue_11_3 = "사람들이 그러는데, 오늘 밤 그 첩자는 어두운 색 조끼를 입지 않았다고 합니다."

	-- Dark Vest
	L.clue_12_1 = "오늘 밤 그 첩자는 어둡고 짙은 색의 조끼를 입었다고 합니다."
	L.clue_12_2 = "그 첩자는 어두운 색 조끼를 즐겨 입어요... 밤과 같은 색이죠."
	L.clue_12_3 = "소문에 그 첩자는 눈에 띄지 않으려고 밝은색 옷은 피한다더군요."
	L.clue_12_4 = "그 첩자는 분명 어두운 옷을 선호합니다."

	-- No Potions
	L.clue_13_1 = "그 첩자는 물약을 가지고 다니지 않는다고 합니다."
	L.clue_13_2 = "한 연주자가 그 첩자가 마지막 물약을 버리는 걸 봤다고 합니다. 그러니 더는 물약이 없겠죠."

	-- Book
	L.clue_14_1 = "그 첩자의 허리띠 주머니에는 비밀이 잔뜩 적힌 책이 담겨 있다고 합니다."
	L.clue_14_2 = "소문을 들어 보니, 그 첩자는 독서를 좋아해서 항상 책을 가지고 다닌다고 합니다."
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "koKR")
if L then
	L.warmup_trigger = "또 실패했구나 멜란드루스. 이번이 네 잘못을 바로잡을 기회다. 이 외부인들을 제거해라. 난 밤의 요새로 돌아가겠다."
end
