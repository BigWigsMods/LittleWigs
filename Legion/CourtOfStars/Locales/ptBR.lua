local L = BigWigs:NewBossLocale("Court of Stars Trash", "ptBR")
if not L then return end
if L then
	L.Guard = "Guarda da Vigia Crepuscular"
	L.Construct = "Constructo Guardião"
	L.Enforcer = "Impositora Aviltada"
	L.Hound = "Farejador Legionário"
	L.Mistress = "Donzela Sombria"
	L.Gerenth = "Gerenth, o Torpe"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Imacutya"
	L.Baalgar = "Baalgar, o Vigilante"
	L.Inquisitor = "Inquisidor Vigilante"
	L.BlazingImp = "Diabrete Fulgurante"
	L.Energy = "Energia Aprisionada"
	L.Manifestation = "Manifestação Arcana"
	L.Wyrm = "Moreia de Mana"
	L.Arcanist = "Arcanista da Vigia Crepuscular"
	L.InfernalImp = "Diabrete Infernal"
	L.Malrodi = "Arcanista Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Chaves Arcanas"
	L.clues = "Pistas"

	L.InfernalTome = "Tomo Infernal"
	L.MagicalLantern = "Lanterna Mágica"
	L.NightshadeRefreshments = "Lanches de Beladona"
	L.StarlightRoseBrew = "Cerveja de Rosa-da-luz-estelar"
	L.UmbralBloom = "Flor Umbrática"
	L.WaterloggedScroll = "Pergaminho Encharcado"
	L.BazaarGoods = "Mercadorias do bazar"
	L.LifesizedNightborneStatue = "Estátua de Filho da Noite em Tamanho Real"
	L.DiscardedJunk = "Lixo Descartado"
	L.WoundedNightborneCivilian = "Civil Filho da Noite Ferido"

	L.announce_buff_items = "Anuncia itens de buff"
	L.announce_buff_items_desc = "Anuncia todos os itens buff disponíveis ao redor da dungeon e quem é capaz de usá-los."

	L.available = "%s|cffffffff%s|r disponível" -- Context: item is available to use
	L.usableBy = "utilizável por %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "usar instantaneamente itens com buff"
	L.custom_on_use_buff_items_desc = "Ative esta opção para usar instantaneamente os itens de buff ao redor da dungeon. Isso não usará os itens que aggram os guardas antes do segundo chefe."

	L.spy_helper = "Ajudante de Evento Espião"
	L.spy_helper_desc = "Mostra uma Caixa de Informações com todas as pistas que seu grupo reuniu sobre o espião. As pistas também serão enviadas para os membros do seu grupo no chat."

	L.clueFound = "Pista encontrada (%d/5): |cffffffff%s|r"
	L.spyFound = "Espião encontrado por %s!"
	L.spyFoundChat = "Eu encontrei o espião!"
	L.spyFoundPattern = "Ora, ora, não sejamos apressados" -- Ora, ora, não sejamos apressados, [playername]. Que tal me seguir e conversar em um local mais reservado...

	L.hints =  {
		"Capa",
		"Sem capa",
		"Bolsa",
		"Poções",
		"Mangas longas",
		"Mangas curtas",
		"Luvas",
		"Sem luvas",
		"Masculino",
		"Feminino",
		"Roupa clara",
		"Roupa escura",
		"Sem poções",
		"Livro",
	}

	--[[ !!! IMPORTANT NOTE TO TRANSLATORS !!! ]]--
	--[[ The following translations have to exactly match the gossip text of the Chatty Rumormongers. ]]--

	-- Cape
	L.clue_1_1 = "Ouvi dizer que o espião gosta de usar capas."
	L.clue_1_2 = "Alguém falou que o espião chegou mais cedo usando uma capa."

	-- No Cape
	L.clue_2_1 = "Ouvi dizer que o espião deixou a capa no palácio antes de vir pra cá."
	L.clue_2_2 = "Ouvi dizer que o espião não gosta de capas e se recusa a usar uma."

	-- Pouch
	L.clue_3_1 = "Um amigo disse que o espião ama ouro e uma pochete bem cheia disso."
	L.clue_3_2 = "Ouvi dizer que a pochete do espião está cheia de ouro para mostrar extravagância."
	L.clue_3_3 = "Ouvi dizer que o espião sempre anda com uma bolsa mágica."
	L.clue_3_4 = "Ouvi dizer que a pochete do espião é forrada com fios finos."

	-- Potions
	L.clue_4_1 = "Disseram que o espião trouxe algumas poções... só por garantia."
	L.clue_4_2 = "Tenho certeza de que o espião tem poções no cinto."
	L.clue_4_3 = "Disseram que o espião trouxe poções, por que será?"
	L.clue_4_4 = "Eu não lhe disse nada... mas o espião está disfarçado de alquimista, carregando poções no cinto."

	-- Long Sleeves
	L.clue_5_1 = "Eu mal consegui espiar as mangas compridas do espião."
	L.clue_5_2 = "Ouvi dizer que a roupa do espião é de manga comprida."
	L.clue_5_3 = "Alguém me disse que o espião está cobrindo os braços com mangas compridas."
	L.clue_5_4 = "Um amigo meu disse que o espião está de mangas compridas."

	-- Short Sleeves
	L.clue_6_1 = "Ouvi dizer que o espião gosta de ar fresco e não está usando mangas compridas."
	L.clue_6_2 = "Uma amiga minha disse que viu a roupa espião. Não tinha mangas longas."
	L.clue_6_3 = "Alguém me disse que o espião odeia mangas compridas."
	L.clue_6_4 = "Dizem que o espião usa mangas curtas para manter os braços livres."

	-- Gloves
	L.clue_7_1 = "Ouvi dizer que o espião sempre usa luvas."
	L.clue_7_2 = "Corre um boato de que o espião sempre usa luvas."
	L.clue_7_3 = "Alguém disse que o espião usa luvas para esconder cicatrizes."
	L.clue_7_4 = "Dizem que o espião fica escondendo as mãos."

	-- No Gloves
	L.clue_8_1 = "Estão dizendo que o espião nunca usa luvas."
	L.clue_8_2 = "Ouvi dizer que o espião não gosta de usar luvas."
	L.clue_8_3 = "Estão dizendo que o espião evita usar luvas, para o caso de precisar agir rapidamente."
	L.clue_8_4 = "Sabe de uma coisa... Encontrei um par de luvas lá atrás. Imagino que o espião esteja por aí de mãos nuas."

	-- Male
	L.clue_9_1 = "Um convidado disse que o viu entrando na mansão ao lado da Grã-magistra."
	L.clue_9_2 = "Ouvi dizer por aí que o espião não é uma mulher."
	L.clue_9_3 = "Ouvi dizer que o espião está aqui e é muito bonito."
	L.clue_9_4 = "Um dos músicos disse que ele não parava de perguntar sobre o distrito."

	-- Female
	L.clue_10_1 = "Um convidado viu ela e Elisande chegarem juntas."
	L.clue_10_2 = "Ouvi falar que uma mulher está fazendo várias perguntas sobre o distrito..."
	L.clue_10_3 = "Tem gente dizendo que é uma nova convidada, e não convidado."
	L.clue_10_4 = "Dizem que a espiã está aqui e que ela é um colírio para os olhos."

	-- Light Vest
	L.clue_11_1 = "O espião definitivamente prefere coletes de cor clara."
	L.clue_11_2 = "Ouvi dizer que o espião está usando um colete claro."
	L.clue_11_3 = "Estão dizendo que o espião não está usando colete escuro hoje."

	-- Dark Vest
	L.clue_12_1 = "Ouvi dizer que as vestes do espião têm um tom escuro e rico esta noite."
	L.clue_12_2 = "O espião gosta de coletes escuros... como a noite."
	L.clue_12_3 = "Corre um boato que o espião evitou roupas de cores claras para não chamar a atenção."
	L.clue_12_4 = "O espião definitivamente prefere roupas escuras."

	-- No Potions
	L.clue_13_1 = "Disseram que o espião não está carregando poções."
	L.clue_13_2 = "Uma musicista me contou que viu o espião jogar fora a última poção que tinha. Agora ele não tem mais nenhuma."

	-- Book
	L.clue_14_1 = "Soube que o espião sempre carrega um caderno de segredos no cinto."
	L.clue_14_2 = "Corre um boato de que o espião adora ler e sempre carrega pelo menos um livro."
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "ptBR")
if L then
	L.warmup_trigger = "Mais um fracasso, Melandrus. Esta é sua chance de corrigí-lo. Livre-se desses forasteiros. Eu tenho que voltar ao Baluarte da Noite."
end
