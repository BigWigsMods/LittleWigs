local L = BigWigs:NewBossLocale("Master Snowdrift", "deDE")
if not L then return end
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	L.stage3_yell = "ich klein war"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "deDE")
if L then
	L.destroying_sha = "Zerstörendes Sha"
	L.slain_shado_pan_defender = "Erschlagener Shado-Pan-Verteidiger"
end
