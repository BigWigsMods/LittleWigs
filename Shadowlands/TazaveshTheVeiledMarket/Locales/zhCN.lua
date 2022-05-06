local L = BigWigs:NewBossLocale("Zo'phex the Sentinel", "zhCN")
if not L then return end
if L then
	L.zophex_warmup_trigger = "上交……所有……违禁品……"
end

L = BigWigs:NewBossLocale("The Grand Menagerie", "zhCN")
if L then
	L.achillite_warmup_trigger = "狂暴的野兽给您添乱了？解决方法很简单！"
	L.venza_goldfuse_warmup_trigger = "机会来了！斧子归我了！"
end

L = BigWigs:NewBossLocale("Myza's Oasis", "zhCN")
if L then
	L.add_wave_killed = "击退保安 (%d/%d)"
end

L = BigWigs:NewBossLocale("Tazavesh Trash", "zhCN")
if L then
	--L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	--L.soazmi_warmup_trigger = "Excuse our intrusion, So'leah. I hope we caught you at an inconvenient time."
	L.trading_game = "交易游戏"
	L.trading_game_desc = "在交易游戏期间使用正确的密码发出警报。"
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "交易游戏结束后，立即选择正确的密码。"
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

	L.interrogation_specialist = "审讯专员"
	L.portalmancer_zohonn = "传送门操控师佐·霍恩"
	L.armored_overseer_tracker_zokorss = "装甲监工 / 追踪者佐·刻斯"
	L.tracker_zokorss = "追踪者佐·刻斯"
	L.ancient_core_hound = "上古熔火恶犬"
	L.enraged_direhorn = "暴怒的恐角龙"
	L.cartel_muscle = "财团打手"
	L.cartel_smuggler = "财团走私者"
	L.support_officer = "支援警官"
	L.defective_sorter = "损坏的分拣机"
	L.market_peacekeeper = "集市维和者"
	L.veteran_sparkcaster = "老练的火花法师"
	L.commerce_enforcer = "贸易执行者"
	L.commerce_enforcer_commander_zofar = "贸易执行者 / 指挥官佐·法"
	L.commander_zofar = "指挥官佐·法"

	L.murkbrine_scalebinder = "浊盐缚鳞者"
	L.murkbrine_shellcrusher = "浊盐碎壳者"
	L.coastwalker_goliath = "踏滨巨人"
	L.stormforged_guardian = "雷铸守护者"
	L.burly_deckhand = "肌肉虬结的水手"
	L.adorned_starseer = "盛装的星辰先知"
	L.focused_ritualist = "专心的祭师"
	L.devoted_accomplice = "热心的同谋"
end
