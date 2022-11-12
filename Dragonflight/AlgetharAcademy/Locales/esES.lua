local L = BigWigs:NewBossLocale("Algeth'ar Academy Trash", "esES") or BigWigs:NewBossLocale("Algeth'ar Academy Trash", "esMX")
if not L then return end
if L then
	L.recruiter_autotalk = "Hablar automáticamente"
	--L.recruiter_autotalk_desc = "Instantly pledge to the Dragonflight Recruiters for a buff."
	L.critical_strike = "+5% Golpe crítico"
	L.haste = "+5% Celeridad"
	L.mastery = "+Maestría"
	L.versatility = "+5% Versatilidad"
	L.healing_taken = "+10% Sanación recibida"
end
