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
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "frFR")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
