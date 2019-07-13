local L = BigWigs:NewBossLocale("Freehold Trash", "zhTW")
if not L then return end
if L then
	L.sharkbait = "鯊鯊"
	L.enforcer = "鐵潮執法者"
	L.bonesaw = "鐵潮鋸骨者"
	L.crackshot = "鐵潮射手"
	L.corsair = "鐵潮海寇"
	L.duelist = "分水決鬥者"
	L.oarsman = "鐵潮划槳手"
	L.juggler = "分水飛刀手"
	L.scrapper = "黑牙拳匪"
	L.knuckleduster = "黑牙挑釁者"
	L.swabby = "污鼠會海員"
	L.trapper = "害蟲陷補者"
	L.rat_buccaneer = "污鼠會海盜"
	L.padfoot = "污鼠會獸足劫匪"
	L.rat = "溼透的船鼠"
	L.crusher = "鐵潮粉碎者"
	L.buccaneer = "鐵潮海盜"
	L.ravager = "鐵潮劫毀者"
	L.officer = "鐵潮軍官"
	L.stormcaller = "鐵潮風暴召喚者"
end

L = BigWigs:NewBossLocale("Council o' Captains", "zhTW")
if L then
	L.crit_brew = "爆擊酒"
	L.haste_brew = "加速酒"
	L.bad_brew = "壞酒！"
end

L = BigWigs:NewBossLocale("Ring of Booty", "zhTW")
if L then
	L.custom_on_autotalk = "自動對話"
	L.custom_on_autotalk_desc = "立即選擇對話選項以開始戰鬥。"

	-- Gather 'round and place yer bets! We got a new set of vict-- uh... competitors! Take it away, Gurgthok and Wodin!
	L.lightning_warmup = "我們有新的肉靶"
	-- It's a greased up pig? I'm beginning to think this is not a professional setup. Oh well... grab the pig and you win
	L.lightning_warmup_2 = "我開始覺得這一點都不像職業賽"

	L.lightning = "閃電"
	L.lightning_caught = "用 %.1f 秒抓到閃電！"
	L.ludwig = "路德威‧馮‧托爾托"
	L.trothak = "托鯊客"
end
