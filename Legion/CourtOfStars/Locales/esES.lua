local L = BigWigs:NewBossLocale("Court of Stars Trash", "esES")
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
	L.spyFoundPattern = "Bueno, bueno, no nos precipitemos" -- Bueno, bueno, no nos precipitemos. ¿Y si me acompañas para poder discutirlo en un ambiente más privado...?

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
	L.clue_1_1 = "Dicen que al espía le gusta llevar capa."
	L.clue_1_2 = "Alguien mencionó que el espía llegó antes con una capa."

	-- No Cape
	L.clue_2_1 = "He oído que el espía se dejó la capa en palacio antes de venir aquí."
	L.clue_2_2 = "He oído que al espía no le gustan las capas y se niega a llevar una."

	-- Pouch
	L.clue_3_1 = "Un amigo me ha dicho que al espía le encanta el oro y que lleva una faltriquera llena."
	L.clue_3_2 = "Dicen que la faltriquera del espía está llena de oro para demostrar extravagancia."
	L.clue_3_3 = "He oído que el espía siempre lleva una faltriquera mágica."
	L.clue_3_4 = "Dicen que la faltriquera del espía está rematada con hilos de lujo."

	-- Potions
	L.clue_4_1 = "He oído que el espía ha traído algunas pociones... por si acaso."
	L.clue_4_2 = "Algo me dice que el espía lleva pociones en el cinturón."
	L.clue_4_3 = "He oído que el espía ha traído pociones. Me pregunto por qué."
	L.clue_4_4 = "No te lo he dicho... pero el espía está disfrazado de alquimista y lleva pociones en el cinturón."

	-- Long Sleeves
	L.clue_5_1 = "Al principio de la noche llegué a ver de refilón las mangas largas del espía."
	L.clue_5_2 = "He oído que el espía lleva manga larga esta noche."
	L.clue_5_3 = "Se dice que esta noche el espía cubre sus brazos con mangas largas."
	L.clue_5_4 = "Un amigo me ha dicho que el espía lleva manga larga."

	-- Short Sleeves
	L.clue_6_1 = "He oído que al espía le gusta el aire fresco y que esta noche no lleva manga larga."
	L.clue_6_2 = "Me ha dicho una amiga que ha visto cómo va vestido el espía. No llevaba manga larga."
	L.clue_6_3 = "Me han dicho que el espía odia llevar manga larga."
	L.clue_6_4 = "He oído que el espía lleva manga corta para que sus brazos queden libres."

	-- Gloves
	L.clue_7_1 = "He oído que el espía siempre lleva las manos enfundadas en guantes."
	L.clue_7_2 = "Dicen los rumores que el espía siempre lleva guantes."
	L.clue_7_3 = "Hay quien dice que el espía lleva guantes para ocultar sus notables cicatrices."
	L.clue_7_4 = "He oído que el espía oculta sus manos con cuidado."

	-- No Gloves
	L.clue_8_1 = "Dicen los rumores que el espía nunca lleva guantes."
	L.clue_8_2 = "He oído que al espía no le gusta llevar guantes."
	L.clue_8_3 = "He oído que el espía evita llevar guantes, por si necesita actuar rápido."
	L.clue_8_4 = "Me encontré un par de guantes de más en la habitación trasera. Probablemente el espía se pasee por aquí con las manos desnudas."

	-- Male
	L.clue_9_1 = "Una invitada dice que lo vio entrar en la mansión junto a la Gran Magistrix."
	L.clue_9_2 = "He oído por ahí que el espía no es una mujer."
	L.clue_9_3 = "He oído que el espía está aquí y que es bastante guapo."
	L.clue_9_4 = "Uno de los músicos dice que ese tipo no paraba de hacer preguntas sobre el distrito."

	-- Female
	L.clue_10_1 = "Un invitado las ha visto a ella y a Elisande llegar juntas."
	L.clue_10_2 = "He oído que una mujer no ha parado de hacer preguntas sobre el distrito..."
	L.clue_10_3 = "Hay alguien que dice que nuestro nuevo invitado no es un hombre."
	L.clue_10_4 = "Dicen que la espía está aquí y que es digna de ver."

	-- Light Vest
	L.clue_11_1 = "Definitivamente, el espía prefiere los ropajes de colores claros."
	L.clue_11_2 = "He oído que el espía lleva un jubón más ligero en la fiesta de esta noche."
	L.clue_11_3 = "La gente dice que el espía no lleva un jubón oscuro esta noche."

	-- Dark Vest
	L.clue_12_1 = "He oído que el espía lleva un jubón oscuro intenso esta noche."
	L.clue_12_2 = "Al espía le gusta la ropa de colores oscuros... como la noche."
	L.clue_12_3 = "Dicen los rumores que el espía evita llevar colores claros para ocultarse mejor."
	L.clue_12_4 = "Definitivamente, el espía prefiere la ropa oscura."

	-- No Potions
	L.clue_13_1 = "He oído que el espía no lleva encima ninguna poción."
	L.clue_13_2 = "Un músico me ha dicho que ha visto al espía tirar su última poción y que ya no tiene más."

	-- Book
	L.clue_14_1 = "He oído que el espía siempre lleva un libro de secretos escritos en el cinturón."
	L.clue_14_2 = "Dicen los rumores que al espía le encanta leer y que siempre lleva al menos un libro encima."
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "esES")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
