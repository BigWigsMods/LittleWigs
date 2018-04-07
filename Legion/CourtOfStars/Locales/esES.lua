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
	L["Dicen que al espía le gusta llevar capa."] = 1
	L["Alguien mencionó que el espía llegó antes con una capa."] = 1

	-- No Cape
	L["He oído que el espía se dejó la capa en palacio antes de venir aquí."] = 2
	L["He oído que al espía no le gustan las capas y se niega a llevar una."] = 2

	-- Pouch
	L["Un amigo me ha dicho que al espía le encanta el oro y que lleva una faltriquera llena."] = 3
	L["Dicen que la faltriquera del espía está llena de oro para demostrar extravagancia."] = 3
	L["He oído que el espía siempre lleva una faltriquera mágica."] = 3
	L["Dicen que la faltriquera del espía está rematada con hilos de lujo."] = 3

	-- Potions
	L["He oído que el espía ha traído algunas pociones... por si acaso."] = 4
	L["Algo me dice que el espía lleva pociones en el cinturón."] = 4
	L["He oído que el espía ha traído pociones. Me pregunto por qué."] = 4
	L["No te lo he dicho... pero el espía está disfrazado de alquimista y lleva pociones en el cinturón."] = 4

	-- Long Sleeves
	L["Al principio de la noche llegué a ver de refilón las mangas largas del espía."] = 5
	L["He oído que el espía lleva manga larga esta noche."] = 5
	L["Se dice que esta noche el espía cubre sus brazos con mangas largas."] = 5
	L["Un amigo me ha dicho que el espía lleva manga larga."] = 5

	-- Short Sleeves
	L["He oído que al espía le gusta el aire fresco y que esta noche no lleva manga larga."] = 6
	L["Me ha dicho una amiga que ha visto cómo va vestido el espía. No llevaba manga larga."] = 6
	L["Me han dicho que el espía odia llevar manga larga."] = 6
	L["He oído que el espía lleva manga corta para que sus brazos queden libres."] = 6

	-- Gloves
	L["He oído que el espía siempre lleva las manos enfundadas en guantes."] = 7
	L["Dicen los rumores que el espía siempre lleva guantes."] = 7
	L["Hay quien dice que el espía lleva guantes para ocultar sus notables cicatrices."] = 7
	L["He oído que el espía oculta sus manos con cuidado."] = 7

	-- No Gloves
	L["Dicen los rumores que el espía nunca lleva guantes."] = 8
	L["He oído que al espía no le gusta llevar guantes."] = 8
	L["He oído que el espía evita llevar guantes, por si necesita actuar rápido."] = 8
	L["Me encontré un par de guantes de más en la habitación trasera. Probablemente el espía se pasee por aquí con las manos desnudas."] = 8

	-- Male
	L["Una invitada dice que lo vio entrar en la mansión junto a la Gran Magistrix."] = 9
	L["He oído por ahí que el espía no es una mujer."] = 9
	L["He oído que el espía está aquí y que es bastante guapo."] = 9
	L["Uno de los músicos dice que ese tipo no paraba de hacer preguntas sobre el distrito."] = 9

	-- Female
	L["Un invitado las ha visto a ella y a Elisande llegar juntas."] = 10
	L["He oído que una mujer no ha parado de hacer preguntas sobre el distrito..."] = 10
	L["Hay alguien que dice que nuestro nuevo invitado no es un hombre."] = 10
	L["Dicen que la espía está aquí y que es digna de ver."] = 10

	-- Light Vest
	L["Definitivamente, el espía prefiere los ropajes de colores claros."] = 11
	L["He oído que el espía lleva un jubón más ligero en la fiesta de esta noche."] = 11
	L["La gente dice que el espía no lleva un jubón oscuro esta noche."] = 11

	-- Dark Vest
	L["He oído que el espía lleva un jubón oscuro intenso esta noche."] = 12
	L["Al espía le gusta la ropa de colores oscuros... como la noche."] = 12
	L["Dicen los rumores que el espía evita llevar colores claros para ocultarse mejor."] = 12
	L["Definitivamente, el espía prefiere la ropa oscura."] = 12

	-- No Potions
	L["He oído que el espía no lleva encima ninguna poción."] = 13
	L["Un músico me ha dicho que ha visto al espía tirar su última poción y que ya no tiene más."] = 13

	-- Book
	L["He oído que el espía siempre lleva un libro de secretos escritos en el cinturón."] = 14
	L["Dicen los rumores que al espía le encanta leer y que siempre lleva al menos un libro encima."] = 14
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "esES")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
