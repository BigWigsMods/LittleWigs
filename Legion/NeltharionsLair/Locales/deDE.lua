local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "deDE")
if not L then return end
if L then
	L.rokmora_first_warmup_trigger = "Navarrogg?! Verräter! Ihr führt diese Eindringlinge gegen uns ins Feld?!"
	L.rokmora_second_warmup_trigger = "Sei's drum, ich werde jeden Moment davon genießen. Rokmora, zerschmettert sie!"

	L.tarspitter_lurker = "Teerspuckerlauerer"
	L.rockback_gnasher = "Steinrückenknirscher"
	L.vileshard_hulk = "Ekelsplittergigant"
	L.vileshard_chunk = "Ekelsplitterbrocken"
	L.understone_drummer = "Hämmerer des Tiefgesteins"
	L.mightstone_breaker = "Machtsteinbrecher"
	L.blightshard_shaper = "Pestsplitterformer"
	L.stoneclaw_grubmaster = "Steinklauenlarvenmeister"
	L.tarspitter_grub = "Teerspuckerlarve"
	L.rotdrool_grabber = "Rottspeichelschnapper"
	L.rockbound_trapper = "Steingebundener Fallensteller"
	L.emberhusk_dominator = "Glutpanzerdominator"
end

L = BigWigs:NewBossLocale("Rokmora", "deDE")
if L then
	L.warmup_text = "Rokmora aktiv"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "deDE")
if L then
	L.totems = "Götzen"
end
