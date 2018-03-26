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
	L["Ho sentito che la spia adora indossare mantelli."] = 1
	L["Qualcuno diceva che la spia è arrivata presto e indossava un mantello."] = 1

	-- No Cape
	L["Ho sentito che la spia ha lasciato il suo mantello al palazzo prima di venire qui."] = 2
	L["Ho sentito che la spia odia i mantelli e si rifiuta di indossarne uno."] = 2

	-- Pouch
	L["Un amico mi ha detto che la spia ama l'oro e ne ha una borsa piena."] = 3
	L["Ho sentito che la borsa da cintura della spia è piena di oro per sembrare stravagante."] = 3
	L["Ho sentito che la spia si porta sempre dietro una borsa magica."] = 3
	L["Ho sentito che la borsa da cintura della spia è ricamata con un filo stravagante."] = 3

	-- Potions
	L["Ho sentito che la spia ha portato con sé alcune pozioni... se può servire."] = 4
	--L["Sono quasi sicura che la spia abbia delle pozioni alla cintura."] = 4 -- sicura/sicuro?
	L["Sono quasi sicuro che la spia abbia delle pozioni alla cintura."] = 4
	L["Ho sentito che la spia ha portato con sé delle pozioni... mi chiedo perché."] = 4
	L["Io non ti ho detto nulla, ma... la spia si è travestita da alchimista e porta delle pozioni legate alla cintura."] = 4

	-- Long Sleeves
	L["Ho visto per un attimo la spia all'inizio della serata, aveva le maniche lunghe."] = 5
	L["Ho sentito che la spia porta un abito con le maniche lunghe, stasera."] = 5
	L["Qualcuno dice che la spia stia nascondendo le sue braccia con delle maniche lunghe, stasera."] = 5
	L["Un mio amico dice che la spia ha le maniche lunghe."] = 5

	-- Short Sleeves
	L["Ho sentito che la spia ama l'aria fresca e porta le maniche corte, stasera."] = 6
	L["Un mio amico dice che l'abito indossato dalla spia è a maniche corte."] = 6
	L["Mi hanno detto che la spia odia le maniche lunghe."] = 6
	L["Ho sentito che la spia porta le maniche corte, per essere più libera per ogni evenienza."] = 6

	-- Gloves
	L["Ho sentito che la spia porta sempre i guanti."] = 7
	L["Voci dicono che la spia porti sempre i guanti."] = 7
	L["Qualcuno dice che la spia porta sempre dei guanti per nascondere delle cicatrici."] = 7
	L["Ho sentito che la spia tiene sempre accuratamente nascoste le sue mani."] = 7

	-- No Gloves
	L["Voci dicono che la spia non porti mai i guanti."] = 8
	L["Ho sentito che alla spia non piacciono i guanti."] = 8
	L["Ho sentito che la spia non porta mai i guanti, in caso abbia bisogno di agire in fretta."] = 8
	L["Sai... ho trovato un altro paio di guanti nella stanza sul retro. È probabile che la spia sia qui in giro con le mani scoperte."] = 8

	-- Male
	L["Un ospite dice di averlo visto entrare nella villa a fianco della Gran Magistra."] = 9
	L["Ho sentito in giro che la spia non è una donna."] = 9
	L["Ho sentito che la spia è qui, pare sia davvero bellissimo."] = 9
	L["Una delle musiciste dice che non ha smesso di farle domande a proposito del distretto."] = 9

	-- Female
	L["Un ospite l'ha vista arrivare prima assieme a Elisande."] = 10
	L["Ho sentito che una donna ha fatto un sacco di domande sul distretto..."] = 10
	L["Qualcuno dice che il nuovo ospite non è un maschio."] = 10
	L["Dicono che la spia sia qui e sia incredibilmente bella."] = 10

	-- Light Vest
	L["Di sicuro la spia preferisce gli abiti dai colori chiari."] = 11
	L["Ho sentito che la spia alla festa di stasera indossa un abito dai colori chiari."] = 11
	L["La gente dice che la spia non indossa colori scuri stasera."] = 11

	-- Dark Vest
	L["Ho sentito che stasera l'abito della spia è molto scuro."] = 12
	L["Alla spia piacciono gli abiti dai colori scuri... come la notte."] = 12
	L["Voci dicono che la spia eviti gli abiti dai colori chiari per passare meglio inosservata."] = 12
	L["La spia ama gli abiti scuri, questo è certo."] = 12

	-- No Potions
	L["Ho sentito che la spia non ha pozioni con sé."] = 13
	L["Un musicante mi ha detto di aver visto la spia buttare via la sua ultima pozione. Probabilmente non ne ha altre."] = 13

	-- Book
	L["Ho sentito che la spia ha sempre un libro pieno di segreti legato alla cintura."] = 14
	L["Voci dicono che la spia ami leggere e porti sempre con sé almeno un libro."] = 14
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "itIT")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end
