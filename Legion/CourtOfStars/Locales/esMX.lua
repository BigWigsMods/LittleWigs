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
	L["Escuché que al espía le gusta usar capas."] = 1
	L["Alguien mencionó que el espía pasó por aquí usando una capa."] = 1

	-- No Cape
	L["Oí que el espía dejó la capa en el palacio antes de venir aquí."] = 2
	L["Escuché que el espía odia las capas y se rehúsa a usar una."] = 2

	-- Pouch
	L["Un amigo dijo que al espía le encanta el oro y un bolso lleno de él."] = 3
	L["Oí que la bolsa del cinturón del espía está llena de oro para demostrar su extravagancia."] = 3
	L["Oí que el espía siempre lleva consigo una bolsa mágica."] = 3
	L["Escuché que la bolsa del cinturón del espía tiene un bordado de lujo."] = 3

	-- Potions
	L["Tengo entendido que el espía trajo consigo algunas pociones... por si acaso."] = 4
	L["Tengo la certeza de que el espía tiene pociones en su cinturón."] = 4
	L["Tengo entendido que el espía trajo varias pociones. Me pregunto para qué."] = 4
	L["No te lo dije... pero el espía se disfraza como un alquimista y lleva pociones en su cinturón."] = 4

	-- Long Sleeves
	L["Más temprano pude ver las mangas largas del espía."] = 5
	L["Oí que el traje del espía es de mangas largas esta noche."] = 5
	L["Alguien dijo que el espía cubrirá sus brazos con mangas largas esta noche."] = 5
	L["Un amigo mío mencionó que el espía lleva puestas mangas largas."] = 5

	-- Short Sleeves
	L["Escuché que el espía disfruta del aire fresco y no usará mangas largas esta noche."] = 6
	L["Una amiga me contó que vio el atuendo que llevaba puesto el espía. No usaba mangas largas."] = 6
	L["Alguien me dijo que el espía odia usar mangas largas."] = 6
	L["Tengo entendido que el espía usa mangas cortas para dejar sus brazos al descubierto."] = 6

	-- Gloves
	L["Oí que el espía siempre usa guantes."] = 7
	L["Dicen los rumores que el espía siempre usa guantes."] = 7
	L["Alguien dijo que el espía usa guantes para cubrir cicatrices evidentes."] = 7
	L["Oí que el espía se cubre cuidadosamente las manos."] = 7

	-- No Gloves
	L["Hay un rumor de que el espía nunca usa guantes."] = 8
	L["Oí que al espía no le gusta usar guantes."] = 8
	L["Oí que el espía evita usar guantes, en caso de que tenga que tomar decisiones rápidas."] = 8
	L["Sabes... encontré otro par de guantes en la sala trasera. Seguro que el espía ande por aquí con las manos descubiertas."] = 8

	-- Male
	L["Un invitado dijo que lo vio entrar a la mansión junto con la gran magistrix."] = 9
	L["Oí por ahí que el espía no es mujer."] = 9
	L["Oí que el espía está aquí y que es muy apuesto."] = 9
	L["Uno de los músicos dijo que no dejaba de preguntar sobre el distrito."] = 9

	-- Female
	L["Un invitado la vio a ella y a Elisande llegar juntas hace rato."] = 10
	L["Escuché que una mujer no deja de preguntar sobre el distrito..."] = 10
	L["Alguien anda diciendo que nuestro nuevo huésped no es hombre."] = 10
	L["Dicen que la espía está aquí y que es impresionante."] = 10

	-- Light Vest
	L["El espía definitivamente prefiere los jubones de colores claros."] = 11
	L["Oí que el espía vestirá un jubón de color claro para la fiesta de esta noche."] = 11
	L["La gente dice que el espía no viste un jubón oscuro esta noche."] = 11

	-- Dark Vest
	L["Escuché que el chaleco del espía es de un tono oscuro muy exquisito esta misma noche."] = 12
	L["Al espía le gustan los jubones de colores oscuros... como la noche."] = 12
	L["Dicen los rumores que el espía está evitando usar ropa de colores claros para intentar pasar más desapercibido."] = 12
	L["El espía definitivamente prefiere la ropa oscura."] = 12

	-- No Potions
	L["Oí que el espía no tiene pociones."] = 13
	L["Un músico me dijo que vio al espía tirar su última poción verde y que ya no le quedan más."] = 13

	-- Book
	L["Oí que el espía siempre lleva un libro de secretos en el cinturón."] = 14
	L["Dicen que al espía le encanta leer y siempre lleva al menos un libro."] = 14
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "esMX")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
