local L = BigWigs:NewBossLocale("Freehold Trash", "esES") or BigWigs:NewBossLocale("Freehold Trash", "esMX")
if not L then return end
if L then
	L.sharkbait = "Cazatiburones"
	L.irontide_enforcer = "Déspota Marea de Hierro"
	L.irontide_bonesaw = "Sierrahuesos Marea de Hierro"
	L.irontide_crackshot = "Escopetero Marea de Hierro"
	L.irontide_corsair = "Corsaria Marea de Hierro"
	L.cutwater_duelist = "Duelista Aguacortada"
	L.irontide_oarsman = "Remero Marea de Hierro"
	L.cutwater_knife_juggler = "Malabarista de cuchillos Aguacortada"
	L.bilge_rat_brinescale = "Escamasalada de las Ratas de Pantoque"
	L.blacktooth_scrapper = "Desguazador Dientenegro"
	L.blacktooth_knuckleduster = "Nudillos Dientenegro"
	L.bilge_rat_swabby = "Bisoño de las Ratas de Pantoque"
	L.vermin_trapper = "Trampero de alimañas"
	L.bilge_rat_buccaneer = "Bucanero de las Ratas de Pantoque"
	L.bilge_rat_padfoot = "Piesuaves de las Ratas de Pantoque"
	L.soggy_shiprat = "Rata de barco empapada"
	L.irontide_crusher = "Triturador Marea de Hierro"
	L.irontide_buccaneer = "Bucanero Marea de Hierro"
	L.irontide_ravager = "Devastador Marea de Hierro"
	L.irontide_officer = "Oficial Marea de Hierro"
	L.irontide_stormcaller = "Clamatormentas Marea de Hierro"
end

L = BigWigs:NewBossLocale("Council o' Captains", "esES") or BigWigs:NewBossLocale("Council o' Captains", "esMX")
if L then
	L.crit_brew = "Brebaje de Crítico"
	L.haste_brew = "Brebaje de Celeridad"
	L.bad_brew = "Brebaje Malo"
end

L = BigWigs:NewBossLocale("Ring of Booty", "esES") or BigWigs:NewBossLocale("Ring of Booty", "esMX")
if L then
	L.custom_on_autotalk = "Hablar automáticamente"
	L.custom_on_autotalk_desc = "Selecciona instantáneamente la opción de charla para comenzar la pelea."

	-- Gather 'round and place yer bets! We got a new set of vict-- uh... competitors! Take it away, Gurgthok and Wodin!
	--L.lightning_warmup = "new set of vict--"
	-- It's a greased up pig? I'm beginning to think this is not a professional setup. Oh well... grab the pig and you win
	--L.lightning_warmup_2 = "not a professional setup"

	L.lightning = "Relámpago"
	L.lightning_caught = "¡Relámpago atrapado después de %.1f segundos!"
	L.ludwig = "Ludwig Von Tortollan"
	L.trothak = "Trothak"

	--L.left = "%s (Left)"
	--L.right = "%s (Right)"
end
