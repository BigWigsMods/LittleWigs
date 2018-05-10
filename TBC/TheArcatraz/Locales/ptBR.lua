local L = BigWigs:NewBossLocale("Harbinger Skyriss", "ptBR")
if not L then return end
if L then
	-- I knew the prince would be angry, but I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael'thas did not send you! Good... I'll just tell the prince you released the prisoners!
	L.first_cell_trigger = "Eu não fui eu mesmo"
	-- Behold, yet another terrifying creature of incomprehensible power!
	L.second_and_third_cells_trigger = "de poder incompreensível"
	-- Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!
	L.fourth_cell_trigger = "Anarquia! Tumulto!"
	-- It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!
	L.warmup_trigger = "a poderosa Legião"

	L.prison_cell = "Cela da Prisão"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "ptBR")
if L then
	L.entropic_eye = "Olho Entrópico"
	L.sightless_eye = "Olho Cego"
	L.soul_eater = "Devorador de Almas Eredar"
	L.temptress = "Tentadora Rancorosa"
	L.abyssal = "Abissal Gigantesco"
end
