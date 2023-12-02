local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "zhCN")
if not L then return end
if L then
	L.tugar = "图加·鲜血图腾"
	L.jormog = "“巨兽”乔莫格"

	L.remaining = "鳞片剩余"

	L.submerge = "下潜"
	L.submerge_desc = "下潜到地下，召唤飞掠蛛蛋和落下尖刺。"

	L.charge_desc = "当乔莫格下潜时，它会定期向你的方向冲锋。"

	L.rupture = "{243382}（X）"
	L.rupture_desc = "会在身下出现一个 X 形状的邪能破裂。5秒后将破裂地面，向上发射尖刺并击退在上面的玩家。"

	L.totem_warning = "图腾击中你！"
end

L = BigWigs:NewBossLocale("Raest", "zhCN")
if L then
	L.name = "莱斯特·法师之矛"

	L.handFromBeyond = "异世之手"

	L.rune_desc = "在地面上放置一个召唤符文。如果没有站在上面会出现梦魇之物。"

	L.killed = "%s已击杀"

	L.warmup_text = "卡兰姆·法师之矛激活"
	L.warmup_trigger = "你真蠢，居然跟着我来到这里，兄弟。扭曲虚空滋养了我的力量。我的强大已经超出了你的想象！"
	L.warmup_trigger2 = "杀了入侵者，兄弟！"
end

L = BigWigs:NewBossLocale("Kruul", "zhCN")
if L then
	L.name = "魔王库鲁尔"
	L.inquisitor = "审判官瓦里斯"
	L.velen = "先知维伦"

	L.warmup_trigger = "傲慢的蠢货！我掌握着千万世界的灵魂之力！"
	L.win_trigger = "那好吧。你们别想再挡路了。"

	L.nether_aberration_desc = "在房间内召唤传送门，出现虚空畸变怪。"

	L.smoldering_infernal = "阴燃的地狱火"
	L.smoldering_infernal_desc = "召唤一个阴燃的地狱火。"
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "zhCN")
if L then
	L.erdris = "艾德里斯·索恩领主"

	L.warmup_trigger = "你来的正是时候"
	L.warmup_trigger2 = "出……出什么事了？" -- Stage 5

	L.mage = "腐化的幽灵法师"
	L.soldier = "腐化的幽灵士兵"
	L.arbalest = "腐化的幽灵弩手"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "zhCN")
if L then
	L.name = "大法师克希雷姆"
	L.corruptingShadows = "腐蚀暗影"

	L.warmup_trigger1 = "掌握了聚焦之虹" -- 你太迟了，恶魔猎手！掌握了聚焦之虹，我就能直接从艾泽拉斯的魔网中抽取奥术能量来强化自身的法力！
	L.warmup_trigger2 = "被抽干魔力后，我的恶魔主人" -- 被抽干魔力后，我的恶魔主人就能占领你们的世界……我也将获得无穷的力量！
end

L = BigWigs:NewBossLocale("Agatha", "zhCN")
if L then
	L.name = "阿加莎"
	L.imp_servant = "小鬼仆从"
	L.fuming_imp = "阴燃的小鬼"
	L.levia = "莱维娅" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	L.warmup_trigger1 = "你太迟了！莱维娅的力量归我了！有了她的知识，我的人就能潜入肯瑞托，从内部瓦解它！" -- 35
	L.warmup_trigger2 = "此刻，我的萨亚德正在诱惑软弱的法师，你的盟友会自愿倒向军团！" -- 16
	L.warmup_trigger3 = "但，你得先为抢走我的宠物付出代价！" -- 3

	L.absorb = "吸收"
	L.stacks = "层数"
end

L = BigWigs:NewBossLocale("Sigryn", "zhCN")
if L then
	L.sigryn = "希格林"
	L.jarl = "维尔布兰德族长"
	L.faljar = "符文先知法尔加"

	L.warmup_trigger = "什么？外来者来阻止我了？"

	L.absorb = "吸收"
end
