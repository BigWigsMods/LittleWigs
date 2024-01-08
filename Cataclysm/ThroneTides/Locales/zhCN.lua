local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "zhCN")
if not L then return end
if L then
	L.nazjar_oracle = "纳兹夏尔神谕者"
	L.vicious_snap_dragon = "恶毒的钳齿龙"
	L.nazjar_sentinel = "纳兹夏尔哨兵"
	L.nazjar_ravager = "纳兹夏尔破坏者"
	L.nazjar_tempest_witch = "纳兹夏尔风暴女巫"
	L.faceless_seer = "无面先知"
	L.faceless_watcher = "无面看守者"
	L.tainted_sentry = "污染哨兵"

	L.ozumat_warmup_trigger = "那头怪兽回来了！绝对不能让它污染我的水域！"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "zhCN")
if L then
	L.high_tide_trigger1 = "武装起来，我的奴仆！从寒冰深渊中崛起吧！"
	L.high_tide_trigger2 = "毁灭这些入侵者！将他们丢进无尽的黑暗之中！"
end

L = BigWigs:NewBossLocale("Ozumat", "zhCN")
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择对话选项开始战斗。"
end
