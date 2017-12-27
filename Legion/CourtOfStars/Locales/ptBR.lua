local L = BigWigs:NewBossLocale("Court of Stars Trash", "ptBR")
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
	--L.usableBy = "usable by %s" -- Context: item is usable by someone

	--L.custom_on_use_buff_items = "Instantly use buff items"
	--L.custom_on_use_buff_items_desc = "Enable this options to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss."

	--L.spy_helper = "Spy Event Helper"
	--L.spy_helper_desc = "Shows an InfoBox with all clues your group gathered about the spy. The clues will also be send to your party members in chat."

	--L.clueFound = "Clue found (%d/5): |cffffffff%s|r"
	--L.spyFound = "Spy found by %s!"
	--L.spyFoundChat = "I found the spy!"
	L.spyFoundPattern = "Ora, ora, não sejamos apressados" -- Ora, ora, não sejamos apressados, [playername]. Que tal me seguir e conversar em um local mais reservado...

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
	L["Ouvi dizer que o espião gosta de usar capas."] = 1
	L["Alguém falou que o espião chegou mais cedo usando uma capa."] = 1

	-- No Cape
	L["Ouvi dizer que o espião deixou a capa no palácio antes de vir pra cá."] = 2
	L["Ouvi dizer que o espião não gosta de capas e se recusa a usar uma."] = 2

	-- Pouch
	L["Um amigo disse que o espião ama ouro e uma pochete bem cheia disso."] = 3
	L["Ouvi dizer que a pochete do espião está cheia de ouro para mostrar extravagância."] = 3
	L["Ouvi dizer que o espião sempre anda com uma bolsa mágica."] = 3
	L["Ouvi dizer que a pochete do espião é forrada com fios finos."] = 3

	-- Potions
	L["Disseram que o espião trouxe algumas poções... só por garantia."] = 4
	L["Tenho certeza de que o espião tem poções no cinto."] = 4
	L["Disseram que o espião trouxe poções, por que será?"] = 4
	L["Eu não lhe disse nada... mas o espião está disfarçado de alquimista, carregando poções no cinto."] = 4

	-- Long Sleeves
	L["Eu mal consegui espiar as mangas compridas do espião."] = 5
	L["Ouvi dizer que a roupa do espião é de manga comprida."] = 5
	L["Alguém me disse que o espião está cobrindo os braços com mangas compridas."] = 5
	L["Um amigo meu disse que o espião está de mangas compridas."] = 5

	-- Short Sleeves
	L["Ouvi dizer que o espião gosta de ar fresco e não está usando mangas compridas."] = 6
	L["Uma amiga minha disse que viu a roupa espião. Não tinha mangas longas."] = 6
	L["Alguém me disse que o espião odeia mangas compridas."] = 6
	L["Dizem que o espião usa mangas curtas para manter os braços livres."] = 6

	-- Gloves
	L["Ouvi dizer que o espião sempre usa luvas."] = 7
	L["Corre um boato de que o espião sempre usa luvas."] = 7
	L["Alguém disse que o espião usa luvas para esconder cicatrizes."] = 7
	L["Dizem que o espião fica escondendo as mãos."] = 7

	-- No Gloves
	L["Estão dizendo que o espião nunca usa luvas."] = 8
	L["Ouvi dizer que o espião não gosta de usar luvas."] = 8
	L["Estão dizendo que o espião evita usar luvas, para o caso de precisar agir rapidamente."] = 8
	L["Sabe de uma coisa... Encontrei um par de luvas lá atrás. Imagino que o espião esteja por aí de mãos nuas."] = 8

	-- Male
	L["Um convidado disse que o viu entrando na mansão ao lado da Grã-magistra."] = 9
	L["Ouvi dizer por aí que o espião não é uma mulher."] = 9
	L["Ouvi dizer que o espião está aqui e é muito bonito."] = 9
	L["Um dos músicos disse que ele não parava de perguntar sobre o distrito."] = 9

	-- Female
	L["Um convidado viu ela e Elisande chegarem juntas."] = 10
	L["Ouvi falar que uma mulher está fazendo várias perguntas sobre o distrito..."] = 10
	L["Tem gente dizendo que é uma nova convidada, e não convidado."] = 10
	L["Dizem que a espiã está aqui e que ela é um colírio para os olhos."] = 10

	-- Light Vest
	L["O espião definitivamente prefere coletes de cor clara."] = 11
	L["Ouvi dizer que o espião está usando um colete claro."] = 11
	L["Estão dizendo que o espião não está usando colete escuro hoje."] = 11

	-- Dark Vest
	L["Ouvi dizer que as vestes do espião têm um tom escuro e rico esta noite."] = 12
	L["O espião gosta de coletes escuros... como a noite."] = 12
	L["Corre um boato que o espião evitou roupas de cores claras para não chamar a atenção."] = 12
	L["O espião definitivamente prefere roupas escuras."] = 12

	-- No Potions
	L["Disseram que o espião não está carregando poções."] = 13
	L["Uma musicista me contou que viu o espião jogar fora a última poção que tinha. Agora ele não tem mais nenhuma."] = 13

	-- Book
	L["Soube que o espião sempre carrega um caderno de segredos no cinto."] = 14
	L["Corre um boato de que o espião adora ler e sempre carrega pelo menos um livro."] = 14
end
