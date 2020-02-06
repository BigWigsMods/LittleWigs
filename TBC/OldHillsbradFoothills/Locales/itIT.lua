local L = BigWigs:NewBossLocale("Old Hillsbrad Foothills Trash", "itIT")
if not L then return end
if L then
	-- L.custom_on_autotalk = "Autotalk"
	-- L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."

	-- L.incendiary_bombs = "Incendiary Bombs"
	-- L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
end

L = BigWigs:NewBossLocale("Lieutenant Drake", "itIT")
if L then
	-- You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!
	-- L.warmup_trigger = "fetch water"
end

L = BigWigs:NewBossLocale("Captain Skarloc", "itIT")
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	-- L.warmup_trigger = "answer to Blackmoore"
end

L = BigWigs:NewBossLocale("Epoch Hunter", "itIT")
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	-- L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	-- L.boss_warmup_trigger = "very existence!"
end
