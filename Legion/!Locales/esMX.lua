-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "esMX")
if L then
	L.tugar = "Tugar Tótem Sangriento"
	L.jormog = "Jormog el Behemoth"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "esMX")
if L then
	L.name = "Raest Lanzamágica"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "esMX")
if L then
	L.name = "Alto señor Kruul"
	L.inquisitor = "Inquisidor Variss"
	L.velen = "Profeta Velen"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "esMX")
if L then
	L.erdris = "Lord Erdris Espina"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Mago resucitado corrupto"
	L.soldier = "Soldado resucitado corrupto"
	L.arbalest = "Arbalesta resucitada corrupta"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "esMX")
if L then
	L.name = "Archimago Xylem"
	L.corruptingShadows = "Sombra corruptora"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "esMX")
if L then
	L.name = "Agatha"
	L.imp_servant = "Sirviente diablillo"
	L.fuming_imp = "Diablillo humeante"
	L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	--L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	--L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	--L.stacks = "Stacks"
end

L = BigWigs:NewBossLocale("Sigryn", "esMX")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Vidente de runas Faljar"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "esMX")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold."
	--L.keeper = "Portal Keeper"
	--L.guardian = "Portal Guardian"
	--L.infernal = "Blazing Infernal"
end

L = BigWigs:NewBossLocale("Thalena", "esMX")
if L then
	--L.essence = "Essence"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "esMX")
if L then
	L.ghostly_retainer = "Criado fantasmal"
	L.ghostly_protector = "Protector fantasmal"
	L.ghostly_councilor = "Consejero fantasmal"
	L.lord_etheldrin_ravencrest = "Lord Etheldrin Cresta Cuervo"
	L.lady_velandras_ravencrest = "Lady Velandras Cresta Cuervo"
	L.rook_spiderling = "Arañita del torreón"
	L.soultorn_champion = "Campeón infausto"
	L.risen_scout = "Explorador resucitado"
	L.risen_archer = "Arquera resucitada"
	L.risen_arcanist = "Arcanista resucitado"
	L.wyrmtongue_scavenger = "Carroñero Lenguavermis"
	L.bloodscent_felhound = "Can manáfago Sangresencia"
	L.felspite_dominator = "Dominador Flemavil"
	L.risen_swordsman = "Espadachín resucitado"
	L.risen_lancer = "Lancero resucitado"

	--L.door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "esMX")
if L then
	--L.phase_2_trigger = "Enough! I tire of this."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "esMX")
if L then
	--L.custom_on_time_lost = "Time lost during Shadow Fade"
	--L.custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "esMX")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "esMX")
if L then
	L.dulzak = "Dul'zak"
	--L.wrathguard = "Wrathguard Invader"
	L.felguard = "Destructor guardia vil"
	L.soulmender = "Ensalmador de almas Llama Infernal"
	L.temptress = "Tentadora Llama Infernal"
	L.botanist = "Botanista vilificada"
	L.orbcaster = "Lanzaorbes Zancavil"
	L.waglur = "Wa'glur"
	L.scavenger = "Carroñero Lenguavermis"
	L.gazerax = "Avizorax"
	L.vilebark = "Caminante Cortezavil"

	--L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "esMX")
if L then
	L.duskwatch_sentry = "Avizor Vigía del ocaso"
	L.duskwatch_reinforcement = "Refuerzo de los Vigías del ocaso"
	L.Guard = "Guardia Vigía del ocaso"
	L.Construct = "Ensamblaje guardián"
	L.Enforcer = "Déspota de vínculo vil"
	L.Hound = "Can de la Legión"
	L.Mistress = "Señora de las Sombras"
	L.Gerenth = "Gerenth el Vil"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Imacu'tya"
	L.Baalgar = "Baalgar el Vigilante"
	L.Inquisitor = "Inquisidor vigilante"
	L.BlazingImp = "Diablillo llameante"
	L.Energy = "Energía contenida"
	L.Manifestation = "Manifestación Arcana"
	L.Wyrm = "Vermis de maná"
	L.Arcanist = "Arcanista Vigía del ocaso"
	L.InfernalImp = "Diablillo infernal"
	L.Malrodi = "Arcanista Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Llaves Arcanas"
	L.clues = "Pistas"

	L.InfernalTome = "Tomo infernal"
	L.MagicalLantern = "Farol mágico"
	L.NightshadeRefreshments = "Refrigerios Sombranoche"
	L.StarlightRoseBrew = "Cerveza de rosa luz estelar"
	L.UmbralBloom = "Flor umbría"
	L.WaterloggedScroll = "Pergamino encharcado"
	L.BazaarGoods = "Objetos del Bazar"
	L.LifesizedNightborneStatue = "Estatua Nocheterna a tamaño real"
	L.DiscardedJunk = "Chatarra desechada"
	L.WoundedNightborneCivilian = "Civil Nocheterna herido"

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
	L.spyFoundPattern = "Calma, no nos apuremos" -- Calma, no nos apuremos, [playername]. Mejor sígueme y hablemos de esto en un lugar algo más privado…

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

L = BigWigs:NewBossLocale("Advisor Melandrus", "esMX")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "esMX")
if L then
	--L.archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!"

	L.mindshattered_screecher = "Estridador Mentequebrada"
	L.dreadsoul_ruiner = "Arruinador Almaespanto"
	L.dreadsoul_poisoner = "Envenenador Almaespanto"
	L.crazed_razorbeak = "Picovaja enloquecido"
	L.festerhide_grizzly = "Oso pardo con piel supurante"
	L.vilethorn_blossom = "Flor Espinavil"
	L.rotheart_dryad = "Dríade Corazón infecto"
	L.rotheart_keeper = "Vigilante Corazón Infecto"
	L.nightmare_dweller = "Habitante de la Pesadilla"
	L.bloodtainted_fury = "Furia manchada de sangre"
	L.bloodtainted_burster = "Reventador manchado de sangre"
	L.taintheart_summoner = "Invocador Corazón Ruin"
	L.dreadfire_imp = "Diablillo de fuego aterrador"
	L.tormented_bloodseeker = "Buscasangre atormentado"
end

L = BigWigs:NewBossLocale("Oakheart", "esMX")
if L then
	--L.throw = "Throw"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "esMX")
if L then
	L.wrangler = "Retador Espiral de Odio"
	L.stormweaver = "Tejetormentas Espiral de Odio"
	L.crusher = "Triturador Espiral de Odio"
	L.oracle = "Oráculo Espiral de Odio"
	L.siltwalker = "Caminante de limo de Mak'rana"
	L.tides = "Mareas inquietas"
	L.arcanist = "Arcanista Espiral de Odio"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "esMX")
if L then
	--L.custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning"
	--L.custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r."

	--L.water_safe = "%s (water is safe)"
	--L.land_safe = "%s (land is safe)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "esMX")
if L then
	--L.gossip_available = "Gossip available"
	--L.gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand."

	--L[197963] = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	--L[197964] = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	--L[197965] = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	--L[197966] = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	--L[197967] = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "esMX")
if L then
	--L.warmup_text = "God-King Skovald Active"
	--L.warmup_trigger = "The vanquishers have already taken possession of it, Skovald, as was their right. Your protest comes too late."
	--L.warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "esMX")
if L then
	L.mug_of_mead = "Jarra de hidromiel"
	L.valarjar_thundercaller = "Clamatruenos Valarjar"
	L.storm_drake = "Draco de tormenta"
	L.stormforged_sentinel = "Centinela Tronaforjado"
	L.valarjar_runecarver = "Grabador de runas Valarjar"
	L.valarjar_mystic = "Místico Valarjar"
	L.valarjar_purifier = "Purificador Valarjar"
	L.valarjar_shieldmaiden = "Doncella escudera Valarjar"
	L.valarjar_aspirant = "Aspirante Valarjar"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr el Iluminado"
	L.valarjar_marksman = "Tiradora Valarjar"
	L.gildedfur_stag = "Venado de pelaje dorado"
	L.angerhoof_bull = "Astado Uñainquina"
	L.valarjar_trapper = "Trampero Valarjar"
	L.fourkings = "Los cuatro reyes"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "esMX")
if L then
	-- Opera Event
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Sala de la Ópera: makaku"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Sala de la Ópera: Páramos de Poniente"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Sala de la Ópera: bestia hermosa"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Filántropo fantasmal"
	L.skeletal_usher = "Ujier esquelético"
	L.spectral_attendant = "Auxiliar espectral"
	L.spectral_valet = "Ayuda de cámara espectral"
	L.spectral_retainer = "Criado espectral"
	L.phantom_guardsman = "Aparición de custodio"
	L.wholesome_hostess = "Anfitriona saludable"
	L.reformed_maiden = "Doncella reformada"
	L.spectral_charger = "Destrero espectral"

	-- Return to Karazhan: Upper
	L.chess_event = "Evento del Ajedrez"
	L.king = "Rey"
end

L = BigWigs:NewBossLocale("Moroes", "esMX")
if L then
	L.cc = "Control de masas"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "esMX")
if L then
	L.name = "Nocturno"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "esMX")
if L then
	L.soulguard = "Guardián de almas calado"
	L.champion = "Campeón Helarjar"
	L.mariner = "Marino de la Guardia Nocturna"
	L.swiftblade = "Hojágil maldecido por el mar"
	L.mistmender = "Curanieblas maldecida por el mar"
	L.mistcaller = "Clamaneblina Helarjar"
	L.skjal = "Skjal"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "esMX")
if L then
	--L.rokmora_first_warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	--L.rokmora_second_warmup_trigger = "Either way, I will enjoy every moment of it. Rokmora, crush them!"

	L.vileshard_crawler = "Reptador Pizcavil"
	L.tarspitter_lurker = "Rondador Escupebrea"
	L.rockback_gnasher = "Rechinador Rocalomo"
	L.vileshard_hulk = "Mole Pizcavil"
	L.vileshard_chunk = "Kacho Pizcavil"
	L.understone_drummer = "Tamborilero Sotopiedra"
	L.mightstone_breaker = "Rompedor Piedra de Poderío"
	L.blightshard_shaper = "Modelador Pizcañublo"
	L.stoneclaw_grubmaster = "Domalarvas Garrapétrea"
	L.tarspitter_grub = "Larva Escupebrea"
	L.rotdrool_grabber = "Agarrador Babapútrida"
	L.understone_demolisher = "Demoledor Sotopiedra"
	L.rockbound_trapper = "Trampero ligarroca"
	L.emberhusk_dominator = "Dominador Caparabrasa"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "esMX")
if L then
	--L.hands = "Hands" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "esMX")
if L then
	--L.guards = "Guards"
	--L.interrupted = "%s interrupted %s (%.1fs left)!"
end

L = BigWigs:NewBossLocale("L'ura", "esMX")
if L then
	--L.warmup_text = "L'ura Active"
	--L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	--L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "esMX")
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

L = BigWigs:NewBossLocale("The Arcway Trash", "esMX")
if L then
	L.anomaly = "Anomalía Arcana"
	L.shade = "Sombra de distorsión"
	L.wraith = "Espectro de maná Marchito"
	L.blade = "Guardia de cólera hoja mácula"
	L.chaosbringer = "Portador de caos eredar"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "esMX")
if L then
	--L.kick_combo = "Kick Combo"

	--L.light_dropped = "%s dropped the Light."
	--L.light_picked = "%s picked up the Light."

	--L.warmup_trigger = "I have what I was after. But I stayed just so that I could put an end to you... once and for all!"
	--L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "esMX")
if L then
	--L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "esMX")
if L then
	--L.infester = "Felsworn Infester"
	--L.myrmidon = "Felsworn Myrmidon"
	--L.fury = "Fel-Infused Fury"
	--L.mother = "Foul Mother"
	--L.illianna = "Blade Dancer Illianna"
	--L.mendacius = "Dreadlord Mendacius"
	--L.grimhorn = "Grimhorn the Enslaver"
end
