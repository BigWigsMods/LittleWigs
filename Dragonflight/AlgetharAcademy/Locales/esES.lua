local L = BigWigs:NewBossLocale("Algeth'ar Academy Trash", "esES") or BigWigs:NewBossLocale("Algeth'ar Academy Trash", "esMX")
if not L then return end
if L then
	L.custom_on_recruiter_autotalk = "Hablar automáticamente"
	L.custom_on_recruiter_autotalk_desc = "Ofrece instantánemante un beneficio a los reclutadores Dragonflight."
	L.critical_strike = "+5% Golpe crítico"
	L.haste = "+5% Celeridad"
	L.mastery = "+Maestría"
	L.versatility = "+5% Versatilidad"
	L.healing_taken = "+10% Sanación recibida"

	L.corrupted_manafiend = "Maligno de maná corrupto"
	L.spellbound_scepter = "Cetro vinculado"
	L.arcane_ravager = "Devastador Arcano"
	L.unruly_textbook = "Libro de texto indisciplinado"
	L.guardian_sentry = "Centinela guardián"
	L.alpha_eagle = "Águila alfa"
	L.vile_lasher = "Azotador vil"
	L.algethar_security = "Seguridad de Algeth'ar"
	L.algethar_echoknight = "Caballero del eco de Algeth'ar"
	L.spectral_invoker = "Invocadora espectral"
	L.ethereal_restorer = "Restaurador etéreo"
end
