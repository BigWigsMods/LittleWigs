local L = BigWigs:NewBossLocale("Court of Stars Trash", "itIT")
if not L then return end
if L then
	--L.Guard = "Duskwatch Guard"
	--L.Construct = "Guardian Construct"
	--L.Enforcer = "Felbound Enforcer"
	--L.Hound = "Legion Hound"
	L.Mistress = "Signora dell'Ombra"
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
	L.spyFoundPattern = "Su, su, non perdiamo la calma" -- Su, su, non perdiamo la calma, [playername]. Perché non mi segui, così possiamo parlare più tranquillamente...

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
	L.clue_1_1 = "Ho sentito che la spia adora indossare mantelli."
	L.clue_1_2 = "Qualcuno diceva che la spia è arrivata presto e indossava un mantello."

	-- No Cape
	L.clue_2_1 = "Ho sentito che la spia ha lasciato il suo mantello al palazzo prima di venire qui."
	L.clue_2_2 = "Ho sentito che la spia odia i mantelli e si rifiuta di indossarne uno."

	-- Pouch
	L.clue_3_1 = "Un amico mi ha detto che la spia ama l'oro e ne ha una borsa piena."
	L.clue_3_2 = "Ho sentito che la borsa da cintura della spia è piena di oro per sembrare stravagante."
	L.clue_3_3 = "Ho sentito che la spia si porta sempre dietro una borsa magica."
	L.clue_3_4 = "Ho sentito che la borsa da cintura della spia è ricamata con un filo stravagante."

	-- Potions
	L.clue_4_1 = "Ho sentito che la spia ha portato con sé alcune pozioni... se può servire."
	-- L.clue_4_2 = "Sono quasi sicura che la spia abbia delle pozioni alla cintura." -- sicura/sicuro?
	L.clue_4_2 = "Sono quasi sicuro che la spia abbia delle pozioni alla cintura."
	L.clue_4_3 = "Ho sentito che la spia ha portato con sé delle pozioni... mi chiedo perché."
	L.clue_4_4 = "Io non ti ho detto nulla, ma... la spia si è travestita da alchimista e porta delle pozioni legate alla cintura."

	-- Long Sleeves
	L.clue_5_1 = "Ho visto per un attimo la spia all'inizio della serata, aveva le maniche lunghe."
	L.clue_5_2 = "Ho sentito che la spia porta un abito con le maniche lunghe, stasera."
	L.clue_5_3 = "Qualcuno dice che la spia stia nascondendo le sue braccia con delle maniche lunghe, stasera."
	L.clue_5_4 = "Un mio amico dice che la spia ha le maniche lunghe."

	-- Short Sleeves
	L.clue_6_1 = "Ho sentito che la spia ama l'aria fresca e porta le maniche corte, stasera."
	L.clue_6_2 = "Un mio amico dice che l'abito indossato dalla spia è a maniche corte."
	L.clue_6_3 = "Mi hanno detto che la spia odia le maniche lunghe."
	L.clue_6_4 = "Ho sentito che la spia porta le maniche corte, per essere più libera per ogni evenienza."

	-- Gloves
	L.clue_7_1 = "Ho sentito che la spia porta sempre i guanti."
	L.clue_7_2 = "Voci dicono che la spia porti sempre i guanti."
	L.clue_7_3 = "Qualcuno dice che la spia porta sempre dei guanti per nascondere delle cicatrici."
	L.clue_7_4 = "Ho sentito che la spia tiene sempre accuratamente nascoste le sue mani."

	-- No Gloves
	L.clue_8_1 = "Voci dicono che la spia non porti mai i guanti."
	L.clue_8_2 = "Ho sentito che alla spia non piacciono i guanti."
	L.clue_8_3 = "Ho sentito che la spia non porta mai i guanti, in caso abbia bisogno di agire in fretta."
	L.clue_8_4 = "Sai... ho trovato un altro paio di guanti nella stanza sul retro. È probabile che la spia sia qui in giro con le mani scoperte."

	-- Male
	L.clue_9_1 = "Un ospite dice di averlo visto entrare nella villa a fianco della Gran Magistra."
	L.clue_9_2 = "Ho sentito in giro che la spia non è una donna."
	L.clue_9_3 = "Ho sentito che la spia è qui, pare sia davvero bellissimo."
	L.clue_9_4 = "Una delle musiciste dice che non ha smesso di farle domande a proposito del distretto."

	-- Female
	L.clue_10_1 = "Un ospite l'ha vista arrivare prima assieme a Elisande."
	L.clue_10_2 = "Ho sentito che una donna ha fatto un sacco di domande sul distretto..."
	L.clue_10_3 = "Qualcuno dice che il nuovo ospite non è un maschio."
	L.clue_10_4 = "Dicono che la spia sia qui e sia incredibilmente bella."

	-- Light Vest
	L.clue_11_1 = "Di sicuro la spia preferisce gli abiti dai colori chiari."
	L.clue_11_2 = "Ho sentito che la spia alla festa di stasera indossa un abito dai colori chiari."
	L.clue_11_3 = "La gente dice che la spia non indossa colori scuri stasera."

	-- Dark Vest
	L.clue_12_1 = "Ho sentito che stasera l'abito della spia è molto scuro."
	L.clue_12_2 = "Alla spia piacciono gli abiti dai colori scuri... come la notte."
	L.clue_12_3 = "Voci dicono che la spia eviti gli abiti dai colori chiari per passare meglio inosservata."
	L.clue_12_4 = "La spia ama gli abiti scuri, questo è certo."

	-- No Potions
	L.clue_13_1 = "Ho sentito che la spia non ha pozioni con sé."
	L.clue_13_2 = "Un musicante mi ha detto di aver visto la spia buttare via la sua ultima pozione. Probabilmente non ne ha altre."

	-- Book
	L.clue_14_1 = "Ho sentito che la spia ha sempre un libro pieno di segreti legato alla cintura."
	L.clue_14_2 = "Voci dicono che la spia ami leggere e porti sempre con sé almeno un libro."
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "itIT")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
