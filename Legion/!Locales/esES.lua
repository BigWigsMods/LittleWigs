-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "esES")
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

L = BigWigs:NewBossLocale("Raest", "esES")
if L then
	L.name = "Raest Lanzamágica"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "esES")
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

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "esES")
if L then
	L.erdris = "Lord Erdris Espina"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Mago resucitado corrupto"
	L.soldier = "Soldado resucitado corrupto"
	L.arbalest = "Arbalesta resucitada corrupta"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "esES")
if L then
	L.name = "Archimago Xylem"
	L.corruptingShadows = "Sombra corruptora"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "esES")
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

L = BigWigs:NewBossLocale("Sigryn", "esES")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Vidente de runas Faljar"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "esES")
if L then
	L.custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de la Teniente Sinclari para empezar el Asalto en el Bastión Violeta."
	L.keeper = "Vigilante de portal"
	L.guardian = "Guardián de portal"
	L.infernal = "Infernal llameante"
end

L = BigWigs:NewBossLocale("Thalena", "esES")
if L then
	L.essence = "Esencia"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "esES")
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

	L.door_open_desc = "Muestra una barra que indica cuando se abre la puerta hacia el Pasadizo secreto."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "esES")
if L then
	L.phase_2_trigger = "¡Basta! Me estoy cansando."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "esES")
if L then
	L.custom_on_time_lost = "Tiempo perdido en Oculto en las sombras"
	L.custom_on_time_lost_desc = "Muestra el tiempo perdido en Oculto en las sombras en la barra |cffff0000red|r."
	L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "esES")
if L then
	L.custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de la Égida de Aggramar para empezar el encuentro con Domatrax."

	L.missing_aegis = "No estás dentro de la Égida"
	L.aegis_healing = "Égida: Sanación realizada reducida"
	L.aegis_damage = "Égida: Daño infligido reducido"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "esES")
if L then
	L.dulzak = "Dul'zak"
	L.wrathguard = "Invasor guardia de cólera"
	L.felguard = "Destructor guardia vil"
	L.soulmender = "Ensalmador de almas Llama Infernal"
	L.temptress = "Tentadora Llama Infernal"
	L.botanist = "Botanista vilificada"
	L.orbcaster = "Lanzaorbes Zancavil"
	L.waglur = "Wa'glur"
	L.scavenger = "Carroñero Lenguavermis"
	L.gazerax = "Avizorax"
	L.vilebark = "Caminante Cortezavil"

	L.throw_tome = "Lanzar escrito" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "esES")
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

	L.announce_buff_items = "Anuncia los buffs de los objetos" --Announce buff items
	L.announce_buff_items_desc = "Anuncia los buffs disponibles de los objetos alrededor de la mazmorra y quién los puede utilizar." --Anounces all available buff items around the dungeon and who is able to use them.

	L.available = "%s|cffffffff%s|r disponible" -- Context: item is available to use
	L.usableBy = "puede ser utilizado por %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Usa al instante el buff de los objetos." -- Instantly use buff items
	L.custom_on_use_buff_items_desc = "Activa esta opción para usar instantáneamente los buffs de los objetos alrededor de la mazmorra. Esto no será usado en los objetos que amenazan a los guardias antes del segundo jefe." --Enable this options to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss.

	L.spy_helper = "Asistente para el evento del espía"
	L.spy_helper_desc = "Muestra una plantilla de información con todas las pistas que el grupo haya reunido sobre el espía. Las pistas también serán enviadas a tus miembros de grupo en el chat." --Shows an InfoBox with all clues your group gathered about the spy. The clues will also be send to your party members in chat.

	L.clueFound = "Pista hallada (%d/5): |cffffffff%s|r"
	L.spyFound = "Espía encontrado por %s!"
	L.spyFoundChat = "¡Encontré al espía!"
	L.spyFoundPattern = "Bueno, bueno, no nos precipitemos" -- Bueno, bueno, no nos precipitemos. ¿Y si me acompañas para poder discutirlo en un ambiente más privado...?

	L.hints[1] = "Capa"
	L.hints[2] = "Sin capa"
	L.hints[3] = "Faltriquera"
	L.hints[4] = "Pociones"
	L.hints[5] = "Mangas largas"
	L.hints[6] = "Mangas cortas"
	L.hints[7] = "Guantes"
	L.hints[8] = "Sin guantes"
	L.hints[9] = "Hombre"
	L.hints[10] = "Mujer"
	L.hints[11] = "Jubón claro"
	L.hints[12] = "Jubón oscuro"
	L.hints[13] = "Sin pociones"
	L.hints[14] = "Libro"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "esES")
if L then
	L.warmup_trigger = "Un fracaso más, Melandrus. Esta es tu oportunidad de corregirlo. Deshazte de estos intrusos. Debo regresar al Bastión Nocturno."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "esES")
if L then
	L.archdruid_glaidalis_warmup_trigger = "Corruptores... Huelo la pesadilla en vuestra sangre. ¡Abandonad estos bosques o sufrid la ira de la naturaleza!"

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

L = BigWigs:NewBossLocale("Oakheart", "esES")
if L then
	L.throw = "Lanzar"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "esES")
if L then
	L.wrangler = "Retador Espiral de Odio"
	L.stormweaver = "Tejetormentas Espiral de Odio"
	L.crusher = "Triturador Espiral de Odio"
	L.oracle = "Oráculo Espiral de Odio"
	L.siltwalker = "Caminante de limo de Mak'rana"
	L.tides = "Mareas inquietas"
	L.arcanist = "Arcanista Espiral de Odio"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "esES")
if L then
	L.custom_on_show_helper_messages = "Mensajes de ayuda para Nova estática y Relámpago enfocado"
	L.custom_on_show_helper_messages_desc = "Activa esta opción para añadir un mensaje de ayuda diciéndote si el agua o la arena es segura cuando el jefe esté lanzando |cff71d5ffNova estática|r o |cff71d5ffRelámpago enfocado|r."

	L.water_safe = "%s (el agua es segura)"
	L.land_safe = "%s (la arena es segura)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "esES")
if L then
	L.gossip_available = "Conversación disponible"
	L.gossip_trigger = "Impresionante. Nunca pensé que encontraría a alguien capaz de igualar la fuerza de los Valajar... pero aquí estáis."

	L[197963] = "|cFF800080Arriba derecha|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500Abajo derecha|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00Abajo izquierda|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FFArriba izquierda|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000Arriba|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "esES")
if L then
	L.warmup_text = "Rey dios Skovald activo"
	L.warmup_trigger = "Los triunfadores  ya han tomado posesión de ella, Skovald, pues tal era su derecho. Llegas demasiado tarde."
	L.warmup_trigger_2 = "Si estos falsos campeones no me entregan la égida por propia voluntad... ¡será mía cuando mueran!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "esES")
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

L = BigWigs:NewBossLocale("Karazhan Trash", "esES")
if L then
	-- Opera Event
	L.custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de Barnes para comenzar el encuentro de la Sala de Ópera."
	L.opera_hall_wikket_story_text = "Sala de la Ópera: Makaku"
	L.opera_hall_wikket_story_trigger = "¡Cierra el piko" -- ¡Cierra el piko, miko dramas! ¡El Rey Mono domina el panorama! / Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Sala de la Ópera: Historia de Poniente"
	L.opera_hall_westfall_story_trigger = "conoceremos a dos amantes" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Sala de la Ópera: Bella Bestia"
	L.opera_hall_beautiful_beast_story_trigger = "una historia de amor y rabia" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

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

L = BigWigs:NewBossLocale("Moroes", "esES")
if L then
	L.cc = "Control de masas"
	L.cc_desc = "Temporizadores y alertas de control de masas en los invitados de la cena."
end

L = BigWigs:NewBossLocale("Nightbane", "esES")
if L then
	L.name = "Nocturno"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "esES")
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

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "esES")
if L then
	L.rokmora_first_warmup_trigger = "¿Navarrogg?! ¡Traidor! ¿Osas liderar a los intrusos contra nosotros?"
	L.rokmora_second_warmup_trigger = "Pase lo que pase, pienso disfrutarlo. Rokmora, ¡acaba con ellos!"

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

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "esES")
if L then
	L.hands = "Manos" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "esES")
if L then
	L.guards = "Guardias"
	L.interrupted = "¡%s interrumpió %s (%.1fs restantes)!"
end

L = BigWigs:NewBossLocale("L'ura", "esES")
if L then
	L.warmup_text = "L'ura activada"
	L.warmup_trigger = "Cuánto caos y cuánto tormento... Jamás había sentido algo parecido."
	L.warmup_trigger_2 = "Pero esas reflexiones pueden esperar. Esta entidad debe morir."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "esES")
if L then
	L.custom_on_autotalk_desc = "Selecciona al instante la opción de conversación de Alleria Brisaveloz."
	L.gossip_available = "Conversación disponible"
	L.alleria_gossip_trigger = "¡Venid por aquí!" -- Allerias yell after the first boss is defeated

	L.alleria = "Alleria Brisaveloz"
	L.subjugator = "Subyugador de la Guardia de las Sombras"
	L.voidbender = "Dominadora del Vacío de la Guardia de las Sombras"
	L.conjurer = "Conjuradora de la Guardia de las Sombras"
	L.weaver = "Gran tejesombras"
end

-- The Arcway

L = BigWigs:NewBossLocale("The Arcway Trash", "esES")
if L then
	L.anomaly = "Anomalía Arcana"
	L.shade = "Sombra de distorsión"
	L.wraith = "Espectro de maná Marchito"
	L.blade = "Guardia de cólera hoja mácula"
	L.chaosbringer = "Portador de caos eredar"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "esES")
if L then
	L.kick_combo = "Combo de Patadas"

	L.light_dropped = "%s tiró la Luz."
	L.light_picked = "%s cogió la Luz."

	L.warmup_trigger = "Ya tengo lo que quería, pero me he quedado para poder acabar con vosotros... de una vez por todas."
	L.warmup_trigger_2 = "Y ahora, habéis caído en mi trampa. A ver cómo os desenvolvéis en la oscuridad."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "esES")
if L then
	L.warmup_trigger = "Serviré a mi gente: ¡los exiliados y los agravados!"
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "esES")
if L then
	L.infester = "Infestador jurapenas"
	L.myrmidon = "Mirmidón jurapenas"
	L.fury = "Furia imbuida de vileza"
	L.mother = "Madre hedionda"
	L.illianna = "Bailarina de hojas Illiana"
	L.mendacius = "Señor del Terror Mendacius"
	L.grimhorn = "Cuernomacabro el Esclavista"
end
