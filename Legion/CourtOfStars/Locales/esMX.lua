local L = BigWigs:NewBossLocale("Court of Stars Trash", "esMX")
if not L then return end
if L then
	--L.Guard = "Duskwatch Guard"
	--L.Construct = "Guardian Construct"
	--L.Enforcer = "Felbound Enforcer"
	--L.Hound = "Legion Hound"
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
	--L.usableBy = "usable by" -- Context: item is usable by someone

	--L.custom_on_use_buff_items = "Instantly use buff items"
	--L.custom_on_use_buff_items_desc = "Enable this options to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss."

	--L.spy_helper = "Spy Event Helper"
	--L.spy_helper_desc = "Shows an InfoBox with all clues your group gathered about the spy. The clues will also be send to your party members in chat."

	--L.clueFound = "Clue found (%d/5): |cffffffff%s|r"
	--L.spyFound = "Spy found by %s!"
	--L.spyFoundChat = "I found the spy!"
	--L.spyFoundPattern = "Now now, let's not be hasty" -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

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
	--L["I heard the spy enjoys wearing capes."] = 1
	--L["Someone mentioned the spy came in earlier wearing a cape."] = 1

	-- No Cape
	L["Oí que el espía dejó la capa en el palacio antes de venir aquí."] = 2
	L["Escuché que el espía odia las capas y se rehúsa a usar una."] = 2

	-- Pouch
	L["Un amigo dijo que al espía le encanta el oro y un bolso lleno de él."] = 3
	L["Oí que la bolsa del cinturón del espía está llena de oro para demostrar su extravagancia."] = 3
	L["Oí que el espía siempre lleva consigo una bolsa mágica."] = 3
	L["Escuché que la bolsa del cinturón del espía tiene un bordado de lujo."] = 3

	-- Potions
	--L["I heard the spy brought along some potions... just in case."] = 4
	--L["I'm pretty sure the spy has potions at the belt."] = 4
	--L["I heard the spy brought along potions, I wonder why?"] = 4
	--L["I didn't tell you this... but the spy is masquerading as an alchemist and carrying potions at the belt."] = 4

	-- Long Sleeves
	L["Más temprano pude ver las mangas largas del espía."] = 5
	L["Oí que el traje del espía es de mangas largas esta noche."] = 5
	L["Alguien dijo que el espía cubrirá sus brazos con mangas largas esta noche."] = 5
	L["Un amigo mío mencionó que el espía lleva puestas mangas largas."] = 5

	-- Short Sleeves
	--L["I heard the spy enjoys the cool air and is not wearing long sleeves tonight."] = 6
	--L["A friend of mine said she saw the outfit the spy was wearing. It did not have long sleeves."] = 6
	--L["Someone told me the spy hates wearing long sleeves."] = 6
	--L["I heard the spy wears short sleeves to keep their arms unencumbered."] = 6

	-- Gloves
	--L["I heard the spy always dons gloves."] = 7
	--L["There's a rumor that the spy always wears gloves."] = 7
	--L["Someone said the spy wears gloves to cover obvious scars."] = 7
	--L["I heard the spy carefully hides their hands."] = 7

	-- No Gloves
	L["Hay un rumor de que el espía nunca usa guantes."] = 8
	L["Oí que al espía no le gusta usar guantes."] = 8
	L["Oí que el espía evita usar guantes, en caso de que tenga que tomar decisiones rápidas."] = 8
	L["Sabes... encontré otro par de guantes en la sala trasera. Seguro que el espía ande por aquí con las manos descubiertas."] = 8

	-- Male
	--L["A guest said she saw him entering the manor alongside the Grand Magistrix."] = 9
	--L["I heard somewhere that the spy isn't female."] = 9
	--L["I heard the spy is here and he's very good looking."] = 9
	--L["One of the musicians said he would not stop asking questions about the district."] = 9

	-- Female
	L["Un invitado la vio a ella y a Elisande llegar juntas hace rato."] = 10
	L["Escuché que una mujer no deja de preguntar sobre el distrito..."] = 10
	L["Alguien anda diciendo que nuestro nuevo huésped no es hombre."] = 10
	L["Dicen que la espía está aquí y que es impresionante."] = 10

	-- Light Vest
	--L["The spy definitely prefers the style of light colored vests."] = 11
	--L["I heard that the spy is wearing a lighter vest to tonight's party."] = 11
	--L["People are saying the spy is not wearing a darker vest tonight."] = 11

	-- Dark Vest
	--L["I heard the spy's vest is a dark, rich shade this very night."] = 12
	--L["The spy enjoys darker colored vests... like the night."] = 12
	--L["Rumor has it the spy is avoiding light colored clothing to try and blend in more."] = 12
	--L["The spy definitely prefers darker clothing."] = 12

	-- No Potions
	--L["I heard the spy is not carrying any potions around."] = 13
	--L["A musician told me she saw the spy throw away their last potion and no longer has any left."] = 13

	-- Book
	--L["I heard the spy always has a book of written secrets at the belt."] = 14
	--L["Rumor has is the spy loves to read and always carries around at least one book."] = 14
end
