local L = BigWigs:NewBossLocale("The Stonevault Trash", "frFR")
if not L then return end
local female = BigWigsLoader.UnitSex("player") == 3
if L then
	L.earth_infused_golem = "Golem imprégné de terre"
	L.repurposed_loaderbot = "Robot chargeur converti"
	L.ghastly_voidsoul = "Ame du Vide ignoble"
	L.cursedheart_invader = "Envahisseur(euse) coeur-maudit"
	L.void_bound_despoiler = "Spoliateur lié au Vide"
	L.void_bound_howler = "Hurleur lié au Vide"
	L.turned_speaker = "Mandataire converti(e)"
	L.void_touched_elemental = "Élémentaire touché par le Vide"
	L.forgebound_mender = "Soigneur(euse) lié(e) à la forge"
	L.forge_loader = "Charge-forge"
	L.cursedforge_honor_guard = "Garde d'honneur fielforge"
	L.cursedforge_stoneshaper = "Sculpte-pierre fielforge"
	L.rock_smasher = "Casse-roche"

	L.edna_warmup_trigger = "Qu’est-ce que c’est ? Ce golem a fusionné avec quelque chose d’autre ?"
	L.custom_on_autotalk_desc = "|cFFFF0000Nécessite au moins 25 points de compétence en forge de Khaz Algar, ou que vous soyez ".. (female and "une guerrière" or "un guerrier") .." ou ".. (female and "une Naine" or "un Nain") ..".|r Sélectionne automatiquement le dialogue avec le PNJ qui octroie à votre groupe l'amélioration 'Énergie de fer imprégnée'."
end
