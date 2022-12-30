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
	L.Imacutya = "Imacu'tya"
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
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "ptBR")
if L then
	L.warmup_trigger = "Mais um fracasso, Melandrus. Esta é sua chance de corrigí-lo. Livre-se desses forasteiros. Eu tenho que voltar ao Baluarte da Noite."
end
