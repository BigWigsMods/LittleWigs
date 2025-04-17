-- Magisters' Terrace

local L = BigWigs:NewBossLocale("Vexallus", "zhCN")
if not L then return end
if L then
	L.energy_discharged = "放射出%s" -- %s = Pure Energy (npc ID = 24745)
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider Magisters' Terrace", "zhCN")
if L then
	-- 别拿那种眼神看着我！我知道你们在想些什么，但风暴要塞的失败早就过去了。你们真以为我会把命运交给一个又瞎又粗野又下贱的暗夜精灵杂种？
	L.warmup_trigger = "别拿那种眼神看着我！"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "zhCN")
if L then
	L.mage_guard = "炎刃魔法卫兵"
	L.magister = "炎刃魔导师"
	L.keeper = "炎刃守护者"
end

-- Mana-Tombs

L = BigWigs:NewBossLocale("Mana-Tombs Trash", "zhCN")
if L then
	L.scavenger = "虚灵清道夫"
	L.priest = "虚灵牧师"
	L.nexus_terror = "节点恐魔"
	L.theurgist = "虚灵妖术师"
end

-- Old Hillsbrad Foothills

L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "zhCN")
if L then
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

-- The Arcatraz

L = BigWigs:NewBossLocale("Harbinger Skyriss", "zhCN")
if L then
	-- 我知道王子殿下会非常生气，但是我……我不知道自己怎么回事，居然把它们都放出来了！主人在对我说话，你也看到了……等等，有人来了。你们不是凯尔萨斯派来的！好极了……我会告诉王子殿下，是你们放走了囚犯！
	L.first_cell_trigger = "我不知道自己怎么回事"
	-- 看吧！又一个拥有深不可测的力量的恐怖生物！
	L.second_and_third_cells_trigger = "深不可测的力量的恐怖生物"
	-- 混乱！疯狂！啊，您真是太睿智了！是的，我明白了，当然！
	L.fourth_cell_trigger = "混乱！疯狂！"
	-- 控制弱者的思想是非常容易的事情……因为我所效忠的力量不会为时间所侵蚀，亦不被命运所左右。这个世界上没有什么力量能让我们屈膝……即使是燃烧军团也不行！
	L.warmup_trigger = "燃烧军团也不行"

	L.prison_cell = "监狱牢笼"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "zhCN")
if L then
	L.entropic_eye = "熵能之眼"
	L.sightless_eye = "盲目之眼"
	L.soul_eater = "艾瑞达食魂者"
	L.temptress = "恶毒的女妖"
	L.abyssal = "巨型深渊火魔"
end

-- The Black Morass

L = BigWigs:NewBossLocale("The Black Morass Trash", "zhCN")
if L then
	L.wave = "波数警报"
	L.wave_desc = "每波的大概警报。"

	L.medivh = "麦迪文"
	L.rift = "时间裂隙"
end

-- The Mechanar

L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhCN")
if L then
	L.despawn_message = "虚空怨灵即将召回"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhCN")
if L then
	L.bossName = "看守者埃隆汉"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "zhCN")
if L then
	L.bossName = "看守者盖罗基尔"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "zhCN")
if L then
	L.fixate_desc = "使施法者锁定一个随机目标。"
end

-- The Shattered Halls

L = BigWigs:NewBossLocale("The Shattered Halls Trash", "zhCN")
if L then
	L.legionnaire = "碎手军团士兵"
	L.brawler = "碎手争斗者"
	L.acolyte = "影月侍僧"
	L.darkcaster = "影月暗法师"
	L.assassin = "碎手刺客"
end

-- The Slave Pens

L = BigWigs:NewBossLocale("The Slave Pens Trash", "zhCN")
if L then
	L.defender = "盘牙卫士"
	L.enchantress = "盘牙魔法师"
	L.healer = "盘牙医师"
	L.collaborator = "盘牙背叛者"
	L.ray = "盘牙鳐"
end

L = BigWigs:NewBossLocale("Ahune", "zhCN")
if L then
	L.ahune = "埃霍恩"
	L.warmup_trigger = "寒冰之石融化了！"
end

-- The Steamvault

L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "zhCN")
if L then
	L.mech_trigger = "好好修理他们，伙计们！"
end
