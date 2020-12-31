local L = BigWigs:NewBossLocale("Court of Stars Trash", "esMX")
if not L then return end
if L then
	--L.Guard = "Duskwatch Guard"
	--L.Construct = "Guardian Construct"
	--L.Enforcer = "Felbound Enforcer"
	--L.Hound = "Legion Hound"
	L.Mistress = "Señora de las Sombras"
	--L.Gerenth = "Gerenth the Vile"
	--L.Jazshariu = "Jazshariu"
	--L.Imacutya = "Imacutya"
	--L.Baalgar = "Baalgar the Watchful"
	--L.Inquisitor = "Watchful Inquisitor"
	--L.BlazingImp = "Blazing Imp"
	--L.Energy = "Bound Energy"
	--L.Manifestation = "Arcane Manifestation"
	--L.Wyrm = "Mana Wyrm"
	--L.Arcanist = "Duskwatch Arcanist"
	--L.InfernalImp = "Infernal Imp"
	--L.Malrodi = "Arcanist Malrodi"
	--L.Velimar = "Velimar"
	--L.ArcaneKeys = "Arcane Keys"
	--L.clues = "Clues"

	--L.InfernalTome = "Infernal Tome"
	--L.MagicalLantern = "Magical Lantern"
	--L.NightshadeRefreshments = "Nightshade Refreshments"
	--L.StarlightRoseBrew = "Starlight Rose Brew"
	--L.UmbralBloom = "Umbral Bloom"
	--L.WaterloggedScroll = "Waterlogged Scroll"
	--L.BazaarGoods = "Bazaar Goods"
	--L.LifesizedNightborneStatue = "Lifesized Nightborne Statue"
	--L.DiscardedJunk = "Discarded Junk"
	--L.WoundedNightborneCivilian = "Wounded Nightborne Civilian"

	--L.announce_buff_items = "Announce buff items"
	--L.announce_buff_items_desc = "Anounces all available buff items around the dungeon and who is able to use them."

	--L.available = "%s|cffffffff%s|r available" -- Context: item is available to use
	--L.usableBy = "usable by %s" -- Context: item is usable by someone

	--L.custom_on_use_buff_items = "Instantly use buff items"
	--L.custom_on_use_buff_items_desc = "Enable this options to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss."

	--L.spy_helper = "Spy Event Helper"
	--L.spy_helper_desc = "Shows an InfoBox with all clues your group gathered about the spy. The clues will also be send to your party members in chat."

	--L.clueFound = "Clue found (%d/5): |cffffffff%s|r"
	--L.spyFound = "Spy found by %s!"
	--L.spyFoundChat = "I found the spy!"
	L.spyFoundPattern = "Calma, no nos apuremos" -- Calma, no nos apuremos, [playername]. Mejor sígueme y hablemos de esto en un lugar algo más privado…

	--L.hints = {
	--	"Cape",
	--	"No Cape",
	--	"Pouch",
	--	"Potions",
	--	"Long Sleeves",
	--	"Short Sleeves",
	--	"Gloves",
	--	"No Gloves",
	--	"Male",
	--	"Female",
	--	"Light Vest",
	--	"Dark Vest",
	--	"No Potions",
	--	"Book",
	--}

	--[[ !!! IMPORTANT NOTE TO TRANSLATORS !!! ]]--
	--[[ The following translations have to exactly match the gossip text of the Chatty Rumormongers. ]]--

	-- Cape
	L.clue_1_1 = "Escuché que al espía le gusta usar capas."
	L.clue_1_2 = "Alguien mencionó que el espía pasó por aquí usando una capa."

	-- No Cape
	L.clue_2_1 = "Oí que el espía dejó la capa en el palacio antes de venir aquí."
	L.clue_2_2 = "Escuché que el espía odia las capas y se rehúsa a usar una."

	-- Pouch
	L.clue_3_1 = "Un amigo dijo que al espía le encanta el oro y un bolso lleno de él."
	L.clue_3_2 = "Oí que la bolsa del cinturón del espía está llena de oro para demostrar su extravagancia."
	L.clue_3_3 = "Oí que el espía siempre lleva consigo una bolsa mágica."
	L.clue_3_4 = "Escuché que la bolsa del cinturón del espía tiene un bordado de lujo."

	-- Potions
	L.clue_4_1 = "Tengo entendido que el espía trajo consigo algunas pociones... por si acaso."
	L.clue_4_2 = "Tengo la certeza de que el espía tiene pociones en su cinturón."
	L.clue_4_3 = "Tengo entendido que el espía trajo varias pociones. Me pregunto para qué."
	L.clue_4_4 = "No te lo dije... pero el espía se disfraza como un alquimista y lleva pociones en su cinturón."

	-- Long Sleeves
	L.clue_5_1 = "Más temprano pude ver las mangas largas del espía."
	L.clue_5_2 = "Oí que el traje del espía es de mangas largas esta noche."
	L.clue_5_3 = "Alguien dijo que el espía cubrirá sus brazos con mangas largas esta noche."
	L.clue_5_4 = "Un amigo mío mencionó que el espía lleva puestas mangas largas."

	-- Short Sleeves
	L.clue_6_1 = "Escuché que el espía disfruta del aire fresco y no usará mangas largas esta noche."
	L.clue_6_2 = "Una amiga me contó que vio el atuendo que llevaba puesto el espía. No usaba mangas largas."
	L.clue_6_3 = "Alguien me dijo que el espía odia usar mangas largas."
	L.clue_6_4 = "Tengo entendido que el espía usa mangas cortas para dejar sus brazos al descubierto."

	-- Gloves
	L.clue_7_1 = "Oí que el espía siempre usa guantes."
	L.clue_7_2 = "Dicen los rumores que el espía siempre usa guantes."
	L.clue_7_3 = "Alguien dijo que el espía usa guantes para cubrir cicatrices evidentes."
	L.clue_7_4 = "Oí que el espía se cubre cuidadosamente las manos."

	-- No Gloves
	L.clue_8_1 = "Hay un rumor de que el espía nunca usa guantes."
	L.clue_8_2 = "Oí que al espía no le gusta usar guantes."
	L.clue_8_3 = "Oí que el espía evita usar guantes, en caso de que tenga que tomar decisiones rápidas."
	L.clue_8_4 = "Sabes... encontré otro par de guantes en la sala trasera. Seguro que el espía ande por aquí con las manos descubiertas."

	-- Male
	L.clue_9_1 = "Un invitado dijo que lo vio entrar a la mansión junto con la gran magistrix."
	L.clue_9_2 = "Oí por ahí que el espía no es mujer."
	L.clue_9_3 = "Oí que el espía está aquí y que es muy apuesto."
	L.clue_9_4 = "Uno de los músicos dijo que no dejaba de preguntar sobre el distrito."

	-- Female
	L.clue_10_1 = "Un invitado la vio a ella y a Elisande llegar juntas hace rato."
	L.clue_10_2 = "Escuché que una mujer no deja de preguntar sobre el distrito..."
	L.clue_10_3 = "Alguien anda diciendo que nuestro nuevo huésped no es hombre."
	L.clue_10_4 = "Dicen que la espía está aquí y que es impresionante."

	-- Light Vest
	L.clue_11_1 = "El espía definitivamente prefiere los jubones de colores claros."
	L.clue_11_2 = "Oí que el espía vestirá un jubón de color claro para la fiesta de esta noche."
	L.clue_11_3 = "La gente dice que el espía no viste un jubón oscuro esta noche."

	-- Dark Vest
	L.clue_12_1 = "Escuché que el chaleco del espía es de un tono oscuro muy exquisito esta misma noche."
	L.clue_12_2 = "Al espía le gustan los jubones de colores oscuros... como la noche."
	L.clue_12_3 = "Dicen los rumores que el espía está evitando usar ropa de colores claros para intentar pasar más desapercibido."
	L.clue_12_4 = "El espía definitivamente prefiere la ropa oscura."

	-- No Potions
	L.clue_13_1 = "Oí que el espía no tiene pociones."
	L.clue_13_2 = "Un músico me dijo que vio al espía tirar su última poción verde y que ya no le quedan más."

	-- Book
	L.clue_14_1 = "Oí que el espía siempre lleva un libro de secretos en el cinturón."
	L.clue_14_2 = "Dicen que al espía le encanta leer y siempre lleva al menos un libro."
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "esMX")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
