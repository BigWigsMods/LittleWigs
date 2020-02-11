local L = BigWigs:NewBossLocale("Underrot Trash", "deDE")
if not L then return end
if L then
	L.custom_on_fixate_plates = "Durst nach Blut Symbol über gegnerischen Namensplaketten"
	L.custom_on_fixate_plates_desc = "Zeigt ein Symbol an der Namensplakette des Dich fixierenden Ziels an.\nBenötigt die Verwendung gegnerischer Namensplaketten. Diese Funktion wird derzeit nur von KuiNameplates unterstützt."

	L.spirit = "Besudelter Geist"
	L.priest = "Ergebene Blutpriesterin"
	L.maggot = "Eitrige Made"
	L.matron = "Auserwählte Blutmatrone"
	L.lasher = "Kranker Peitscher"
	L.bloodswarmer = "Wilder Blutschwärmer"
	L.rot = "Lebendige Fäulnis"
	L.deathspeaker = "Gefallener Todessprecher"
	L.defiler = "Blutverschworener Schänder"
	L.corruptor = "Gesichtsloser Verderber"
end

L = BigWigs:NewBossLocale("Infested Crawg", "deDE")
if L then
	L.random_cast = "Ansturm oder Verdauungsstörung"
	L.random_cast_desc = "Der erste Zauber nach jedem Tobsuchtanfall ist zufällig."
end
