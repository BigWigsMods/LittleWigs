local L = BigWigs:NewBossLocale("Witherbark", "esES") or BigWigs:NewBossLocale("Witherbark", "esMX")
if not L then return end
if L then
	--L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

L = BigWigs:NewBossLocale("Yalnu", "esES") or BigWigs:NewBossLocale("Yalnu", "esMX")
if L then
	--L.warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "esES") or BigWigs:NewBossLocale("The Everbloom Trash", "esMX")
if L then
	L.dreadpetal = "Horripétalo"
	L.everbloom_naturalist = "Naturalista del Vergel Eterno"
	--L.everbloom_cultivator = "Everbloom Cultivator"
	L.rockspine_stinger = "Aguijón Rocaspina"
	L.everbloom_mender = "Ensalmador del Vergel Eterno"
	L.gnarlroot = "Tuercerraíces"
	L.melded_berserker = "Rabioso fusionado"
	L.infested_icecaller = "Llamahielos infestada"
	L.putrid_pyromancer = "Piromántico pútrido"
	L.addled_arcanomancer = "Arcanomántico desconcertado"
end
