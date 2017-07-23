local L = BigWigs:NewBossLocale("Court of Stars Trash", "frFR")
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
	L.spyFoundPattern = "allez pas trop vite en besogne" -- Allons, [playername]. N’allez pas trop vite en besogne. Et si vous me suiviez, que nous puissions en parler en privé ?

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
	L["On dit que la taupe aime porter des capes."] = 1
	L["Quelqu’un affirme que la taupe portait une cape lors de son passage ici."] = 1

	-- No Cape
	L["J’ai entendu dire que la taupe avait laissé sa cape au palais avant de venir ici."] = 2
	L["Il paraît que la taupe n’aime pas les capes et refuse d’en porter."] = 2

	-- Pouch
	L["D’après l’un de mes amis, la taupe aime l’or et les sacoches qui en sont pleines."] = 3
	--L["I heard the spy's belt pouch is filled with gold to show off extravagance."] = 3
	--L["I heard the spy carries a magical pouch around at all times."] = 3
	--L["I heard the spy's belt pouch is lined with fancy threading."] = 3

	-- Potions
	--L["I heard the spy brought along some potions... just in case."] = 4
	--L["I'm pretty sure the spy has potions at the belt."] = 4
	--L["I heard the spy brought along potions, I wonder why?"] = 4
	--L["I didn't tell you this... but the spy is masquerading as an alchemist and carrying potions at the belt."] = 4

	-- Long Sleeves
	L["J’ai brièvement entraperçu la taupe dans sa tenue à manches longues tout à l’heure."] = 5
	L["Il paraît que la taupe porte une tenue à manches longues ce soir."] = 5
	L["Quelqu’un m’a dit que les bras de la taupe étaient dissimulés par un habit à manches longues, ce soir."] = 5
	L["D’après l’un de mes amis, la taupe porterait un habit à manches longues."] = 5

	-- Short Sleeves
	L["Il paraît que la taupe aime sentir la caresse du vent sur sa peau et ne porte pas de manches longues ce soir."] = 6
	L["Une de mes amies prétend avoir vu la tenue que porte notre taupe. À l’en croire, ce ne serait pas un habit à manches longues."] = 6
	L["Quelqu’un m’a dit que la taupe détestait porter des manches longues."] = 6
	L["Il paraît que la taupe porte des manches courtes pour rester plus libre de ses mouvements."] = 6

	-- Gloves
	--L["I heard the spy always dons gloves."] = 7
	L["Le bruit court que la taupe porte toujours des gants."] = 7
	--L["Someone said the spy wears gloves to cover obvious scars."] = 7
	--L["I heard the spy carefully hides their hands."] = 7

	-- No Gloves
	L["Le bruit court que la taupe ne porte jamais de gants."] = 8
	L["On dit que la taupe déteste porter des gants."] = 8
	L["J’ai entendu dire que la taupe évite de porter des gants, de crainte que cela ne nuise à sa dextérité."] = 8
	L["Vous savez… J’ai trouvé une paire de gants abandonnée dans l’arrière-salle. Il faut croire que la taupe n’en porte pas."] = 8

	-- Male
	L["Une invitée l’aurait vu entrer dans le manoir au côté de la grande magistrice."] = 9
	L["À en croire la rumeur, la taupe ne serait pas une espionne."] = 9
	L["Il paraît que l’espion est ici et qu’il est fort séduisant, de surcroît."] = 9
	L["À en croire l’un des musiciens, il n’arrêtait pas de poser des questions sur le quartier."] = 9

	-- Female
	L["Quelqu’un l’a vue arriver en compagnie d’Élisande."] = 10
	L["On me dit qu’une femme ne cesse de poser des questions à propos du quartier…"] = 10
	L["Le bruit court que notre hôte ne serait pas un homme."] = 10
	L["On dit que la taupe est ici et que c’est une vraie beauté."] = 10

	-- Light Vest
	L["La taupe préfère les gilets de couleur claire."] = 11
	L["Il paraît que la taupe porte un gilet clair ce soir."] = 11
	L["On raconte que la taupe ne porte pas de gilet sombre ce soir."] = 11

	-- Dark Vest
	--L["I heard the spy's vest is a dark, rich shade this very night."] = 12
	--L["The spy enjoys darker colored vests... like the night."] = 12
	--L["Rumor has it the spy is avoiding light colored clothing to try and blend in more."] = 12
	--L["The spy definitely prefers darker clothing."] = 12

	-- No Potions
	--L["I heard the spy is not carrying any potions around."] = 13
	--L["A musician told me she saw the spy throw away their last potion and no longer has any left."] = 13

	-- Book
	L["Il paraît que la taupe porte toujours un livre des secrets à sa ceinture."] = 14
	L["Le bruit court que la taupe adore lire et transporte toujours au moins un livre."] = 14
end
