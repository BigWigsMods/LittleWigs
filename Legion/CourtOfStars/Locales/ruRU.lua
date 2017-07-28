local L = BigWigs:NewBossLocale("Court of Stars Trash", "ruRU")
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
	--	"С накидкой",
	--	"Без накидки",
	--	"Кошель",
	--	"Зелья",
	--	"Длинные рукава",
	--	"Короткие рукава",
	--	"В перчатках",
	--	"Без перчаток",
	--	"Мужчина",
	--	"Женщина",
	--	"Светлый жилет",
	--	"Темный жилет",
	--	"Без зелий",
	--	"Книга",
	--}

	--[[ !!! IMPORTANT NOTE TO TRANSLATORS !!! ]]--
	--[[ The following translations have to exactly match the gossip text of the Chatty Rumormongers. ]]--

	-- Cape
	--L["Говорят, шпион очень любит носить накидки."] = 1
	--L["Кто-то говорил, что у шпиона была на плечах накидка."] = 1

	-- No Cape
	--L["Говорят, что накидка шпиона осталась лежать во дворце."] = 2
	--L["Говорят, шпион терпеть не может носить накидки."] = 2

	-- Pouch
	--L["Мой друг говорил, что шпион просто обожает золото, и поэтому шпионский поясной кошель туго набит золотыми монетами."] = 3
	--L["Я слышал, поясной кошель шпиона расшит золотом, чтобы подчеркнуть утонченность."] = 3
	--L["Я слышал, шпион всегда носит на поясе волшебный кошель."] = 3
	--L["Я слышал, поясной кошель шпиона украшен причудливой вышивкой."] = 3

	-- Potions
	--L["Говорят, у шпиона при себе есть несколько зелий... на всякий случай."] = 4
	--L["Я почти уверена, что у шпиона на поясе должны быть флаконы с зельями."] = 4
	--L["Говорят, у шпиона при себе есть зелья... интересно, для чего?"] = 4
	--L["Я тебе ничего такого не говорила... но шпион присутствует на вечеринке в костюме алхимика. Ищи кого-то с зельями на поясе."] = 4

	-- Long Sleeves
	--L["Немногим раньше я видел кое-кого в одежде с длинными рукавами. Наверное, это и был шпион."] = 5
	--L["Говорят, этим вечером на шпионе одежда с длинными рукавами."] = 5
	--L["Кто-то сказал, что на сегодня шпион носит одежду с длинными рукавами."] = 5
	--L["Один мой друг говорил, что шпион носит одежду с длинными рукавами."] = 5

	-- Short Sleeves
	--L["Говорят, шпион любит прохладу и поэтому на сегодняшней вечеринке не носит одежду с длинными рукавами."] = 6
	--L["Моя подруга как-то обмолвилась, что видела одежду, которую носит шпион. Вроде что-то с короткими рукавами..."] = 6
	--L["Мне кто-то говорил, будто шпион терпеть не может одежду с длинными рукавами."] = 6
	--L["Я слышал, шпион носит одежду с короткими рукавами, которая не стесняет движений."] = 6

	-- Gloves
	--L["Я слышал, шпион все время носит перчатки."] = 7
	--L["Ходят слухи, что шпион все время носит перчатки."] = 7
	--L["Кто-то сказал, что у шпиона все руки в шрамах, поэтому бедняге приходится носить перчатки, чтобы скрывать их."] = 7
	--L["Я слышал, что шпион старается никому не показывать свои руки."] = 7

	-- No Gloves
	--L["Говорят, что шпион никогда не носит перчаток."] = 8
	--L["Я слышал, шпион не любит надевать перчатки."] = 8
	--L["Я слышал, шпион обычно не носит перчаток, чтобы они не сковывали движений при опасности."] = 8
	--L["Слушай... Я нашел в задней комнате пару бесхозных перчаток. Вероятно, шпион окажется без перчаток."] = 8

	-- Male
	--L["Одна гостья утверждает, что видела, как он входил в особняк вместе с Великим магистром."] = 9
	--L["Я где-то слышал, что шпион не женщина."] = 9
	--L["Я слышал, что шпион уже здесь и он очень хорош собой."] = 9
	--L["Кто-то из музыкантов общался со шпионом. И он буквально засыпал бедолагу вопросами про здешний квартал."] = 9

	-- Female
	--L["Кто-то из гостей видел ее вместе с Элисандой чуть ли не под ручку."] = 10
	--L["Я слышал, что какая-то женщина всех расспрашивала о нашем квартале..."] = 10
	--L["Кто-то, кажется, говорил, что наш новый гость – дама."] = 10
	--L["Говорят, что шпионка уже здесь и выглядит она просто сногсшибательно."] = 10

	-- Light Vest
	--L["Шпион определенно предпочитает жилеты светлых тонов."] = 11
	--L["Говорят, на сегодняшней вечеринке шпион носит светлый жилет."] = 11
	--L["Говорят, что этим вечером шпион не носит темный жилет."] = 11

	-- Dark Vest
	--L["Говорят, шпион носит жилет цвета глубокой ночи."] = 12
	--L["Шпион очень любит темные жилеты... цвета ночи."] = 12
	--L["По слухам, шпион избегает светлых тонов в одежде, чтобы проще было сливаться с толпой."] = 12
	--L["Шпион определенно предпочитает одеваться в темное."] = 12

	-- No Potions
	--L["Говорят, что у шпиона нет при себе никаких зелий."] = 13
	--L["Музыкантша рассказала мне, что своими глазами видела, как шпион выбрасывает последнее зелье."] = 13

	-- Book
	--L["Я слышал, что у шпиона на поясе болтается книжица, в которой записаны шпионские наблюдения."] = 14
	--L["Ходят слухи, что шпион очень любит читать и носит с собой по меньшей мере одну книгу."] = 14
end
