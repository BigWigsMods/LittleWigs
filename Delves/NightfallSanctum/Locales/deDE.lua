local L = BigWigs:NewBossLocale("Speaker Halven", "deDE")
if not L then return end
if L then
	L.speaker_halven = "Sprecherin Halven"
end

L = BigWigs:NewBossLocale("Reformed Fury", "deDE")
if L then
	L.speaker_davenruth = "Sprecher Davenruth"
	L.reformed_fury = "Erneuerter Zorn"
end

L = BigWigs:NewBossLocale("Cult Leaders", "deDE")
if L then
	L.cult_leaders = "Kult Anführer"
	L.inquisitor_speaker = "Inquisitorensprecher"
	L.shadeguard_speaker = "Sprecher der Schattenwache"
end
