-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "zhCN")
if not L then return end
if L then
	L.name = "坎雷萨德·埃伯洛克"

	L.summons = "召唤"
	L.debuffs = "负面效果"

	L.start_say = "看呐" -- 看呐！我真的掌握了这个世界的魔能！现在，我掌握着恶魔之力……它难以名状，无穷无尽，无所不能！
	L.win_say = "裘碧卡" -- 裘碧卡？！你在干什么……？！
end

L = BigWigs:NewBossLocale("Essence of Order", "zhCN")
if L then
	L.name = "秩序精华"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Brother Korloff", "zhCN")
if L then
	L.engage_yell = "我要粉碎你。"
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "zhCN")
if L then
	L.engage_yell = "我就是传说！"
end

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "zhCN")
if L then
	L.engage_yell = "让你们也尝尝我无尽的痛苦！"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "zhCN")
if L then
	L.the_headless_horseman = "无头骑士"
	L.custom_on_autotalk_desc = "自动接受柳魔人的诅咒，并自动开始首领战。"
	L.curses_desc = "获得柳魔人的诅咒时通知你。"
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "zhCN")
if L then
	L.stage_2_trigger = "现在，莉莉安，你变身的时刻到了。"
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "zhCN")
if L then
	L.stage3_yell = "少不更事的时候，我连打出一记好拳都难，但经过多年修炼，我已今非昔比！"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "zhCN")
if L then
	L.destroying_sha = "毁灭之煞"
	L.slain_shado_pan_defender = "被害的影踪派防御者"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "zhCN")
if L then
	L.summon_desc = "当炎诛召唤发酵酒灵时发出警报。他们会施放|cff71d5ff活力发酵|r治疗首领。"
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "zhCN")
if L then
	-- 啊，还没完呢。看来，我们正面临野牛人的挑战。让我解释一下……
	L.yaungol_warmup_trigger = "啊，还没完呢。"

	-- 噢，天哪。如果我没搞错的话，这似乎是在演绎赵·追日者的故事。
	L.five_suns_warmup_trigger = "如果我没搞错的话"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "zhCN")
if L then
	L.corrupt_living_water = "腐蚀活水"
	L.fallen_waterspeaker = "陨落的水语者"
	L.haunting_sha = "游荡恶煞"
	L.the_talking_fish = "会说话的鱼"
	L.the_songbird_queen = "鸣鸟女皇"
	L.the_crybaby_hozen = "哭闹的猢狲"
	L.the_nodding_tiger = "摇头晃脑的老虎"
	L.the_golden_beetle = "金甲虫"
	L.sha_touched_guardian = "染煞守卫"
	L.depraved_mistweaver = "堕落的织雾者"
	L.shambling_infester = "蹒跚感染者"
	L.minion_of_doubt = "疑之爪牙"
end
