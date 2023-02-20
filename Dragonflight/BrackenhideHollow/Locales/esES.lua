local L = BigWigs:NewBossLocale("Brackenhide Hollow Trash", "esES") or BigWigs:NewBossLocale("Brackenhide Hollow Trash", "esMX")
if not L then return end
if L then
	L.custom_on_cauldron_autotalk = "Hablar automáticamente"
	--L.custom_on_cauldron_autotalk_desc = "[Alchemy] Instantly detoxify Decaying Cauldrons for a disease dispel buff."

	L.decaying_cauldron = "Caldera en descomposición"
	L.decay_speaker = "Portavoz de la descomposición"
	L.claw_fighter = "Luchador de zarpa"
	L.bonebolt_hunter = "Cazador sacudehuesos"
	L.bracken_warscourge = "Azote de guerra Frondacuero"
	L.decayed_elder = "Ancestro descompuesto"
	L.wilted_oak = "Roble marchito"
	L.stinkbreath = "Tufoaliento"
	L.rageclaw = "Garrafuria"
	L.fleshripper_vulture = "Buitre desgarracarnes"
	L.filth_caller = "Clamainmundicia"
	L.fetid_rotsinger = "Cantaputrefacción fétida"
end
