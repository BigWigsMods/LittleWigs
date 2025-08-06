-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "frFR")
if L then
	L.tugar = "Tugar Totem-de-Sang"
	L.jormog = "Jormog le Béhémoth"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "frFR")
if L then
	L.name = "Raëst Magelance"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "frFR")
if L then
	L.name = "Généralissime Kruul"
	L.inquisitor = "Inquisiteur Variss"
	L.velen = "Prophète Velen"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "frFR")
if L then
	L.erdris = "Seigneur Erdris Epine"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	L.mage = "Mage ressuscité corrompu"
	L.soldier = "Soldat ressuscité corrompu"
	L.arbalest = "Arbalestrier ressuscité corrompu"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "frFR")
if L then
	L.name = "Archimage Xylem"
	L.corruptingShadows = "Ombres corruptrices"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "frFR")
if L then
	L.name = "Agatha"
	L.imp_servant = "Diablotin serviteur"
	L.fuming_imp = "Diablotin furieux"
	L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	--L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	--L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	L.stacks = "Cumuls"
end

L = BigWigs:NewBossLocale("Sigryn", "frFR")
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Voyant des runes Faljar"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "frFR")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold."
	--L.keeper = "Portal Keeper"
	--L.guardian = "Portal Guardian"
	--L.infernal = "Blazing Infernal"
end

L = BigWigs:NewBossLocale("Thalena", "frFR")
if L then
	--L.essence = "Essence"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "frFR")
if L then
	L.ghostly_retainer = "Factotum fantomatique"
	L.ghostly_protector = "Protecteur fantomatique"
	L.ghostly_councilor = "Conseiller fantomatique"
	L.lord_etheldrin_ravencrest = "Seigneur Etheldrin Corvaltus"
	L.lady_velandras_ravencrest = "Dame Velandras Corvaltus"
	L.rook_spiderling = "Jeune araignée du Freux"
	L.soultorn_champion = "Champion écorchâme"
	L.risen_scout = "Eclaireur ressuscité"
	L.risen_archer = "Archère ressuscitée"
	L.risen_arcanist = "Arcaniste ressuscité"
	L.wyrmtongue_scavenger = "Pillard langue-de-wyrm"
	L.bloodscent_felhound = "Gangrechien piste-sang"
	L.felspite_dominator = "Dominateur gangrefiel"
	L.risen_swordsman = "Epéiste ressuscité"
	L.risen_lancer = "Lancier ressuscité"

	--L.door_open_desc = "Show a bar indicating when the door is opened to the Hidden Passageway."
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "frFR")
if L then
	--L.phase_2_trigger = "Enough! I tire of this."
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "frFR")
if L then
	--L.custom_on_time_lost = "Time lost during Shadow Fade"
	--L.custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "frFR")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "frFR")
if L then
	L.dulzak = "Dul'zak"
	--L.wrathguard = "Wrathguard Invader"
	L.felguard = "Destructeur gangregarde"
	L.soulmender = "Soigne-âme feu-d'enfer"
	L.temptress = "Tentatrice feu-d'enfer"
	L.botanist = "Botaniste gangrenuit"
	L.orbcaster = "Lance-orbe gangrerôdeur"
	L.waglur = "Wa'glur"
	L.scavenger = "Pillard langue-de-wyrm"
	L.gazerax = "Scrutax"
	L.vilebark = "Marcheur vilécorce"

	--L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "frFR")
if L then
	L.duskwatch_sentry = "Factionnaire de la Garde crépusculaire"
	L.duskwatch_reinforcement = "Renfort de la Garde crépusculaire"
	L.Guard = "Vigile de la Garde crépusculaire"
	L.Construct = "Assemblage gardien"
	L.Enforcer = "Massacreur gangre-lié"
	L.Hound = "Molosse de la Légion"
	L.Mistress = "Maîtresse de l’ombre"
	L.Gerenth = "Gerenth le Vil"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Savatr’anshé"
	L.Baalgar = "Baalgar le Vigilant"
	L.Inquisitor = "Inquisiteur vigilant"
	L.BlazingImp = "Diablotin flamboyant"
	L.Energy = "Energie liée"
	L.Manifestation = "Manifestation arcanique"
	L.Wyrm = "Wyrm de mana"
	L.Arcanist = "Arcaniste de la Garde crépusculaire"
	L.InfernalImp = "Diablotin infernal"
	L.Malrodi = "Arcaniste Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Clés arcaniques"
	L.clues = "Indices"

	L.InfernalTome = "Tome infernal"
	L.MagicalLantern = "Lanterne magique"
	L.NightshadeRefreshments = "Rafraîchissements de belladone"
	L.StarlightRoseBrew = "Infusion de rose lumétoile"
	L.UmbralBloom = "Floraison ombreuse"
	L.WaterloggedScroll = "Parchemin détrempé"
	L.BazaarGoods = "Marchandises de bazar"
	L.LifesizedNightborneStatue = "Statue de sacrenuit à échelle réelle"
	L.DiscardedJunk = "Camelote abandonnée"
	L.WoundedNightborneCivilian = "Civil sacrenuit blessé"

	L.announce_buff_items = "Annoncer les objets de buff"
	L.announce_buff_items_desc = "Annonce tous les objets de buff disponibles du donjon et qui peut les utiliser."

	L.available = "%s|cffffffff%s|r disponible" -- Context: item is available to use
	L.usableBy = "utilisable par %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Utiliser instantanément les objets de buff"
	L.custom_on_use_buff_items_desc = "Activer cette option pour utiliser instantanément les objets de buff du donjon. Ceci n'utilisera pas les objets qui attirent les gardes avant le 2ème boss."

	L.spy_helper = "Aide évènement espion"
	L.spy_helper_desc = "Affiche une boîte d'info avec tous les indices que votre groupe a récolté concernant l'espion. Les indices seront également envoyés aux membres de votre groupe dans la discussion."

	L.clueFound = "Indice trouvé (%d/5) : |cffffffff%s|r"
	L.spyFound = "Espion trouvé par %s !"
	L.spyFoundChat = "J'ai trouvé l'espion !"
	L.spyFoundPattern = "allez pas trop vite en besogne" -- Allons, [playername]. N’allez pas trop vite en besogne. Et si vous me suiviez, que nous puissions en parler en privé ?

	L.hints[1] = "Cape"
	L.hints[2] = "Pas de cape"
	L.hints[3] = "Sacoche"
	L.hints[4] = "Potions"
	L.hints[5] = "Manches longues"
	L.hints[6] = "Manches courtes"
	L.hints[7] = "Gants"
	L.hints[8] = "Pas de gants"
	L.hints[9] = "Homme"
	L.hints[10] = "Femme"
	L.hints[11] = "Gilet clair"
	L.hints[12] = "Gilet sombre"
	L.hints[13] = "Pas de potions"
	L.hints[14] = "Livre"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "frFR")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "frFR")
if L then
	--L.archdruid_glaidalis_warmup_trigger = "Defilers... I can smell the Nightmare in your blood. Be gone from these woods or suffer nature's wrath!"

	L.mindshattered_screecher = "Hurleur esprit-brisé"
	L.dreadsoul_ruiner = "Dévastateur âmeffroi"
	L.dreadsoul_poisoner = "Empoisonneur âmeffroi"
	L.crazed_razorbeak = "Bec-rasoir affolé"
	L.festerhide_grizzly = "Grizzly peau-putride"
	L.vilethorn_blossom = "Floraison vileronce"
	L.rotheart_dryad = "Dryade cœur-putride"
	L.rotheart_keeper = "Gardien cœur-putride"
	L.nightmare_dweller = "Habitant du Cauchemar"
	L.bloodtainted_fury = "Fureur sang-vicié"
	L.bloodtainted_burster = "Irruption sang-vicié"
	L.taintheart_summoner = "Invocateur cœur-corrompu"
	L.dreadfire_imp = "Diablotin brûle-effroi"
	L.tormented_bloodseeker = "Cherche-sang tourmenté"
end

L = BigWigs:NewBossLocale("Oakheart", "frFR")
if L then
	--L.throw = "Throw"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "frFR")
if L then
	L.wrangler = "Querelleur glissefiel"
	L.stormweaver = "Tisse-tempête glissefiel"
	L.crusher = "Ecraseur glissefiel"
	L.oracle = "Oracle glissefiel"
	L.siltwalker = "Marche-vase de Mak’rana"
	L.tides = "Courant agité"
	L.arcanist = "Arcaniste glissefiel"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "frFR")
if L then
	--L.custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning"
	--L.custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r."

	--L.water_safe = "%s (water is safe)"
	--L.land_safe = "%s (land is safe)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "frFR")
if L then
	--L.gossip_available = "Gossip available"
	--L.gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand."

	--L[197963] = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	--L[197964] = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	--L[197965] = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	--L[197966] = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	--L[197967] = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "frFR")
if L then
	--L.warmup_text = "God-King Skovald Active"
	--L.warmup_trigger = "The vanquishers have already taken possession of it, Skovald, as was their right. Your protest comes too late."
	--L.warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "frFR")
if L then
	L.mug_of_mead = "Chope d'hydromel"
	L.valarjar_thundercaller = "Mande-tonnerre valarjar"
	L.storm_drake = "Drake-tempête"
	L.stormforged_sentinel = "Sentinelle forge-foudre"
	L.valarjar_runecarver = "Runomancien valarjar"
	L.valarjar_mystic = "Mystique valarjar"
	L.valarjar_purifier = "Purificateur valarjar"
	L.valarjar_shieldmaiden = "Vierge guerrière valarjar"
	L.valarjar_aspirant = "Aspirante valarjar"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr l’Éclairé"
	L.valarjar_marksman = "Tireuse d’élite valarjar"
	L.gildedfur_stag = "Cerf fourrure-dorée"
	L.angerhoof_bull = "Taureau sabot-furieux"
	L.valarjar_trapper = "Trappeur valarjar"
	L.fourkings = "Les quatre rois"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "frFR")
if L then
	-- Opera Event
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "Opéra : Lokdu"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Opéra : De l’amour à la mer"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Opéra : La belle bête"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Philanthrope fantomatique"
	L.skeletal_usher = "Ouvreur squelettique"
	L.spectral_attendant = "Domestique spectral"
	L.spectral_valet = "Valet spectral"
	L.spectral_retainer = "Factotum spectral"
	L.phantom_guardsman = "Garde fantôme"
	L.wholesome_hostess = "Hôtesse saine"
	L.reformed_maiden = "Damoiselle repentie"
	L.spectral_charger = "Destrier spectral"

	-- Return to Karazhan: Upper
	L.chess_event = "Évènement de l’échiquier"
	L.king = "Roi"
end

L = BigWigs:NewBossLocale("Moroes", "frFR")
if L then
	L.cc = "Contrôle des foules"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "frFR")
if L then
	L.name = "Plaie-de-Nuit"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "frFR")
if L then
	L.soulguard = "Garde des âmes saumâtre"
	L.champion = "Champion helarjar"
	L.mariner = "Marin de la garde de nuit"
	L.swiftblade = "Vivelame maudit par les flots"
	L.mistmender = "Soignebrume maudite par les flots"
	L.mistcaller = "Mandebrume helarjar"
	L.skjal = "Skjal"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "frFR")
if L then
	--L.rokmora_first_warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	--L.rokmora_second_warmup_trigger = "Either way, I will enjoy every moment of it. Rokmora, crush them!"

	L.vileshard_crawler = "Rampante vil-éclat"
	L.tarspitter_lurker = "Rôdeur crache-goudron"
	L.rockback_gnasher = "Mâcheur pierre-peau"
	L.vileshard_hulk = "Mastodonte vil-éclat"
	L.vileshard_chunk = "Bris vil-éclat"
	L.understone_drummer = "Batteur pierre-basse"
	L.mightstone_breaker = "Briseur pierre-puissance"
	L.blightshard_shaper = "Sculpteur éclat-chancreux"
	L.stoneclaw_grubmaster = "Maître des larves pierre-griffe"
	L.tarspitter_grub = "Larve crache-goudron"
	L.rotdrool_grabber = "Saisisseur bave-pourrie"
	L.understone_demolisher = "Démolisseur pierre-basse"
	L.rockbound_trapper = "Trappeur pierre-lié"
	L.emberhusk_dominator = "Dominateur braise-chitine"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "frFR")
if L then
	--L.hands = "Hands" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "frFR")
if L then
	--L.guards = "Guards"
	--L.interrupted = "%s interrupted %s (%.1fs left)!"
end

L = BigWigs:NewBossLocale("L'ura", "frFR")
if L then
	--L.warmup_text = "L'ura Active"
	--L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	--L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "frFR")
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

L = BigWigs:NewBossLocale("The Arcway Trash", "frFR")
if L then
	L.anomaly = "Anomalie arcanique"
	L.shade = "Ombre dimensionnelle"
	L.wraith = "Ame en peine de mana flétrie"
	L.blade = "Gangrelame garde-courroux"
	L.chaosbringer = "Porte-chaos érédar"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "frFR")
if L then
	--L.kick_combo = "Kick Combo"

	--L.light_dropped = "%s dropped the Light."
	--L.light_picked = "%s picked up the Light."

	--L.warmup_trigger = "I have what I was after. But I stayed just so that I could put an end to you... once and for all!"
	--L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "frFR")
if L then
	--L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "frFR")
if L then
	--L.infester = "Felsworn Infester"
	--L.myrmidon = "Felsworn Myrmidon"
	--L.fury = "Fel-Infused Fury"
	--L.mother = "Foul Mother"
	--L.illianna = "Blade Dancer Illianna"
	--L.mendacius = "Dreadlord Mendacius"
	--L.grimhorn = "Grimhorn the Enslaver"
end
