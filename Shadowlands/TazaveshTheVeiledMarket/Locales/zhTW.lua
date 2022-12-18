local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "zhTW")
if not L then return end
if L then
	L.zophex_warmup_trigger = "放下...所有...違禁品..."
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "zhTW")
if L then
	L.achillite_warmup_trigger = "橫衝直撞的野獸毀了你的生活嗎？找我們準沒錯！"
	L.venza_goldfuse_warmup_trigger = "機會來了！那斧頭是我的了！"
end

L = BigWigs:NewBossLocale("Mailroom Mayhem", "zhTW")
if L then
	--L.delivery_portal = "Delivery Portal"
	--L.delivery_portal_desc = "Shows a timer for when the Delivery Portal will change locations."
end

L = BigWigs:NewBossLocale("Myza's Oasis", "zhTW")
if L then
	L.add_wave_killed = "擊退保安 (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "zhTW")
if L then
	L.menagerie_warmup_trigger = "接下來，是你們千呼萬喚的東西！據說是被惡魔詛咒的湮滅之鋒！"
	L.soazmi_warmup_trigger = "索利亞，抱歉打擾啦。看來我們來的時機不太對啊。"
	--L.portal_authority = "Tazavesh Portal Authority"
	L.custom_on_portal_autotalk = "自動對話"
	--L.custom_on_portal_autotalk_desc = "Instantly open portals back to the entrance when talking to Broker NPCs."
	L.trading_game = "交易游戲"
	L.trading_game_desc = "在交易游戲期間使用正確的密碼發出警報。"
	L.custom_on_trading_game_autotalk = "自動對話"
	L.custom_on_trading_game_autotalk_desc = "交易游戲結束後，立即選擇正確的密碼。"
	L.password_triggers = {
		["象牙貝殼"] = 53259,
		["寶藍綠洲"] = 53260,
		["翠玉棕櫚"] = 53261,
		["金黃沙粒"] = 53262,
		["琥珀日落"] = 53263,
		["翡翠海洋"] = 53264,
		["深紅寶石"] = 53265,
		["白鑞石塊"] = 53266,
		["蒼白花朵"] = 53267,
		["赤紅小刀"] = 53268
	}

	L.interrogation_specialist = "審問專家"
	L.portalmancer_zohonn = "傳送門法師佐尼"
	L.armored_overseer_tracker_zokorss = "武裝監督者 / 『追蹤者』佐寇司"
	L.tracker_zokorss = "『追蹤者』佐寇司"
	L.ancient_core_hound = "上古熔核犬"
	L.enraged_direhorn = "暴怒的恐角龍"
	L.cartel_muscle = "集團警衛"
	L.cartel_smuggler = "集圖走私者"
	L.support_officer = "支援官"
	L.defective_sorter = "故障的分類機"
	L.market_peacekeeper = "市場保安官"
	L.veteran_sparkcaster = "老練的火花施放者"
	L.commerce_enforcer = "貿易執法者"
	L.commerce_enforcer_commander_zofar = "貿易執法者 / 指揮官佐發"
	L.commander_zofar = "指揮官佐發"

	L.tazavesh_soleahs_gambit = "塔札維許：索利亞的險招"
	L.murkbrine_scalebinder = "暗洋縛鱗者"
	L.murkbrine_shellcrusher = "暗洋碎殼者"
	L.coastwalker_goliath = "岸行者巨人"
	L.stormforged_guardian = "風鑄守護者"
	L.burly_deckhand = "結實的水手"
	L.adorned_starseer = "絢麗觀星者"
	L.focused_ritualist = "專注的祭儀師"
	L.devoted_accomplice = "忠誠的共犯"
end
