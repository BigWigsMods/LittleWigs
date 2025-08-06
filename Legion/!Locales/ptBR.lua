-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "ptBR")
if L then
	L.tugar = "Tugar Totem de Sangue"
	L.jormog = "Jormog, o Beemote"

	L.remaining = "Escalas restantes"

	L.submerge = "Submergir"
	L.submerge_desc = "Submerge abaixo do solo, sumonando ovos e fazendo cair estalactites."

	L.charge_desc = "Quando Jormog estiver submerso, ele investirá periodicamente em sua direção."

	L.rupture = "{243382} (X)"
	L.rupture_desc = "Uma Ruptura Vil em forma de um X aparece embaixo de você. Após 5 segundos, ele romperá o solo, enviando espinhos para o ar e repelindo os jogadores em cima dele."

	L.totem_warning = "O Totem te acertou!"
end

L = BigWigs:NewBossLocale("Raest", "ptBR")
if L then
	L.name = "Raest Magilança"

	L.handFromBeyond = "Mão do Além"

	L.rune_desc = "Coloca uma runa de invocação no chão. Se não for absorvida, uma Coisa de Pesadelo irá aparecer."

	L.warmup_text = "Karam Magilança Ativo"
	L.warmup_trigger = "Foi tolice sua vir atrás de mim, irmão. A Espiral Etérea alimenta minhas forças. Eu me tornei mais poderoso do que você pode imaginar!"
	L.warmup_trigger2 = "Mate este intruso, irmão!"
end

L = BigWigs:NewBossLocale("Kruul", "ptBR")
if L then
	L.name = "Grão-lorde Kruul"
	L.inquisitor = "Inquisidor Variss"
	L.velen = "Profeta Velen"

	L.warmup_trigger = "Tolos arrogantes! Eu me fortaleci com a alma de mil mundos conquistados!"
	L.win_trigger = "Que assim seja. Vocês não vão ficar no caminho por muito tempo."

	L.nether_aberration_desc = "Evoca portais ao redor da sala, gerando Aberrações Etéreas."

	L.smoldering_infernal = "Infernal Fumegante"
	L.smoldering_infernal_desc = "Sumona um Infernal Fumegante."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "ptBR")
if L then
	L.erdris = "Lorde Erdris Cardo"

	L.warmup_trigger = "Sua chegada foi em boa hora."
	L.warmup_trigger2 = "O que está... Acontecendo?" --Stage 5 Warm up

	L.mage = "Mago Reanimado Corrompido"
	L.soldier = "Soldado Reanimado Corrompido"
	L.arbalest = "Arcobalista Reanimada Corrompida"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "ptBR")
if L then
	L.name = "Arquimago Tauriel"
	L.corruptingShadows = "Sombras Corruptoras"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "ptBR")
if L then
	L.name = "Agata"
	L.imp_servant = "Diabrete Serviçal"
	L.fuming_imp = "Diabrete Fumegante"
	L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	--L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	--L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.stacks = "Acumula"
end

L = BigWigs:NewBossLocale("Sigryn", "ptBR")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Vidente das Runas Faljar"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "ptBR")
if L then
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de fofoca do Tenente Sinclaris para iniciar o Ataque ao Castelo Violeta."
	L.keeper = "Defensor do Portal"
	L.guardian = "Guardião do Portal"
	L.infernal = "Infernal Fulgurante"
end

L = BigWigs:NewBossLocale("Thalena", "ptBR")
if L then
	L.essence = "Essência"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "ptBR")
if L then
	L.ghostly_retainer = "Escudeiro Fantasmagórico"
	L.ghostly_protector = "Protetor Fantasmagórico"
	L.ghostly_councilor = "Conselheiro Fantasmagórico"
	L.lord_etheldrin_ravencrest = "Lorde Etheldrin Cristacorvo"
	L.lady_velandras_ravencrest = "Lady Velandras Cristacorvo"
	L.rook_spiderling = "Aranita-corvo"
	L.soultorn_champion = "Campeão Almapartida"
	L.risen_scout = "Batedor Reanimado"
	L.risen_archer = "Arqueira Erguida"
	L.risen_arcanist = "Arcanista Reanimado"
	L.wyrmtongue_scavenger = "Catador Língua de Serpe"
	L.bloodscent_felhound = "Canisvil Cheirassangue"
	L.felspite_dominator = "Dominador Rancorvil"
	L.risen_swordsman = "Espadachim Revivido"
	L.risen_lancer = "Lanceiro Revivido"

	--L.door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "ptBR")
if L then
	--L.phase_2_trigger = "Enough! I tire of this."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "ptBR")
if L then
	L.custom_on_time_lost = "Tempo perdido durante Desvanecer nas Sombras"
	L.custom_on_time_lost_desc = "Mostra o tempo perdido durante o Desvanecer nas Sombras na barra em |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "ptBR")
if L then
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de fofoca da Égide de Aggramar para começar o confronto com Domatrax."

	L.missing_aegis = "Você não está com a Égide " -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "Égide: Cura Reduzida"
	L.aegis_damage = "Égide: Dano Reduzido"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "ptBR")
if L then
	L.dulzak = "Dul'zak"
	L.wrathguard = "Invasor Guardião Colérico"
	L.felguard = "Guarda Vil Destruidor"
	L.soulmender = "Trata-alma Ardinferno"
	L.temptress = "Tentadora Ardinferno"
	L.botanist = "Botânica Vilanesca"
	L.orbcaster = "Lança-orbe Passovil"
	L.waglur = "Wa'glur"
	L.scavenger = "Catador Língua de Serpe"
	L.gazerax = "Gazerax"
	L.vilebark = "Andarilho Cascavil"

	L.throw_tome = "Arremessar Tomo" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "ptBR")
if L then
	L.duskwatch_sentry = "Sentinela da Vigia Crepuscular"
	L.duskwatch_reinforcement = "Reforço da Vigia Crepuscular"
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

	L.hints[1] = "Capa"
	L.hints[2] = "Sem capa"
	L.hints[3] = "Bolsa"
	L.hints[4] = "Poções"
	L.hints[5] = "Mangas longas"
	L.hints[6] = "Mangas curtas"
	L.hints[7] = "Luvas"
	L.hints[8] = "Sem luvas"
	L.hints[9] = "Masculino"
	L.hints[10] = "Feminino"
	L.hints[11] = "Roupa clara"
	L.hints[12] = "Roupa escura"
	L.hints[13] = "Sem poções"
	L.hints[14] = "Livro"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "ptBR")
if L then
	L.warmup_trigger = "Mais um fracasso, Melandrus. Esta é sua chance de corrigí-lo. Livre-se desses forasteiros. Eu tenho que voltar ao Baluarte da Noite."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "ptBR")
if L then
	--L.archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!"

	L.mindshattered_screecher = "Guinchado Mentepartida"
	L.dreadsoul_ruiner = "Arruinador Almatorpe"
	L.dreadsoul_poisoner = "Envenenador Almatorpe"
	L.crazed_razorbeak = "Bicofino Enlouquecido"
	L.festerhide_grizzly = "Pelepodre Pardo"
	L.vilethorn_blossom = "Florescência Vilespinho"
	L.rotheart_dryad = "Dríade Putricórdio"
	L.rotheart_keeper = "Guardião Putricórdio"
	L.nightmare_dweller = "Habitante do Pesadelo"
	L.bloodtainted_fury = "Fúria Manchada de Sangue"
	L.bloodtainted_burster = "Estourador Manchado de Sangue"
	L.taintheart_summoner = "Evocador Cordismáculo"
	L.dreadfire_imp = "Diabrete do Fogo Mórbido"
	L.tormented_bloodseeker = "Sanguinário Atormentado"
end

L = BigWigs:NewBossLocale("Oakheart", "ptBR")
if L then
	--L.throw = "Throw"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "ptBR")
if L then
	L.wrangler = "Domador de Espiródio"
	L.stormweaver = "Tempestece Espiródio"
	L.crusher = "Esmagador Espiródio"
	L.oracle = "Oráculo Espiródio"
	L.siltwalker = "Mak'rana Andalodo"
	L.tides = "Marés Inquietas"
	L.arcanist = "Arcanista Espiródio"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "ptBR")
if L then
	L.custom_on_show_helper_messages = "Mensagens de ajuda para Nova Estática e Raio Concentrado"
	L.custom_on_show_helper_messages_desc = "Ative esta opção para adicionar uma mensagem auxiliar informando se a água ou a terra estão seguras quando o chefe começa a castar |cff71d5ffNova Estática|r ou |cff71d5ffRacio concentrado|r."

	L.water_safe = "%s (água está segura)"
	L.land_safe = "%s (terra está segura)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "ptBR")
if L then
	L.gossip_available = "Conversa disponível"
	L.gossip_trigger = "Muito impressionante! Eu nunca pensei que encontraria alguém capaz de igualar Valarjar em força... porém, aí estão vocês."

	L[197963] = "|cFF800080Acima à direita|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500Abaixo à direita|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00Abaixo à esquerda|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FFAcima à esquerda|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000Acima|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "ptBR")
if L then
	L.warmup_text = "Deus-Rei Skovald Ativo"
	L.warmup_trigger = "Os conquistadores já tomaram posse dele, Skovald, como era de direito. Seu protesto vem tarde demais."
	L.warmup_trigger_2 = "Se esses falsos campeões não entregarem a égide por escolha própria, entregarão na morte!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "ptBR")
if L then
	L.mug_of_mead = "Caneco de Hidromel"
	L.valarjar_thundercaller = "Arauto do Trovão Valarjar"
	L.storm_drake = "Draco da Tempestade"
	L.stormforged_sentinel = "Sentinela Forjada em Tempestade"
	L.valarjar_runecarver = "Gravarrunas Valarjar"
	L.valarjar_mystic = "Místico Valarjar"
	L.valarjar_purifier = "Purificador Valarjar"
	L.valarjar_shieldmaiden = "Dama Escudeira Valarjar"
	L.valarjar_aspirant = "Aspirante Valarjar"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr, o Iluminado"
	L.valarjar_marksman = "Atiradora Perita Valarjar"
	L.gildedfur_stag = "Cervo Pelo D'Ouro"
	L.angerhoof_bull = "Touro Casca da Fúria"
	L.valarjar_trapper = "Coureador Valarjar"
	L.fourkings = "Os Quatro Reis"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "ptBR")
if L then
	-- Opera Event
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de conversa com Barnes para iniciar o encontro no Salão de Ópera."
	L.opera_hall_wikket_story_text = "Salão de Ópera: Wikket"
	L.opera_hall_wikket_story_trigger = "Pare de falatório" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Salão de Ópera: História de Westfall"
	L.opera_hall_westfall_story_trigger = "nós encontramos dois amantes" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Salão de Ópera: A Bela e a Fera"
	L.opera_hall_beautiful_beast_story_trigger = "um conto de romance e raiva" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Filantropo Fantasma"
	L.skeletal_usher = "Porteiro Cadavérico"
	L.spectral_attendant = "Criado Espectral"
	L.spectral_valet = "Pajem Espectral"
	L.spectral_retainer = "Escudeiro Espectral"
	L.phantom_guardsman = "Guarda Fantasma"
	L.wholesome_hostess = "Anfitriã Respeitável"
	L.reformed_maiden = "Donzela Reabilitada"
	L.spectral_charger = "Corcel Espectral"

	-- Return to Karazhan: Upper
	L.chess_event = "Evento de Xadrez"
	L.king = "Rei"
end

L = BigWigs:NewBossLocale("Moroes", "ptBR")
if L then
	L.cc = "Controle Coletivo"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "ptBR")
if L then
	L.name = "Nocturno"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "ptBR")
if L then
	L.soulguard = "Guarda da Alma Encharcado"
	L.champion = "Campeão Helarjar"
	L.mariner = "Fuzileiro da Vigília Noturna"
	L.swiftblade = "Mardiçoado Lâmina Célere"
	L.mistmender = "Remenda-bruma Mardiçoada"
	L.mistcaller = "Chamabruma Helarjar"
	L.skjal = "Skjal"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "ptBR")
if L then
	L.rokmora_first_warmup_trigger = "Navarrogg?! Traidor! Você liderou esses intrusos contra nós?!"
	L.rokmora_second_warmup_trigger = "De qualquer forma, vou curtir cada momento. Rokmora, esmague-os!"

	L.vileshard_crawler = "Rastejante Estilhavil"
	L.tarspitter_lurker = "Tocaieiro Cospiche"
	L.rockback_gnasher = "Triscadente Costapétrea"
	L.vileshard_hulk = "Gigante Estilhavil"
	L.vileshard_chunk = "Pedaço de Estilhavil"
	L.understone_drummer = "Caixeiro Subpetra"
	L.mightstone_breaker = "Rachador Megalito"
	L.blightshard_shaper = "Moldador Mangrastilha"
	L.stoneclaw_grubmaster = "Mestre dos Vermes Garrapétrea"
	L.tarspitter_grub = "Verme Cospiche"
	L.rotdrool_grabber = "Agarrador Babapodre"
	L.understone_demolisher = "Demolidor Subpetra"
	L.rockbound_trapper = "Coureador Rochatado"
	L.emberhusk_dominator = "Dominador Cascabrasa"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "ptBR")
if L then
	--L.hands = "Hands" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "ptBR")
if L then
	L.guards = "Guardas"
	L.interrupted = "%s interrompido %s (%.1fs restando)!"
end

L = BigWigs:NewBossLocale("L'ura", "ptBR")
if L then
	L.warmup_text = "L'ura Ativa"
	L.warmup_trigger = "Quanto caos, quanta angústia. Nunca senti nada igual."
	L.warmup_trigger_2 = "Tais reflexões podem esperar, entretanto. Esta entidade deve morrer."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "ptBR")
if L then
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de conversa com Alleria Correventos."
	L.gossip_available = "Conversa disponível"
	L.alleria_gossip_trigger = "Siga-me!" -- Allerias yell after the first boss is defeated

	L.alleria = "Alleria Correventos"
	L.subjugator = "Subjugante da Guarda Sombria"
	L.voidbender = "Dobra-caos da Guarda Sombria"
	L.conjurer = "Conjuradora da Guarda Sombria"
	L.weaver = "Tecelã-mor das Sombras"
end

-- The Arcway

L = BigWigs:NewBossLocale("The Arcway Trash", "ptBR")
if L then
	L.anomaly = "Anomalia Arcana"
	L.shade = "Vulto Dimensional"
	L.wraith = "Espectro de Mana Fenecido"
	L.blade = "Guardião Colérico Lâmina Vil"
	L.chaosbringer = "Eredar Caótico"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "ptBR")
if L then
	L.kick_combo = "Combo de Chute"

	L.light_dropped = "%s derrubou a Luz."
	L.light_picked = "%s pegou a Luz."

	L.warmup_trigger = "Eu já estou com o que queria. Mas continuei aqui para que pudesse acabar com você... De uma vez por todas!"
	L.warmup_trigger_2 = "E agora, vocês caem na minha armadilha. Tolos. Vamos ver como vocês ficam no escuro."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "ptBR")
if L then
	L.warmup_trigger = "Servirei ao MEU povo, os exilados e enxovalhados."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "ptBR")
if L then
	L.infester = "Infestador Devoto Vil"
	L.myrmidon = "Mirmidão Devoto Vil"
	L.fury = "Fúria Vilinfusa"
	L.mother = "Mãe Imunda"
	L.illianna = "Dançarina das Lâminas Illiana"
	L.mendacius = "Senhor do Medo Mendácius"
	L.grimhorn = "Chifre Austero, o Escravizador"
end
