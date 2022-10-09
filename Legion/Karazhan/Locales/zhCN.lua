local L = BigWigs:NewBossLocale("Karazhan Trash", "zhCN")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择巴内斯对话选项开始歌剧院战斗。"
	L.opera_hall_wikket_story_text = "歌剧院：魔法坏女巫"
	L.opera_hall_wikket_story_trigger = "唱戏的家伙少废话" -- 唱戏的家伙少废话，美猴王有了个新想法！
	L.opera_hall_westfall_story_text = "歌剧院：西部故事"
	L.opera_hall_westfall_story_trigger = "我们将认识一对分属哨兵岭敌对双方的有情人" -- 今天……我们将认识一对分属哨兵岭敌对双方的有情人。
	L.opera_hall_beautiful_beast_story_text = "歌剧院：美女与野兽"
	L.opera_hall_beautiful_beast_story_trigger = "将上演爱情与愤怒的传奇" -- 今晚……将上演爱情与愤怒的传奇，它将再次证明，美不是肤浅的东西。

	-- Return to Karazhan: Lower
	L.barnes = "巴内斯"
	L.ghostly_philanthropist = "幽灵慈善家"
	L.skeletal_usher = "骷髅招待员"
	L.spectral_attendant = "鬼魅随从"
	L.spectral_valet = "鬼灵侍从"
	L.spectral_retainer = "鬼灵家仆"
	L.phantom_guardsman = "幻影卫兵"
	L.wholesome_hostess = "保守的女招待"
	L.reformed_maiden = "贞善女士"
	L.spectral_charger = "鬼灵战马"

	-- Return to Karazhan: Upper
	L.chess_event = "国际象棋"
	L.king = "国王"
end

L = BigWigs:NewBossLocale("Moroes", "zhCN")
if L then
	L.cc = "群体控制"
	L.cc_desc = "群体控制晚餐客人的计时器和警报。"
end

L = BigWigs:NewBossLocale("Nightbane", "zhCN")
if L then
	L.name = "夜之魇"
end
