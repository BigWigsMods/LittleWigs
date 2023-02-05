local L = BigWigs:NewBossLocale("Algeth'ar Academy Trash", "frFR")
if not L then return end
if L then
	L.custom_on_recruiter_autotalk = "Parler automatiquement"
	--L.custom_on_recruiter_autotalk_desc = "Instantly pledge to the Dragonflight Recruiters for a buff."
	L.critical_strike = "+5% Coup critique"
	L.haste = "+5% Hâte"
	L.mastery = "+Maîtrise"
	L.versatility = "+5% Polyvalence"
	L.healing_taken = "+10% Soins reçus"

	--L.vexamus_warmup_trigger = "created a powerful construct named Vexamus"
	--L.overgrown_ancient_warmup_trigger = "Ichistrasz! There is too much life magic"
	--L.crawth_warmup_trigger = "At least we know that works. Watch yourselves."

	L.corrupted_manafiend = "Manafiel corrompu"
	L.spellbound_battleaxe = "Hache d’armes envoûtée"
	L.spellbound_scepter = "Sceptre envoûté"
	L.arcane_ravager = "Ravageur des arcanes"
	L.unruly_textbook = "Manuel turbulent"
	L.guardian_sentry = "Factionnaire gardien"
	L.alpha_eagle = "Aigle alpha"
	L.vile_lasher = "Flagellant ignoble"
	L.algethar_echoknight = "Echo-chevalière d'Algeth'ar"
	L.spectral_invoker = "Invocatrice spectrale"
	L.ethereal_restorer = "Restaurateur éthéré"
end
