local L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "zhCN")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择伊洛希恩，萨尔和塔蕾莎闲聊选项。"

	L.incendiary_bombs = "燃烧弹"
	L.incendiary_bombs_desc = "显示已放置燃烧弹信息。"
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "zhCN")
if L then
	-- 你们！赶快去打水！在火势蔓延起来之前扑灭它！快一点，你们这些该死的东西！
	L.warmup_trigger = "快去打水"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "zhCN")
if L then
	-- 萨尔！你不会真的以为可以逃脱吧？你和你的伙伴们很快就要去接受布莱克摩尔的审讯……不过我得先跟你玩玩。
	L.warmup_trigger = "接受布莱克摩尔"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "zhCN")
if L then
	-- 啊，你来了。我原本希望以比较隐秘的方式解决问题，但是现在看来正面冲突是在所难免的了。你的命运之路在此终结，萨尔。你和你那些爱管闲事的朋友全都得死！
	L.trash_warmup_trigger = "爱管闲事的朋友"
	-- 够了。我要把你们全部消灭！
	L.boss_warmup_trigger = "全部消灭！"
end

