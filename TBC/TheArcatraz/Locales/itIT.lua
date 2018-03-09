local L = BigWigs:NewBossLocale("Harbinger Skyriss", "itIT")
if not L then return end
if L then
	-- I knew the prince would be angry, but I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael'thas did not send you! Good... I'll just tell the prince you released the prisoners!
	--L.first_cell_trigger = "I have not been myself"
	-- Behold, yet another terrifying creature of incomprehensible power!
	--L.second_and_third_cells_trigger = "of incomprehensible power"
	-- Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!
	--L.fourth_cell_trigger = "Anarchy! Bedlam!"
	-- It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!
	--L.warmup_trigger = "the mighty Legion"

	--L.prison_cell = "Prison Cell"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "itIT")
if L then
	L.entropic_eye = "Occhio Entropico"
	L.sightless_eye = "Occhio Cieco"
	L.soul_eater = "Mangiatore di Anime Eredar"
	L.temptress = "Tentatrice Adirata"
	L.abyssal = "Abissale Gigantesco"
end
