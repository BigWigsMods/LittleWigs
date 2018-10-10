local L = BigWigs:NewBossLocale("Aqu'sirr", "zhTW")
if not L then return end
if L then
	L.warmup_trigger = "你們這些蠢貨竟敢來弄髒這個聖地"
end

L = BigWigs:NewBossLocale("Lord Stormsong", "zhTW")
if L then
	L.warmup_trigger_horde = "我會把你們丟往黑暗身淵，大海會讓你們粉身碎骨"
	-- L.warmup_trigger_alliance = "Master! Stop this madness at once! The Kul Tiran fleet must not fall to darkness!"
end
