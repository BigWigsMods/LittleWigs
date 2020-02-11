local L = BigWigs:NewBossLocale("Freehold Trash", "zhCN")
if not L then return end
if L then
	L.sharkbait = "鲨鱼饵"
	L.enforcer = "铁潮执行者"
	L.bonesaw = "铁潮锯骨者"
	L.crackshot = "铁潮射手"
	L.corsair = "铁潮海盗"
	L.duelist = "破浪格斗家"
	L.oarsman = "铁潮桨手"
	L.juggler = "破浪飞刀手"
	L.scrapper = "黑齿拳手"
	L.knuckleduster = "黑齿暴徒"
	L.swabby = "水鼠帮水兵"
	L.trapper = "歹徒诱捕者"
	L.rat_buccaneer = "水鼠帮海盗"
	L.padfoot = "水鼠帮健步者"
	L.rat = "湿乎乎的舱底鼠"
	L.crusher = "铁潮打击者"
	L.buccaneer = "铁潮冒险家"
	L.ravager = "铁潮破坏者"
	L.officer = "铁潮军官"
	L.stormcaller = "铁潮唤雷者"
end

L = BigWigs:NewBossLocale("Council o' Captains", "zhCN")
if L then
	L.crit_brew = "爆击酒"
	L.haste_brew = "急速酒"
	L.bad_brew = "坏酒！"
end

L = BigWigs:NewBossLocale("Ring of Booty", "zhCN")
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择对话选项以开始战斗。"

	-- 来来来，下注了！又来了一群受害——呃，参赛者！交给你们了，古尔戈索克和伍迪！
	L.lightning_warmup = "又来了一群受害"
	-- 抹了油的猪？我开始对这场比赛的专业性产生怀疑了。好吧……抓到猪就算你赢。
	L.lightning_warmup_2 = "我开始对这场比赛的专业性产生怀疑了"

	L.lightning = "闪电"
	L.lightning_caught = "%.1f秒后抓住闪电！"
	L.ludwig = "路德维希·冯·托尔托伦"
	L.trothak = "托萨克"
end
