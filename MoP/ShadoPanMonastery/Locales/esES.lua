local L = BigWigs:NewBossLocale("Master Snowdrift", "esES") or BigWigs:NewBossLocale("Master Snowdrift", "esMX")
if not L then return end
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	--L.stage3_yell = "was but a cub"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "esES") or BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "esMX")
if L then
	L.destroying_sha = "Sha destructor"
	L.slain_shado_pan_defender = "Defensor del Shadopan asesinado"
end
