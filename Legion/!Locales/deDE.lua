-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "deDE")
if L then
	L.tugar = "Tugar Bluttotem"
	L.jormog = "Jormog das Ungetüm"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "deDE")
if L then
	L.name = "Raest Magusspeer"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "deDE")
if L then
	L.name = "Hochlord Kruul"
	L.inquisitor = "Inquisitor Variss"
	L.velen = "Prophet Velen"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "deDE")
if L then
	L.erdris = "Lord Erdris Dorn"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Verderbter auferstandener Magier"
	L.soldier = "Verderbter auferstandener Soldat"
	L.arbalest = "Verderbte auferstandene Armbrustschützin"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "deDE")
if L then
	L.name = "Erzmagier Xylem"
	L.corruptingShadows = "Verderbende Schatten"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "deDE")
if L then
	L.name = "Agatha"
	L.imp_servant = "Wichteldiener"
	L.fuming_imp = "Rauchender Wichtel"
	L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	--L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	--L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.stacks = "Stapel"
end

L = BigWigs:NewBossLocale("Sigryn", "deDE")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Runenseher Faljar"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "deDE")
if L then
	L.custom_on_autotalk_desc = "Wählt direkt Leutnant Sinclaris Dialogoption zum Starten des Sturms auf die Violette Festung."
	L.keeper = "Portalhüter"
	L.guardian = "Portalwächter"
	L.infernal = "Lodernde Höllenbestie"
end

L = BigWigs:NewBossLocale("Thalena", "deDE")
if L then
	L.essence = "Essenz"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "deDE")
if L then
	L.ghostly_retainer = "Geisterhafter Gefolgsmann"
	L.ghostly_protector = "Geisterhafter Beschützer"
	L.ghostly_councilor = "Geisterhafter Berater"
	L.lord_etheldrin_ravencrest = "Lord Etheldrin Rabenkrone"
	L.lady_velandras_ravencrest = "Lady Velandras Rabenkrone"
	L.rook_spiderling = "Rabenspinnling"
	L.soultorn_champion = "Seelengeschändeter Champion"
	L.risen_scout = "Auferstandener Späher"
	L.risen_archer = "Auferstandene Bogenschützin"
	L.risen_arcanist = "Auferstandener Arkanist"
	L.wyrmtongue_scavenger = "Wyrmzungenplünderer"
	L.bloodscent_felhound = "Blutwitternder Teufelshund"
	L.felspite_dominator = "Teufelsgrollunterwerfer"
	L.risen_swordsman = "Auferstandener Schwertkämpfer"
	L.risen_lancer = "Auferstandener Lanzer"

	L.door_open_desc = "Zeigt eine Leiste wann die Tür zum versteckten Durchgang geöffnet ist."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "deDE")
if L then
	L.phase_2_trigger = "Es reicht! Genug der Scharade."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "deDE")
if L then
	L.custom_on_time_lost = "Verlorene Zeit während Schattenverblassen"
	L.custom_on_time_lost_desc = "Zeigt die verlorene Zeit während Schattenverblassen in der Leiste in |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "deDE")
if L then
	L.custom_on_autotalk_desc = "Wählt direkt Aegis von Aggramars Dialogoption um den Kampf gegen Domatrax zu starten."

	L.missing_aegis = "Du stehst nicht im Aegis" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "Aegis: Reduzierte Heilung"
	L.aegis_damage = "Aegis: Reduzierter verursachter Schaden"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "deDE")
if L then
	L.dulzak = "Dul'zak"
	L.wrathguard = "Einfallender Zornwächter"
	L.felguard = "Zerstörer der Teufelswache"
	L.soulmender = "Höllenglutseelenheiler"
	L.temptress = "Höllenglutverführerin"
	L.botanist = "Teufelsgeborene Botanikerin"
	L.orbcaster = "Sphärenwirker der Teufelsschreiter"
	L.waglur = "Wa'glur"
	L.scavenger = "Wyrmzungenplünderer"
	L.gazerax = "Gazerax"
	L.vilebark = "Übelrindenläufer"

	L.throw_tome = "Folianten werfen" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "deDE")
if L then
	L.duskwatch_sentry = "Wächter der Dämmerwache"
	L.duskwatch_reinforcement = "Verstärkung der Dämmerwache"
	L.Guard = "Wachposten der Dämmerwache"
	L.Construct = "Wächterkonstrukt"
	L.Enforcer = "Dämonenversklavte Vollstreckerin"
	L.Hound = "Legionshund"
	L.Mistress = "Schattenmeisterin"
	L.Gerenth = "Verdächtiger Adliger"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Imacu'tya"
	L.Baalgar = "Baalgar der Wachsame"
	L.Inquisitor = "Wachsamer Inquisitor"
	L.BlazingImp = "Lodernder Wichtel"
	L.Energy = "Gebundene Energie"
	L.Manifestation = "Arkane Manifestation"
	L.Wyrm = "Manawyrm"
	L.Arcanist = "Arkanist der Dämmerwache"
	L.InfernalImp = "Höllenwichtel"
	L.Malrodi = "Arkanistin Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Arkane Schlüssel"
	L.clues = "Hinweise"

	L.InfernalTome = "Höllischer Foliant"
	L.MagicalLantern = "Magische Laterne"
	L.NightshadeRefreshments = "Nachtschattenerfrischungen"
	L.StarlightRoseBrew = "Sternlichtrosenbräu"
	L.UmbralBloom = "Umbralblüte"
	L.WaterloggedScroll = "Durchnässte Schriftrolle"
	L.BazaarGoods = "Basarwaren"
	L.LifesizedNightborneStatue = "Lebensgroße Nachtgeborenenstatue"
	L.DiscardedJunk = "Ausrangierter Schrott"
	L.WoundedNightborneCivilian = "Verwundeter Zivilist der Nachtgeborenen"

	L.announce_buff_items = "Buff-Items bekanntgeben"
	L.announce_buff_items_desc = "Gibt bekannt, welche verfügbaren Buff-Items in der Instanz vorhanden sind und wer sie benutzen kann."

	L.available = "%s|cffffffff%s|r vorhanden" -- Context: item is available to use
	L.usableBy = "benutzbar von %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Buff-Items sofort benutzen"
	L.custom_on_use_buff_items_desc = "Durch die Aktivierung dieser Option werden die Buff-Items beim anklicken sofort benutzt, ausgenommen derjenigen, die eine der drei Botschafter des zweiten Bosses rufen."

	L.spy_helper = "Spion Event Helfer"
	L.spy_helper_desc = "Zeigt eine Infobox mit allen Hinweisen über den Spion an. Diese Hinweise werden ebenfalls im Chat an deine Gruppe geschickt."

	L.clueFound = "Hinweise gefunden (%d/5): |cffffffff%s|r"
	L.spyFound = "Der Spion wurde von %s gefunden!"
	L.spyFoundChat = "Ich habe den Spion gefunden!"
	L.spyFoundPattern = "Na, na, wir wollen doch nicht voreilig sein" -- Na, na, wir wollen doch nicht voreilig sein, [player]. Wieso folgt Ihr mir nicht, damit wir in etwas privaterer Umgebung darüber sprechen können...

	L.hints[1] = "Umhang"
	L.hints[2] = "Kein Umhang"
	L.hints[3] = "Geldbeutel"
	L.hints[4] = "Fläschchen"
	L.hints[5] = "Lange Ärmel"
	L.hints[6] = "Kurze Ärmel"
	L.hints[7] = "Handschuhe"
	L.hints[8] = "Keine Handschuhe"
	L.hints[9] = "Männlich"
	L.hints[10] = "Weiblich"
	L.hints[11] = "Helle Weste"
	L.hints[12] = "Dunkle Weste"
	L.hints[13] = "Kein Fläschchen"
	L.hints[14] = "Buch"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "deDE")
if L then
	L.warmup_trigger = "Eine weitere Fehlleistung, Melandrus. Aber Ihr könnt es wiedergutmachen. Vernichtet die Eindringlinge. Ich muss zurück zur Nachtfestung."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "deDE")
if L then
	L.archdruid_glaidalis_warmup_trigger = "Entweiher... ich wittere den Alptraum in Eurem Blut. Verschwindet aus diesem Wald oder spürt den Zorn der Natur!"

	L.mindshattered_screecher = "Gebrochener Kreischer"
	L.dreadsoul_ruiner = "Verheerer der Schreckensseele"
	L.dreadsoul_poisoner = "Vergifter der Schreckensseele"
	L.crazed_razorbeak = "Wahnsinniger Klingenschnabel"
	L.festerhide_grizzly = "Eiterpelzgrizzly"
	L.vilethorn_blossom = "Garststachelblüte"
	L.rotheart_dryad = "Moderherzdryade"
	L.rotheart_keeper = "Moderherzbewahrer"
	L.nightmare_dweller = "Alptraumbewohner"
	L.bloodtainted_fury = "Blutbesudelter Zornbrodler"
	L.bloodtainted_burster = "Blutbesudelter Sprudler"
	L.taintheart_summoner = "Pestherzbeschwörer"
	L.dreadfire_imp = "Schreckensfeuerwichtel"
	L.tormented_bloodseeker = "Gequälter Blutsucher"
end

L = BigWigs:NewBossLocale("Oakheart", "deDE")
if L then
	L.throw = "Wurf"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "deDE")
if L then
	L.wrangler = "Zänker der Hassnattern"
	L.stormweaver = "Sturmwirkerin der Hassnattern"
	L.crusher = "Zermalmer der Hassnattern"
	L.oracle = "Orakel der Hassnattern"
	L.siltwalker = "Treibsandläufer der Mak'rana"
	L.tides = "Aufgewühlte Fluten"
	L.arcanist = "Arkanistin der Hassnattern"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "deDE")
if L then
	L.custom_on_show_helper_messages = "Hinweis für Statische Nova und Gebündelter Blitz"
	L.custom_on_show_helper_messages_desc = "Wenn diese Option aktiviert ist, wird ein Hinweis angezeigt, welcher beinhaltet ob das Wasser oder Land sicher ist wenn der Boss |cff71d5ffStatische Nova|r oder |cff71d5ffGebündelter Blitz|r wirkt."

	L.water_safe = "%s (Wasser ist sicher)"
	L.land_safe = "%s (Land ist sicher)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "deDE")
if L then
	L.gossip_available = "Dialog verfügbar"
	L.gossip_trigger = "Höchst beeindruckend! Ich hielt die Kräfte der Valarjar stets für unerreicht... und dennoch steht Ihr hier vor mir."

	L[197963] = "|cFF800080Oben rechts|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500Unten rechts|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00Unten links|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FFOben links|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000Oben|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "deDE")
if L then
	L.warmup_text = "Gottkönig Skovald aktiv"
	L.warmup_trigger = "Die Sieger haben ihren Anspruch geltend gemacht, Skovald, wie es ihr Recht ist. Euer Protest kommt zu spät."
	L.warmup_trigger_2 = "Wenn sie die Aegis nicht aus freien Stücken übergeben... dann soll ihr Tod mir diesen Dienst erweisen!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "deDE")
if L then
	L.mug_of_mead = "Metkrug"
	L.valarjar_thundercaller = "Donnerrufer der Valarjar"
	L.storm_drake = "Sturmdrache"
	L.stormforged_sentinel = "Sturmgeschmiedeter Wächter"
	L.valarjar_runecarver = "Runenmetz der Valarjar"
	L.valarjar_mystic = "Mystiker der Valarjar"
	L.valarjar_purifier = "Läuterer der Valarjar"
	L.valarjar_shieldmaiden = "Schildmaid der Valarjar"
	L.valarjar_aspirant = "Aspirantin der Valarjar"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr der Erleuchtete"
	L.valarjar_marksman = "Schützin der Valarjar"
	L.gildedfur_stag = "Goldfellhirsch"
	L.angerhoof_bull = "Zornhufbulle"
	L.valarjar_trapper = "Fallensteller der Valarjar"
	L.fourkings = "Die Vier Könige"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "deDE")
if L then
	-- Opera Event
	L.custom_on_autotalk_desc = "Wählt direkt Barnes' Dialogoption zum Starten des Bosskampfes im Opernsaal."
	L.opera_hall_wikket_story_text = "Opernsaal: Wikket"
	L.opera_hall_wikket_story_trigger = "Halt die Gotsche" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Opernsaal: Westfall Story"
	L.opera_hall_westfall_story_trigger = "treffen wir auf zwei Liebende" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Opernsaal: Das schöne Biest"
	L.opera_hall_beautiful_beast_story_trigger = "eine Geschichte von Romantik und Wut" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Geisterhafter Philanthrop"
	L.skeletal_usher = "Skelettpförtner"
	L.spectral_attendant = "Spektraler Knecht"
	L.spectral_valet = "Spektraldiener"
	L.spectral_retainer = "Spektraler Anhänger"
	L.phantom_guardsman = "Phantomgardist"
	L.wholesome_hostess = "Sittsame Schankmaid"
	L.reformed_maiden = "Reformierte Jungfer"
	L.spectral_charger = "Spektrales Streitross"

	-- Return to Karazhan: Upper
	L.chess_event = "Das Schachspiel"
	L.king = "König"
end

L = BigWigs:NewBossLocale("Moroes", "deDE")
if L then
	L.cc = "Massenkontrolle"
	L.cc_desc = "Timer und Warnungen für die Massenkontrolle auf den Essensgästen."
end

L = BigWigs:NewBossLocale("Nightbane", "deDE")
if L then
	L.name = "Schrecken der Nacht"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "deDE")
if L then
	L.soulguard = "Aufgedunsene Seelenwache"
	L.champion = "Champion der Helarjar"
	L.mariner = "Matrosennachtwächter"
	L.swiftblade = "Meeresfluchschnellklinge"
	L.mistmender = "Meeresfluchnebelheilerin"
	L.mistcaller = "Nebelruferin der Helarjar"
	L.skjal = "Skjal"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "deDE")
if L then
	L.rokmora_first_warmup_trigger = "Navarrogg?! Verräter! Ihr führt diese Eindringlinge gegen uns ins Feld?!"
	L.rokmora_second_warmup_trigger = "Sei's drum, ich werde jeden Moment davon genießen. Rokmora, zerschmettert sie!"

	L.vileshard_crawler = "Ekelsplitterkriecher"
	L.tarspitter_lurker = "Teerspuckerlauerer"
	L.rockback_gnasher = "Steinrückenknirscher"
	L.vileshard_hulk = "Ekelsplittergigant"
	L.vileshard_chunk = "Ekelsplitterbrocken"
	L.understone_drummer = "Hämmerer des Tiefgesteins"
	L.mightstone_breaker = "Machtsteinbrecher"
	L.blightshard_shaper = "Pestsplitterformer"
	L.stoneclaw_grubmaster = "Steinklauenlarvenmeister"
	L.tarspitter_grub = "Teerspuckerlarve"
	L.rotdrool_grabber = "Rottspeichelschnapper"
	L.understone_demolisher = "Demolierer des Tiefgesteins"
	L.rockbound_trapper = "Steingebundener Fallensteller"
	L.emberhusk_dominator = "Glutpanzerdominator"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "deDE")
if L then
	L.hands = "Hände" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "deDE")
if L then
	L.guards = "Hüter"
	L.interrupted = "%s unterbrach %s (%.1fs übrig)!"
end

L = BigWigs:NewBossLocale("L'ura", "deDE")
if L then
	L.warmup_text = "L'ura aktiv"
	L.warmup_trigger = "Dieses Chaos... diese Qualen. Etwas Derartiges habe ich noch nie gespürt."
	L.warmup_trigger_2 = "Derlei Gedanken können jetzt warten. Dieses Wesen muss sterben."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "deDE")
if L then
	L.custom_on_autotalk_desc = "Wählt direkt Alleria Windläufers Dialogoption."
	L.gossip_available = "Dialog verfügbar"
	L.alleria_gossip_trigger = "Folgt mir!" -- Allerias yell after the first boss is defeated

	L.alleria = "Alleria Windläufer"
	L.subjugator = "Unterwerfer der Schattenwache"
	L.voidbender = "Leerenformer der Schattenwache"
	L.conjurer = "Beschwörer der Schattenwache"
	L.weaver = "Großschattenwirker"
end

-- The Arcway

L = BigWigs:NewBossLocale("The Arcway Trash", "deDE")
if L then
	L.anomaly = "Arkananomalie"
	L.shade = "Warpschemen"
	L.wraith = "Verdorrtes Managespenst"
	L.blade = "Teufelsklinge der Zornwächter"
	L.chaosbringer = "Chaosbringer der Eredar"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "deDE")
if L then
	L.kick_combo = "Kick Combo"

	L.light_dropped = "%s hat das Licht fallen gelassen."
	L.light_picked = "%s hat das Licht aufgenommen."

	L.warmup_trigger = "Ich habe, wofür ich gekommen bin. Doch ich wollte Euch noch persönlich ein Ende setzen... ein für alle Mal."
	L.warmup_trigger_2 = "Und jetzt sitzt Ihr Narren in meiner Falle. Sehen wir mal, wie Ihr im Dunkeln zurechtkommt."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "deDE")
if L then
	L.warmup_trigger = "Ich diene MEINEM Volk, den Vertriebenen und Verstoßenen."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "deDE")
if L then
	L.infester = "Verseucher des Dämonenpakts"
	L.myrmidon = "Myrmidone des Dämonenpakts"
	L.fury = "Teufelsberauschter Wüter"
	L.mother = "Üble Mutter"
	L.illianna = "Klingentänzerin Illianna"
	L.mendacius = "Schreckenslord Mendacius"
	L.grimhorn = "Grimmhorn der Versklaver"
end
