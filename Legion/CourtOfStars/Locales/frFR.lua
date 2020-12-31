local L = BigWigs:NewBossLocale("Court of Stars Trash", "frFR")
if not L then return end
if L then
	L.Guard = "Vigile de la Garde crépusculaire"
	L.Construct = "Assemblage gardien"
	L.Enforcer = "Massacreur gangre-lié"
	L.Hound = "Molosse de la Légion"
	L.Mistress = "Maîtresse de l’ombre"
	L.Gerenth = "Gerenth le Vil"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Savatr’anshé"
	L.Baalgar = "Baalgar le Vigilant"
	L.Inquisitor = "Inquisiteur vigilant"
	L.BlazingImp = "Diablotin flamboyant"
	L.Energy = "Energie liée"
	L.Manifestation = "Manifestation arcanique"
	L.Wyrm = "Wyrm de mana"
	L.Arcanist = "Arcaniste de la Garde crépusculaire"
	L.InfernalImp = "Diablotin infernal"
	L.Malrodi = "Arcaniste Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Clés arcaniques"
	L.clues = "Indices"

	L.InfernalTome = "Tome infernal"
	L.MagicalLantern = "Lanterne magique"
	L.NightshadeRefreshments = "Rafraîchissements de belladone"
	L.StarlightRoseBrew = "Infusion de rose lumétoile"
	L.UmbralBloom = "Floraison ombreuse"
	L.WaterloggedScroll = "Parchemin détrempé"
	L.BazaarGoods = "Marchandises de bazar"
	L.LifesizedNightborneStatue = "Statue de sacrenuit à échelle réelle"
	L.DiscardedJunk = "Camelote abandonnée"
	L.WoundedNightborneCivilian = "Civil sacrenuit blessé"

	L.announce_buff_items = "Annoncer les objets de buff"
	L.announce_buff_items_desc = "Annonce tous les objets de buff disponibles du donjon et qui peut les utiliser."

	L.available = "%s|cffffffff%s|r disponible" -- Context: item is available to use
	L.usableBy = "utilisable par %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Utiliser instantanément les objets de buff"
	L.custom_on_use_buff_items_desc = "Activer cette option pour utiliser instantanément les objets de buff du donjon. Ceci n'utilisera pas les objets qui attirent les gardes avant le 2ème boss."

	L.spy_helper = "Aide évènement espion"
	L.spy_helper_desc = "Affiche une boîte d'info avec tous les indices que votre groupe a récolté concernant l'espion. Les indices seront également envoyés aux membres de votre groupe dans la discussion."

	L.clueFound = "Indice trouvé (%d/5) : |cffffffff%s|r"
	L.spyFound = "Espion trouvé par %s !"
	L.spyFoundChat = "J'ai trouvé l'espion !"
	L.spyFoundPattern = "allez pas trop vite en besogne" -- Allons, [playername]. N’allez pas trop vite en besogne. Et si vous me suiviez, que nous puissions en parler en privé ?

	L.hints = {
		"Cape",
		"Pas de cape",
		"Sacoche",
		"Potions",
		"Manches longues",
		"Manches courtes",
		"Gants",
		"Pas de gants",
		"Homme",
		"Femme",
		"Gilet clair",
		"Gilet sombre",
		"Pas de potions",
		"Livre",
	}

	--[[ !!! IMPORTANT NOTE TO TRANSLATORS !!! ]]--
	--[[ The following translations have to exactly match the gossip text of the Chatty Rumormongers. ]]--

	-- Cape
	L.clue_1_1 = "On dit que la taupe aime porter des capes."
	L.clue_1_2 = "Quelqu’un affirme que la taupe portait une cape lors de son passage ici."

	-- No Cape
	L.clue_2_1 = "J’ai entendu dire que la taupe avait laissé sa cape au palais avant de venir ici."
	L.clue_2_2 = "Il paraît que la taupe n’aime pas les capes et refuse d’en porter."

	-- Pouch
	L.clue_3_1 = "D’après l’un de mes amis, la taupe aime l’or et les sacoches qui en sont pleines."
	L.clue_3_2 = "On raconte que la sacoche de la taupe est pleine d’or. Si ça, ce n’est pas un signe extérieur de richesse…"
	L.clue_3_3 = "On raconte que la taupe ne se sépare jamais de sa sacoche magique."
	L.clue_3_4 = "On raconte que la sacoche de la taupe est bordée d’une élégante broderie."

	-- Potions
	L.clue_4_1 = "J’ai entendu dire que la taupe a apporté quelques potions… au cas où."
	L.clue_4_2 = "La taupe porte des potions à la ceinture. J’en mettrais ma main au feu !"
	L.clue_4_3 = "J’ai entendu dire que la taupe a apporté quelques potions. Je me demande bien pourquoi."
	L.clue_4_4 = "Ça reste entre nous… La taupe se fait passer pour un alchimiste et porte des potions à sa ceinture."

	-- Long Sleeves
	L.clue_5_1 = "J’ai brièvement entraperçu la taupe dans sa tenue à manches longues tout à l’heure."
	L.clue_5_2 = "Il paraît que la taupe porte une tenue à manches longues ce soir."
	L.clue_5_3 = "Quelqu’un m’a dit que les bras de la taupe étaient dissimulés par un habit à manches longues, ce soir."
	L.clue_5_4 = "D’après l’un de mes amis, la taupe porterait un habit à manches longues."

	-- Short Sleeves
	L.clue_6_1 = "Il paraît que la taupe aime sentir la caresse du vent sur sa peau et ne porte pas de manches longues ce soir."
	L.clue_6_2 = "Une de mes amies prétend avoir vu la tenue que porte notre taupe. À l’en croire, ce ne serait pas un habit à manches longues."
	L.clue_6_3 = "Quelqu’un m’a dit que la taupe détestait porter des manches longues."
	L.clue_6_4 = "Il paraît que la taupe porte des manches courtes pour rester plus libre de ses mouvements."

	-- Gloves
	L.clue_7_1 = "On dit que la taupe porte toujours des gants."
	L.clue_7_2 = "Le bruit court que la taupe porte toujours des gants."
	L.clue_7_3 = "On m’a raconté que la taupe portait des gants pour masquer d’affreuses cicatrices."
	L.clue_7_4 = "Il paraît que la taupe prend toujours soin de cacher ses mains."

	-- No Gloves
	L.clue_8_1 = "Le bruit court que la taupe ne porte jamais de gants."
	L.clue_8_2 = "On dit que la taupe déteste porter des gants."
	L.clue_8_3 = "J’ai entendu dire que la taupe évite de porter des gants, de crainte que cela ne nuise à sa dextérité."
	L.clue_8_4 = "Vous savez… J’ai trouvé une paire de gants abandonnée dans l’arrière-salle. Il faut croire que la taupe n’en porte pas."

	-- Male
	L.clue_9_1 = "Une invitée l’aurait vu entrer dans le manoir au côté de la grande magistrice."
	L.clue_9_2 = "À en croire la rumeur, la taupe ne serait pas une espionne."
	L.clue_9_3 = "Il paraît que l’espion est ici et qu’il est fort séduisant, de surcroît."
	L.clue_9_4 = "À en croire l’un des musiciens, il n’arrêtait pas de poser des questions sur le quartier."

	-- Female
	L.clue_10_1 = "Quelqu’un l’a vue arriver en compagnie d’Élisande."
	L.clue_10_2 = "On me dit qu’une femme ne cesse de poser des questions à propos du quartier…"
	L.clue_10_3 = "Le bruit court que notre hôte ne serait pas un homme."
	L.clue_10_4 = "On dit que la taupe est ici et que c’est une vraie beauté."

	-- Light Vest
	L.clue_11_1 = "La taupe préfère les gilets de couleur claire."
	L.clue_11_2 = "Il paraît que la taupe porte un gilet clair ce soir."
	L.clue_11_3 = "On raconte que la taupe ne porte pas de gilet sombre ce soir."

	-- Dark Vest
	L.clue_12_1 = "J’ai entendu dire que la taupe porte un gilet de couleur sombre ce soir."
	L.clue_12_2 = "La taupe préfère les gilets sombres… comme la nuit."
	L.clue_12_3 = "D’après les rumeurs, la taupe évite les tenues de couleur claire pour mieux se fondre dans la masse."
	L.clue_12_4 = "Une chose est sûre, la taupe préfère les vêtements sombres."

	-- No Potions
	L.clue_13_1 = "Il paraît que la taupe ne transporte aucune potion."
	L.clue_13_2 = "Une musicienne m’a dit avoir vu la taupe jeter sa dernière potion. Il semblerait donc qu’il ne lui en reste plus."

	-- Book
	L.clue_14_1 = "Il paraît que la taupe porte toujours un livre des secrets à sa ceinture."
	L.clue_14_2 = "Le bruit court que la taupe adore lire et transporte toujours au moins un livre."
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "frFR")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
