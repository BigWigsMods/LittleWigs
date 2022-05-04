local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "koKR")
if not L then return end
if L then
	L.zophex_warmup_trigger = "밀수품을... 전부... 내놓아라..."
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "koKR")
if L then
	--L.achillite_warmup_trigger = "Are rampaging beasts ruining your day? We have the solution!"
	--L.venza_goldfuse_warmup_trigger = "Now's my chance! That axe is mine!"
end

L = BigWigs:NewBossLocale("Myza's Oasis", "koKR")
if L then
	-- L.add_wave_killed = "Add wave killed (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "koKR")
if L then
	--L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	--L.soazmi_warmup_trigger = "Excuse our intrusion, So'leah. I hope we caught you at an inconvenient time."
	--L.trading_game = "Trading Game"
	--L.trading_game_desc = "Alerts with the right password during the Trading Game."
	L.custom_on_autotalk = "자동 대화"
	--L.custom_on_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	--[[L.password_triggers = {
		["Ivory Shell"] = true,
		["Sapphire Oasis"] = true,
		["Jade Palm"] = true,
		["Golden Sands"] = true,
		["Amber Sunset"] = true,
		["Emerald Ocean"] = true,
		["Ruby Gem"] = true,
		["Pewter Stone"] = true,
		["Pale Flower"] = true,
		["Crimson Knife"] = true
	}]]--

	L.interrogation_specialist = "심문 전문가"
	L.portalmancer_zohonn = "차원문술사 조혼"
	L.armored_overseer_tracker_zokorss = "무장한 감독관 / 추적자 조코르스"
	L.tracker_zokorss = "추적자 조코르스"
	L.ancient_core_hound = "고대의 심장부 사냥개"
	L.enraged_direhorn = "격노한 공포뿔"
	L.cartel_muscle = "중개단 불한당"
	L.cartel_smuggler = "중개단 밀수업자"
	L.support_officer = "지원 장교"
	L.defective_sorter = "불량 분류기"
	L.market_peacekeeper = "시장 평화감시단"
	L.veteran_sparkcaster = "노련한 불꽃술사"
	L.commerce_enforcer = "상업구 집행자"
	L.commerce_enforcer_commander_zofar = "상업구 집행자 / 사령관 조파르"
	L.commander_zofar = "사령관 조파르"

	L.murkbrine_scalebinder = "진흙소금 비늘결속자"
	L.murkbrine_shellcrusher = "진흙소금 껍질분쇄자"
	L.coastwalker_goliath = "해안방랑자 거수"
	L.stormforged_guardian = "폭풍벼림 수호자"
	L.burly_deckhand = "건장한 갑판원"
	L.adorned_starseer = "화려한 별예언가"
	L.focused_ritualist = "몰두하는 의식술사"
	L.devoted_accomplice = "헌신적인 동조자"
end
