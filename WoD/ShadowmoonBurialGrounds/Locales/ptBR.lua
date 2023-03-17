local L = BigWigs:NewBossLocale("Sadana Bloodfury", "ptBR")
if not L then return end
if L then
	L.custom_on_markadd = "Adicionada marca da Comunhão Sombria"
	L.custom_on_markadd_desc = "Marca o add gerado pela Comunhão Sombria com {rt8}, requer promovido ou líder."
end

L = BigWigs:NewBossLocale("Bonemaw", "ptBR")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Submergir"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "ptBR")
if L then
	L.shadowmoon_bonemender = "Cola-osso da Lua Negra"
	L.reanimated_ritual_bones = "Ossos do Ritual Reanimados"
	L.void_spawn = "Rebento do Caos"
	L.shadowmoon_loyalist = "Legalista da Lua Negra"
	L.defiled_spirit = "Espírito Profanado"
	L.shadowmoon_dominator = "Dominador da Lua Negra"
	L.shadowmoon_exhumer = "Exumadora da Lua Negra"
	L.exhumed_spirit = "Espírito Exumado"
	L.monstrous_corpse_spider = "Aranha Carniceira Monstruosa"
	L.carrion_worm = "Verme Carniceiro"
end
