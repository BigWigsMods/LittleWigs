local L = BigWigs:NewBossLocale("Harbinger Skyriss", "deDE")
if not L then return end
if L then
	-- I knew the prince would be angry, but I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael'thas did not send you! Good... I'll just tell the prince you released the prisoners!
	L.first_cell_trigger = "ich war nicht ich selbst"
	-- Behold, yet another terrifying creature of incomprehensible power!
	L.second_and_third_cells_trigger = "von unfassbarer Macht"
	-- Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!
	L.fourth_cell_trigger = "Anarchie! Chaos!"
	-- It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!
	L.warmup_trigger = "die mächtige Legion"

	L.prison_cell = "Gefängniszelle"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "deDE")
if L then
	L.entropic_eye = "Entropisches Auge"
	L.sightless_eye = "Blindes Auge"
	L.soul_eater = "Seelenfresser der Eredar"
	L.temptress = "Boshafte Verführerin"
	L.abyssal = "Riesengroßer Abyss"
end
