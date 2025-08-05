-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "itIT")
if L then
	L.tugar = "Tugar Totem Sanguinario"
	L.jormog = "Jormog il Behemoth"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "itIT")
if L then
	L.name = "Raest Lanciamagica"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "itIT")
if L then
	L.name = "Gran Signore Kruul"
	L.inquisitor = "Inquisitore Variss"
	L.velen = "Profeta Velen"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "itIT")
if L then
	L.erdris = "Ser Erdris Rovospina"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Mago Rianimato Corrotto"
	L.soldier = "Soldato Rianimato Corrotto"
	L.arbalest = "Balestriera Rianimata Corrotta"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "itIT")
if L then
	L.name = "Arcimago Xylem"
	L.corruptingShadows = "Ombre Corrompenti"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "itIT")
if L then
	L.name = "Agatha"
	L.imp_servant = "Imp Servitore"
	L.fuming_imp = "Imp Fumante"
	L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	--L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	--L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	--L.stacks = "Stacks"
end

L = BigWigs:NewBossLocale("Sigryn", "itIT")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Veggente delle Rune Faljar"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "itIT")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold."
	--L.keeper = "Portal Keeper"
	--L.guardian = "Portal Guardian"
	--L.infernal = "Blazing Infernal"
end

L = BigWigs:NewBossLocale("Thalena", "itIT")
if L then
	--L.essence = "Essence"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "itIT")
if L then
	L.ghostly_retainer = "Lacchè Spettrale"
	L.ghostly_protector = "Protettore Spettrale"
	L.ghostly_councilor = "Consigliere Spettrale"
	L.lord_etheldrin_ravencrest = "Ser Etheldrin Crinocorvo"
	L.lady_velandras_ravencrest = "Dama Velandras Crinocorvo"
	L.rook_spiderling = "Ragnetto Corvino"
	L.soultorn_champion = "Campione Senz'Anima"
	L.risen_scout = "Esploratore Rianimato"
	L.risen_archer = "Arciera Rianimata"
	L.risen_arcanist = "Arcanista Rianimato"
	L.wyrmtongue_scavenger = "Saprofago Drachilingua"
	L.bloodscent_felhound = "Vilsegugio Fiutorosso"
	L.felspite_dominator = "Dominatore Vilvendetta"
	L.risen_swordsman = "Spadaccino Rianimato"
	L.risen_lancer = "Lanciere Rianimato"

	--L.door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "itIT")
if L then
	--L.phase_2_trigger = "Enough! I tire of this."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "itIT")
if L then
	--L.custom_on_time_lost = "Time lost during Shadow Fade"
	--L.custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "itIT")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "itIT")
if L then
	L.dulzak = "Dul'zak"
	--L.wrathguard = "Wrathguard Invader"
	L.felguard = "Vilguardia Distruttrice"
	L.soulmender = "Guaritore d'Anime Ardinferno"
	L.temptress = "Tentatrice Ardinferno"
	L.botanist = "Botanica Stirpevile"
	L.orbcaster = "Scagliaglobi Vilcamminatrice"
	L.waglur = "Wa'glur"
	L.scavenger = "Saprofago Drachilingua"
	L.gazerax = "Gazerax"
	L.vilebark = "Camminatore Scorzavile"

	--L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "itIT")
if L then
	L.duskwatch_sentry = "Sentinella della Guardia del Vespro"
	L.duskwatch_reinforcement = "Membro dei Rinforzi della Guardia del Vespro"
	L.Guard = "Miliziano della Guardia del Vespro"
	L.Construct = "Costrutto Guardiano"
	L.Enforcer = "Scagnozza Vilvincolata"
	L.Hound = "Segugio della Legione"
	L.Mistress = "Signora dell'Ombra"
	L.Gerenth = "Gerenth il Vile"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Mohte'tajo"
	L.Baalgar = "Baalgar il Solerte"
	L.Inquisitor = "Inquisitore Vigile"
	L.BlazingImp = "Imp Fiammeggiante"
	L.Energy = "Energia Vincolata"
	L.Manifestation = "Manifestazione Arcana"
	L.Wyrm = "Dragone di Mana"
	L.Arcanist = "Arcanista della Guardia del Vespro"
	L.InfernalImp = "Imp Infernale"
	L.Malrodi = "Arcanista Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Chiavi Arcane"
	L.clues = "Indizi"

	L.InfernalTome = "Tomo Infernale"
	L.MagicalLantern = "Lanterna Magica"
	L.NightshadeRefreshments = "Rinfreschi degli Ombranera"
	L.StarlightRoseBrew = "Birra di Rosa Lucestellare"
	L.UmbralBloom = "Germoglio Ombroso"
	L.WaterloggedScroll = "Pergamena Fradicia"
	L.BazaarGoods = "Merci del Bazar"
	L.LifesizedNightborneStatue = "Statua di Nobile Oscuro Realistica"
	L.DiscardedJunk = "Cianfrusaglie Scartate"
	L.WoundedNightborneCivilian = "Civile Nobile Oscuro Ferito"

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

	--L.hints[1] = "Cape"
	--L.hints[2] = "No Cape"
	--L.hints[3] = "Pouch"
	--L.hints[4] = "Potions"
	--L.hints[5] = "Long Sleeves"
	--L.hints[6] = "Short Sleeves"
	--L.hints[7] = "Gloves"
	--L.hints[8] = "No Gloves"
	--L.hints[9] = "Male"
	--L.hints[10] = "Female"
	--L.hints[11] = "Light Vest"
	--L.hints[12] = "Dark Vest"
	--L.hints[13] = "No Potions"
	--L.hints[14] = "Book"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "itIT")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "itIT")
if L then
	--L.archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!"

	L.mindshattered_screecher = "Stridente Dissennato"
	L.dreadsoul_ruiner = "Polverizzatore Tetranima"
	L.dreadsoul_poisoner = "Avvelenatore Tetranima"
	L.crazed_razorbeak = "Beccolesto Frenetico"
	L.festerhide_grizzly = "Grizzly Putrescente"
	L.vilethorn_blossom = "Germoglio Spinavile"
	L.rotheart_dryad = "Driade Cuormarcio"
	L.rotheart_keeper = "Custode Cuormarcio"
	L.nightmare_dweller = "Abitante dell'Incubo"
	L.bloodtainted_fury = "Furia Marcasangue"
	L.bloodtainted_burster = "Zampillo Marcasangue"
	L.taintheart_summoner = "Evocatore Marcacuori"
	L.dreadfire_imp = "Imp Malofuoco"
	L.tormented_bloodseeker = "Bramasangue Tormentato"
end

L = BigWigs:NewBossLocale("Oakheart", "itIT")
if L then
	--L.throw = "Throw"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "itIT")
if L then
	L.wrangler = "Mandriano Spiraostile"
	L.stormweaver = "Brigliatuono Spiraostile"
	L.crusher = "Frantumatore Spiraostile"
	L.oracle = "Oracolo Spiraostile"
	L.siltwalker = "Calcalimo Mak'rana"
	L.tides = "Marea Irrequieta"
	L.arcanist = "Arcanista Spiraostile"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "itIT")
if L then
	--L.custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning"
	--L.custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r."

	--L.water_safe = "%s (water is safe)"
	--L.land_safe = "%s (land is safe)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "itIT")
if L then
	--L.gossip_available = "Gossip available"
	--L.gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand."

	--L[197963] = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	--L[197964] = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	--L[197965] = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	--L[197966] = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	--L[197967] = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "itIT")
if L then
	--L.warmup_text = "God-King Skovald Active"
	--L.warmup_trigger = "The vanquishers have already taken possession of it, Skovald, as was their right. Your protest comes too late."
	--L.warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "itIT")
if L then
	L.mug_of_mead = "Boccale di Idromele"
	L.valarjar_thundercaller = "Evocatuoni Valarjar"
	L.storm_drake = "Draco della Tempesta"
	L.stormforged_sentinel = "Sentinella Forgiatuono"
	L.valarjar_runecarver = "Incisore di Rune Valarjar"
	L.valarjar_mystic = "Mistico Valarjar"
	L.valarjar_purifier = "Purificatore Valarjar"
	L.valarjar_shieldmaiden = "Signora dello Scudo Valarjar"
	L.valarjar_aspirant = "Aspirante Valarjar"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr l'Illuminato"
	L.valarjar_marksman = "Tiratrice Valarjar"
	L.gildedfur_stag = "Cervo Peldorato"
	L.angerhoof_bull = "Zoccolofurioso Adulto"
	L.valarjar_trapper = "Mastro Bracconiere Valarjar"
	L.fourkings = "I quattro re"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "itIT")
if L then
	-- Opera Event
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Teatro: Il Mago di Hoz"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Teatro: Mrrgria"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Teatro: La Bella e il Bruto"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Filantropo Fantasma"
	L.skeletal_usher = "Usciere Scheletrico"
	L.spectral_attendant = "Attendente Spettrale"
	L.spectral_valet = "Maschera Spettrale"
	L.spectral_retainer = "Lacchè Spettrale"
	L.phantom_guardsman = "Armigero Fantasma"
	L.wholesome_hostess = "Cameriera Integerrima"
	L.reformed_maiden = "Dama Ravveduta"
	L.spectral_charger = "Gran Destriero Spettrale"

	-- Return to Karazhan: Upper
	L.chess_event = "Evento degli Scacchi"
	L.king = "Re"
end

L = BigWigs:NewBossLocale("Moroes", "itIT")
if L then
	L.cc = "Controllo delle Creature"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "itIT")
if L then
	L.name = "Noctumor"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "itIT")
if L then
	L.soulguard = "Guardia dell'Anima Fradicia"
	L.champion = "Campione Helarjar"
	L.mariner = "Marinaio dei Guardiani della Notte"
	L.swiftblade = "Lamalesta Maledetto"
	L.mistmender = "Curatrice delle Nebbie Maledetta"
	L.mistcaller = "Evocanebbie Helarjar"
	L.skjal = "Skjal"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "itIT")
if L then
	--L.rokmora_first_warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	--L.rokmora_second_warmup_trigger = "Either way, I will enjoy every moment of it. Rokmora, crush them!"

	L.vileshard_crawler = "Strisciatore Scheggiavile"
	L.tarspitter_lurker = "Guardingo Sputapece"
	L.rockback_gnasher = "Masticatore Dorsorigido"
	L.vileshard_hulk = "Colosso Scheggiavile"
	L.vileshard_chunk = "Frammento di Scheggiavile"
	L.understone_drummer = "Percussionista di Pietrabassa"
	L.mightstone_breaker = "Spezzatore di Pietragrossa"
	L.blightshard_shaper = "Plasmatore Scheggiamorbo"
	L.stoneclaw_grubmaster = "Signore delle Larve Unghiadura"
	L.tarspitter_grub = "Verme Sputapece"
	L.rotdrool_grabber = "Afferratore Bavamarcia"
	L.understone_demolisher = "Demolitore di Pietrabassa"
	L.rockbound_trapper = "Mastro Bracconiere Roccioso"
	L.emberhusk_dominator = "Dominatore Scorzambrata"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "itIT")
if L then
	--L.hands = "Hands" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "itIT")
if L then
	--L.guards = "Guards"
	--L.interrupted = "%s interrupted %s (%.1fs left)!"
end

L = BigWigs:NewBossLocale("L'ura", "itIT")
if L then
	--L.warmup_text = "L'ura Active"
	--L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	--L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "itIT")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects Alleria Winrunners gossip option."
	--L.gossip_available = "Gossip available"
	--L.alleria_gossip_trigger = "Follow me!" -- Allerias yell after the first boss is defeated

	--L.alleria = "Alleria Windrunner"
	--L.subjugator = "Shadowguard Subjugator"
	--L.voidbender = "Shadowguard Voidbender"
	--L.conjurer = "Shadowguard Conjurer"
	--L.weaver = "Grand Shadow-Weaver"
end

-- The Arcway

L = BigWigs:NewBossLocale("The Arcway Trash", "itIT")
if L then
	L.anomaly = "Anomalia Arcana"
	L.shade = "Ombra Distorcente"
	L.wraith = "Avvizzito del Mana Spettrale"
	L.blade = "Guardia dell'Ira Vilspada"
	L.chaosbringer = "Portatore del Caos Eredar"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "itIT")
if L then
	--L.kick_combo = "Kick Combo"

	--L.light_dropped = "%s dropped the Light."
	--L.light_picked = "%s picked up the Light."

	--L.warmup_trigger = "I have what I was after. But I stayed just so that I could put an end to you... once and for all!"
	--L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "itIT")
if L then
	--L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "itIT")
if L then
	--L.infester = "Felsworn Infester"
	--L.myrmidon = "Felsworn Myrmidon"
	--L.fury = "Fel-Infused Fury"
	--L.mother = "Foul Mother"
	--L.illianna = "Blade Dancer Illianna"
	--L.mendacius = "Dreadlord Mendacius"
	--L.grimhorn = "Grimhorn the Enslaver"
end
