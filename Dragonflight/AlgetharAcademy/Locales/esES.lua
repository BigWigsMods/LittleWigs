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

	--L.corrupted_manafiend = "Corrupted Manafiend"
	--L.spellbound_scepter = "Spellbound Scepter"
	--L.arcane_ravager = "Arcane Ravager"
	--L.unruly_textbook = "Unruly Textbook"
	--L.guardian_sentry = "Guardian Sentry"
	--L.alpha_eagle = "Alpha Eagle"
	--L.vile_lasher = "Vile Lasher"
	--L.algethar_security = "Algeth'ar Security"
	--L.algethar_echoknight = "Algeth'ar Echoknight"
	--L.spectral_invoker = "Spectral Invoker"
	--L.ethereal_restorer = "Ethereal Restorer"
end
