local L = BigWigs:NewBossLocale("Tribunal of Ages", "zhCN")
if not L then return end
if L then
	L.engage_trigger = "你们帮我看着点外面" -- 嗯，你们帮我看着点外面。我这样的强者只要锤两下就能搞定这破烂……
	L.defeat_trigger = "看来还是我这把老骨头厉害呀" --  哈！看来还是我这把老骨头厉害呀！然后再看看这里……
	L.fail_trigger = "还没"

	L.timers = "计时器"
	L.timers_desc = "发生各种事件的计时器。"

	L.victory = "胜利"
end
