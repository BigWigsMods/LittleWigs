local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "zhTW")
if not L then return end
if L then
	L.nazjar_oracle = "納茲賈爾神諭者"
	L.vicious_snap_dragon = "兇惡嚙龍"
	L.nazjar_sentinel = "納茲賈爾哨兵"
	L.nazjar_ravager = "納茲賈爾掠奪者"
	L.nazjar_tempest_witch = "納茲賈爾風暴女巫"
	L.faceless_seer = "無面先知"
	L.faceless_watcher = "無面看守者"
	L.tainted_sentry = "被感染的哨衛"

	L.ozumat_warmup_trigger = "那頭怪物回來了!不能讓牠污染我的水!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "zhTW")
if L then
	L.high_tide_trigger1 = "武裝吧，手下們!從冰冷的深海竄起!"
	L.high_tide_trigger2 = "消滅這些入侵讓他們被渾沌黑暗吞噬!"
end

L = BigWigs:NewBossLocale("Ozumat", "zhTW")
if L then
	L.custom_on_autotalk = "自動對話"
	L.custom_on_autotalk_desc = "立即選擇對話選項以開始戰鬥。"
end
