local L = BigWigs:NewBossLocale("Harbinger Skyriss", "zhCN")
if not L then return end
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
