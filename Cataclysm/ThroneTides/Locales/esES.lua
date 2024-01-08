local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "esES") or BigWigs:NewBossLocale("Throne of the Tides Trash", "esMX")
if not L then return end
if L then
	L.nazjar_oracle = "Oráculo Naz'jar"
	L.vicious_snap_dragon = "Bocadragón sañoso"
	L.nazjar_sentinel = "Centinela Naz'jar"
	L.nazjar_ravager = "Devastador Naz'jar"
	L.nazjar_tempest_witch = "Bruja de la tempestad Naz'jar"
	L.faceless_seer = "Vidente ignoto"
	L.faceless_watcher = "Vigía ignoto"
	L.tainted_sentry = "Avizor corrupto"

	--L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "esES") or BigWigs:NewBossLocale("Lady Naz'jar", "esMX")
if L then
	--L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	--L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

L = BigWigs:NewBossLocale("Ozumat", "esES") or BigWigs:NewBossLocale("Ozumat", "esMX")
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."
end
