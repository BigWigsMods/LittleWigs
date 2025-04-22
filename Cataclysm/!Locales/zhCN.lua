-- End Time

local L = BigWigs:NewBossLocale("Echo of Baine", "zhCN")
if not L then return end
if L then
	L.totemDrop = "图腾已掉落"
	L.totemThrow = "%s已扔图腾"
end

-- Grim Batol

L = BigWigs:NewBossLocale("Erudax", "zhCN")
if L then
	L.summon = "召唤无面腐蚀者"
	L.summon_desc = "当埃鲁达克召唤无面腐蚀者时发出警报。"
	L.summon_message = "无面腐蚀者"
	L.summon_trigger = "召唤了一个"
end

L = BigWigs:NewBossLocale("Grim Batol Trash", "zhCN")
if L then
	L.twilight_earthcaller = "暮光唤地者"
	L.twilight_brute = "暮光蛮兵"
	L.twilight_destroyer = "暮光毁灭者"
	L.twilight_overseer = "暮光监督者"
	L.twilight_beguiler = "暮光欺诈者"
	L.molten_giant = "熔核巨人"
	L.twilight_warlock = "暮光术士"
	L.twilight_flamerender = "暮光烈焰粉碎者"
	L.twilight_lavabender = "暮光熔岩操纵使"
	L.faceless_corruptor = "无面腐蚀者"
end

-- Hour of Twilight

L = BigWigs:NewBossLocale("The Hour of Twilight Trash", "zhCN")
if L then
	L.custom_on_autotalk_desc = "立即和萨尔对话继续剧情。"
end

-- Lost City of the Tol'vir

L = BigWigs:NewBossLocale("Siamat", "zhCN")
if L then
	L.servant = "召唤仆从"
	L.servant_desc = "当召唤希亚玛特的仆从时发出警报。"
end

-- Shadowfang Keep

L = BigWigs:NewBossLocale("Lord Walden", "zhCN")
if L then
	-- %s will be either "Toxic Coagulant" or "Toxic Catalyst"
	L.coagulant = "%s：移动消除"
	L.catalyst = "%s：爆击增益"
	L.toxin_healer_message = "%s：全体 DoT"
end

-- The Stonecore

L = BigWigs:NewBossLocale("Corborus", "zhCN")
if L then
	L.burrow = "潜地/钻出"
	L.burrow_desc = "当克伯鲁斯潜地或钻出时发出警报。"
	L.burrow_message = "克伯鲁斯潜地！"
	L.burrow_warning = "5秒后潜地！"
	L.emerge_message = "克伯鲁斯钻出！"
	L.emerge_warning = "5秒后钻出！"
end

-- Throne of the Tides

L = BigWigs:NewBossLocale("Throne of the Tides Trash", "zhCN")
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

-- The Vortex Pinnacle

L = BigWigs:NewBossLocale("The Vortex Pinnacle Trash", "zhCN")
if L then
	L.armored_mistral = "覆甲冷风幽魂"
	L.gust_soldier = "狂风士兵"
	L.wild_vortex = "狂暴气旋"
	L.lurking_tempest = "潜伏风暴"
	L.cloud_prince = "云雾王子"
	L.turbulent_squall = "动荡暴风"
	L.empyrean_assassin = "云巅刺客"
	L.young_storm_dragon = "风暴幼龙"
	L.executor_of_the_caliph = "西风君王的执行者"
	L.temple_adept = "神殿助祭"
	L.servant_of_asaad = "阿萨德的仆从"
	L.minister_of_air = "空气司祭"
end

-- Well of Eternity

L = BigWigs:NewBossLocale("Well Of Eternity Trash", "zhCN")
if L then
	L.custom_on_autotalk_desc = "立即选择伊利丹对话选项。"
end

-- Zul'Aman

L = BigWigs:NewBossLocale("Daakara", "zhCN")
if L then
	L[42594] = "野熊之形" -- short form for "Essence of the Bear"
	L[42607] = "山猫之形"
	L[42606] = "雄鹰之形"
	L[42608] = "龙鹰之形"
end

L = BigWigs:NewBossLocale("Halazzi", "zhCN")
if L then
	L.spirit_message = "灵魂阶段"
	L.normal_message = "一般阶段"
end

L = BigWigs:NewBossLocale("Nalorakk", "zhCN")
if L then
	L.troll_message = "巨魔之形"
	L.troll_trigger = "纳洛拉克，变形，出发！"
end

-- Zul'Gurub

L = BigWigs:NewBossLocale("Jin'do the Godbreaker", "zhCN")
if L then
	L.barrier_down_message = "壁垒破除，%d剩余" -- short name for "Brittle Barrier" (97417)
end
