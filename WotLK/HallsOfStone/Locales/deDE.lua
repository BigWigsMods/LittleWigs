local L = BigWigs:NewBossLocale("Tribunal of Ages", "deDE")
if not L then return end
if L then
	L.engage_trigger = "Haltet jetzt die Augen offen" -- Now keep an eye out! I'll have this licked in two shakes of a--
	L.defeat_trigger = "Die alten, magischen Finger" --  Ha! The old magic fingers finally won through! Now let's get down to--
	L.fail_trigger = "Noch nicht... noch nich--"

	L.timers = "Timer"
	L.timers_desc = "Timer für diverse eintretende Ereignisse."

	L.victory = "Sieg"
end
