local L = BigWigs:NewBossLocale("Court of Stars Trash", "ruRU")
if not L then return end
if L then
	L.Guard = "Караульный из Сумеречной стражи"
	L.Construct = "Голем-страж"
	L.Enforcer = "Порабощенная Скверной карательница"
	L.Hound = "Гончая Легиона"
	L.Gerenth = "Герент Зловещий"
	L.Jazshariu = "Джазшариу"
	L.Imacutya = "Имаку'туя"
	L.Baalgar = "Баалгар Бдительный "
	L.Inquisitor = "Бдительный инквизитор"
	L.BlazingImp = "Пылающий бес"
	L.Energy = "Обузданная энергия"
	L.Manifestation = "Проявление магии"
	L.Wyrm = "Маназмей"
	L.Arcanist = "Чародей из Сумеречной Стражи"
	L.InfernalImp = "Инфернальный бес"
	L.Malrodi = "Чародей Малроди"
	L.Velimar = "Велимар"
	L.ArcaneKeys = "Чародейский ключ"
	L.clues = "Подсказки"

	L.InfernalTome = "Инфернальный фолиант"
	L.MagicalLantern = "Магический светильник"
	L.NightshadeRefreshments = "Закуски ночной тени"
	L.StarlightRoseBrew = "Отвар из звездной розы"
	L.UmbralBloom = "Теневой цветок"
	L.WaterloggedScroll = "Промокший свиток"
	L.BazaarGoods = "Рыночные товары"
	L.LifesizedNightborneStatue = "Статуя ночнорожденного в натуральную величину"
	L.DiscardedJunk = "Выброшенный хлам"
	L.WoundedNightborneCivilian = "Раненый ночнорожденный"

	L.announce_buff_items = "Объявление о диверсионных механизмах"
	L.announce_buff_items_desc = "Объявляет все доступные в подземелье механизмы для совершения диверсии и кто может их использовать."

	L.available = "Доступен предмет %s|cffffffff%s|r" -- Context: item is available to use
	L.usableBy = "могут использовать %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Автоматически использовать диверсионный механизм"
	L.custom_on_use_buff_items_desc = "Включите эту опцию, чтобы автоматически использовать диверсионные механизмы в подземелье. Эта опция не будет автоматически использовать механизмы, призывающие охранников второго босса."

	L.spy_helper = "Помощник в поиске шпиона"
	L.spy_helper_desc = "Показывает InfoBox Показывает InfoBox со всеми подсказками, которые нашла ваша группа. Подсказки также будут отправлены в групповой чат."

	L.clueFound = "Подсказка найдена (%d/5): |cffffffff%s|r"
	L.spyFound = "Шпион найден игроком %s!"
	L.spyFoundChat = "Шпион найден!"
	L.spyFoundPattern = "Ну-ну" -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	L.hints = {
		"С накидкой",
		"Без накидки",
		"Кошель",
		"Зелья",
		"Длинные рукава",
		"Короткие рукава",
		"В перчатках",
		"Без перчаток",
		"Мужчина",
		"Женщина",
		"Светлый жилет",
		"Темный жилет",
		"Без зелий",
		"Книга",
	}

	--[[ !!! IMPORTANT NOTE TO TRANSLATORS !!! ]]--
	--[[ The following translations have to exactly match the gossip text of the Chatty Rumormongers. ]]--

	-- Cape
	L["Говорят, шпион очень любит носить накидки."] = 1
	L["Кто-то говорил, что у шпиона была на плечах накидка."] = 1

	-- No Cape
	L["Говорят, что накидка шпиона осталась лежать во дворце."] = 2
	L["Говорят, шпион терпеть не может носить накидки."] = 2

	-- Pouch
	L["Мой друг говорил, что шпион просто обожает золото, и поэтому шпионский поясной кошель туго набит золотыми монетами."] = 3
	L["Я слышал, поясной кошель шпиона расшит золотом, чтобы подчеркнуть утонченность."] = 3
	L["Я слышала, поясной кошель шпиона расшит золотом, чтобы подчеркнуть утонченность."] = 3
	L["Я слышал, шпион всегда носит на поясе волшебный кошель."] = 3
	L["Я слышала, шпион всегда носит на поясе волшебный кошель."] = 3
	L["Я слышал, поясной кошель шпиона украшен причудливой вышивкой."] = 3
	L["Я слышала, поясной кошель шпиона украшен причудливой вышивкой."] = 3

	-- Potions
	L["Говорят, у шпиона при себе есть несколько зелий... на всякий случай."] = 4
	L["Я почти уверен, что у шпиона на поясе должны быть флаконы с зельями."] = 4
	L["Я почти уверена, что у шпиона на поясе должны быть флаконы с зельями."] = 4
	L["Говорят, у шпиона при себе есть зелья... интересно, для чего?"] = 4
	L["Я тебе ничего такого не говорил... но шпион присутствует на вечеринке в костюме алхимика. Ищи кого-то с зельями на поясе."] = 4
	L["Я тебе ничего такого не говорила... но шпион присутствует на вечеринке в костюме алхимика. Ищи кого-то с зельями на поясе."] = 4

	-- Long Sleeves
	L["Немногим раньше я видел кое-кого в одежде с длинными рукавами. Наверное, это и был шпион."] = 5
	L["Немногим раньше я видела кое-кого в одежде с длинными рукавами. Наверное, это и был шпион."] = 5
	L["Говорят, этим вечером на шпионе одежда с длинными рукавами."] = 5
	L["Кто-то сказал, что на сегодня шпион носит одежду с длинными рукавами."] = 5
	L["Один мой друг говорил, что шпион носит одежду с длинными рукавами."] = 5

	-- Short Sleeves
	L["Говорят, шпион любит прохладу и поэтому на сегодняшней вечеринке не носит одежду с длинными рукавами."] = 6
	L["Моя подруга как-то обмолвилась, что видела одежду, которую носит шпион. Вроде что-то с короткими рукавами..."] = 6
	L["Мне кто-то говорил, будто шпион терпеть не может одежду с длинными рукавами."] = 6
	L["Я слышал, шпион носит одежду с короткими рукавами, которая не стесняет движений."] = 6
	L["Я слышала, шпион носит одежду с короткими рукавами, которая не стесняет движений."] = 6

	-- Gloves
	L["Я слышал, шпион все время носит перчатки."] = 7
	L["Я слышала, шпион все время носит перчатки."] = 7
	L["Ходят слухи, что шпион все время носит перчатки."] = 7
	L["Кто-то сказал, что у шпиона все руки в шрамах, поэтому бедняге приходится носить перчатки, чтобы скрывать их."] = 7
	L["Я слышал, что шпион старается никому не показывать свои руки."] = 7
	L["Я слышала, что шпион старается никому не показывать свои руки."] = 7

	-- No Gloves
	L["Говорят, что шпион никогда не носит перчаток."] = 8
	L["Я слышал, шпион не любит надевать перчатки."] = 8
	L["Я слышала, шпион не любит надевать перчатки."] = 8
	L["Я слышал, шпион обычно не носит перчаток, чтобы они не сковывали движений при опасности."] = 8
	L["Я слышала, шпион обычно не носит перчаток, чтобы они не сковывали движений при опасности."] = 8
	L["Слушай... Я нашел в задней комнате пару бесхозных перчаток. Вероятно, шпион окажется без перчаток."] = 8
	L["Слушай... Я нашла в задней комнате пару бесхозных перчаток. Вероятно, шпион окажется без перчаток."] = 8

	-- Male
	L["Одна гостья утверждает, что видела, как он входил в особняк вместе с Великим магистром."] = 9
	L["Я где-то слышал, что шпион не женщина."] = 9
	L["Я где-то слышала, что шпион не женщина."] = 9
	L["Я слышал, что шпион уже здесь и он очень хорош собой."] = 9
	L["Я слышала, что шпион уже здесь и он очень хорош собой."] = 9
	L["Кто-то из музыкантов общался со шпионом. И он буквально засыпал бедолагу вопросами про здешний квартал."] = 9

	-- Female
	L["Кто-то из гостей видел ее вместе с Элисандой чуть ли не под ручку."] = 10
	L["Я слышал, что какая-то женщина всех расспрашивала о нашем квартале..."] = 10
	L["Я слышала, что какая-то женщина всех расспрашивала о нашем квартале..."] = 10
	L["Кто-то, кажется, говорил, что наш новый гость – дама."] = 10
	L["Говорят, что шпионка уже здесь и выглядит она просто сногсшибательно."] = 10

	-- Light Vest
	L["Шпион определенно предпочитает жилеты светлых тонов."] = 11
	L["Говорят, на сегодняшней вечеринке шпион носит светлый жилет."] = 11
	L["Говорят, что этим вечером шпион не носит темный жилет."] = 11

	-- Dark Vest
	L["Говорят, шпион носит жилет цвета глубокой ночи."] = 12
	L["Шпион очень любит темные жилеты... цвета ночи."] = 12
	L["По слухам, шпион избегает светлых тонов в одежде, чтобы проще было сливаться с толпой."] = 12
	L["Шпион определенно предпочитает одеваться в темное."] = 12

	-- No Potions
	L["Говорят, что у шпиона нет при себе никаких зелий."] = 13
	L["Музыкантша рассказала мне, что своими глазами видела, как шпион выбрасывает последнее зелье."] = 13

	-- Book
	L["Я слышал, что у шпиона на поясе болтается книжица, в которой записаны шпионские наблюдения."] = 14
	L["Я слышала, что у шпиона на поясе болтается книжица, в которой записаны шпионские наблюдения."] = 14
	L["Ходят слухи, что шпион очень любит читать и носит с собой по меньшей мере одну книгу."] = 14
end

L = BigWigs:NewBossLocale("Rokmora", "deDE")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
