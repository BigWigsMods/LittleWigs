local L = BigWigs:NewBossLocale("Freehold Trash", "frFR")
if not L then return end
if L then
	L.sharkbait = "Jacasse"
	L.enforcer = "Massacreur des Lamineurs"
	L.bonesaw = "Scie-les-os des Lamineurs"
	L.crackshot = "Flingueur des Lamineurs"
	L.corsair = "Corsaire des Lamineurs"
	L.duelist = "Duelliste des Eperonneurs"
	L.oarsman = "Rameur des Lamineurs"
	L.juggler = "Jongleur de couteaux des Eperonneurs"
	L.scrapper = "Bastonneur des Mort-aux-Dents"
	L.knuckleduster = "Truand des Mort-aux-Dents"
	L.swabby = "Mousse des Soutaillons"
	L.trapper = "Trappeur de vermine"
	L.rat_buccaneer = "Boucanier des Soutaillons"
	L.padfoot = "Patmol des Soutaillons"
	L.rat = "Rat de cale trempé"
	L.crusher = "Ecraseur des Lamineurs"
	L.buccaneer = "Boucanier des Lamineurs"
	L.ravager = "Ravageur des Lamineurs"
	L.officer = "Officier des Lamineurs"
	L.stormcaller = "Implorateur de tempête des Lamineurs"
end

L = BigWigs:NewBossLocale("Council o' Captains", "frFR")
if L then
	L.crit_brew = "Brevage de critique"
	L.haste_brew = "Brevage de hâte"
	L.bad_brew = "Brevage néfaste"
end

L = BigWigs:NewBossLocale("Ring of Booty", "frFR")
if L then
	 L.custom_on_autotalk = "Parler automatiquement"
	 L.custom_on_autotalk_desc = "Selectionne instantanément l'option des ragots pour commencer le combat."

	-- Gather 'round and place yer bets! We got a new set of vict-- uh... competitors! Take it away, Gurgthok and Wodin!
	-- L.lightning_warmup = "new set of vict--"
	-- It's a greased up pig? I'm beginning to think this is not a professional setup. Oh well... grab the pig and you win
	-- L.lightning_warmup_2 = "not a professional setup"

	L.lightning = "Foudre"
	-- L.lightning_caught = "Lightning caught after %.1f seconds!"
	L.ludwig = "Ludwig Von Tortollan"
	L.trothak = "Trothak"
end
