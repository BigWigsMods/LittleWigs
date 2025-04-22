-- End Time

local L = BigWigs:NewBossLocale("Echo of Baine", "deDE")
if not L then return end
if L then
	L.totemDrop = "Totem fallen gelassen"
	L.totemThrow = "Totem von %s geworfen"
end

-- Grim Batol

L = BigWigs:NewBossLocale("Erudax", "deDE")
if L then
	L.summon = "Gesichtslosen Verschlinger beschwören"
	L.summon_desc = "Warnen wenn Erudax einen Gesichtslosen Verschlinger beschwört."
	L.summon_message = "Gesichtsloser Verschlinger beschworen"
	L.summon_trigger = "beschwört einen"
end

L = BigWigs:NewBossLocale("Grim Batol Trash", "deDE")
if L then
	L.twilight_earthcaller = "Zwielichterdruferin"
	L.twilight_brute = "Zwielichtschläger"
	L.twilight_destroyer = "Zwielichtzerstörer"
	L.twilight_overseer = "Zwielichtvorarbeiter"
	L.twilight_beguiler = "Zwielichtbetörer"
	L.molten_giant = "Geschmolzener Riese"
	L.twilight_warlock = "Zwielichthexenmeister"
	L.twilight_flamerender = "Zwielichtflammenreißer"
	L.twilight_lavabender = "Zwielichtlavawirker"
	L.faceless_corruptor = "Gesichtsloser Verschlinger"
end

-- Hour of Twilight

L = BigWigs:NewBossLocale("The Hour of Twilight Trash", "deDE")
if L then
	L.custom_on_autotalk_desc = "Direkt Thralls Dialogoptionen auswählen."
end

-- Lost City of the Tol'vir

L = BigWigs:NewBossLocale("Siamat", "deDE")
if L then
	L.servant = "Diener von Siamat beschwören"
	L.servant_desc = "Warnt, wenn ein Diener von Siamat beschworen wird."
end

-- Shadowfang Keep

L = BigWigs:NewBossLocale("Lord Walden", "deDE")
if L then
	-- %s will be either "Toxic Coagulant" or "Toxic Catalyst"
	L.coagulant = "%s: Bewegen zum Verbannen"
	L.catalyst = "%s: Krit Buff"
	L.toxin_healer_message = "%s: DoT auf allen"
end

-- The Stonecore

L = BigWigs:NewBossLocale("Corborus", "deDE")
if L then
	L.burrow = "Auf-/Abtauchen"
	L.burrow_desc = "Warnt, wenn Corborus auf- oder abtaucht."
	L.burrow_message = "Corborus taucht ab!"
	L.burrow_warning = "Abtauchen in 5 sek!"
	L.emerge_message = "Corborus taucht auf!"
	L.emerge_warning = "Auftauchen in 5 sek!"
end

-- Throne of the Tides

L = BigWigs:NewBossLocale("Throne of the Tides Trash", "deDE")
if L then
	L.nazjar_oracle = "Orakel der Naz'jar"
	L.vicious_snap_dragon = "Boshaftes Löwenmäulchen"
	L.nazjar_sentinel = "Schildwache der Naz'jar"
	L.nazjar_ravager = "Verheerer der Naz'jar"
	L.nazjar_tempest_witch = "Sturmhexe der Naz'jar"
	L.faceless_seer = "Gesichtsloser Seher"
	L.faceless_watcher = "Gesichtsloser Beobachter"
	L.tainted_sentry = "Besudelter Wachposten"

	L.ozumat_warmup_trigger = "Die Bestie ist zurück! Das Wasser darf nicht verschmutzt werden!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "deDE")
if L then
	L.high_tide_trigger1 = "Zu den Waffen, meine Diener! Entsteigt den eisigen Tiefen!"
	L.high_tide_trigger2 = "Vernichtet die Eindringlinge! Überlasst sie den Großen Dunklen Weiten!"
end

-- The Vortex Pinnacle

L = BigWigs:NewBossLocale("The Vortex Pinnacle Trash", "deDE")
if L then
	L.armored_mistral = "Gepanzerter Mistral"
	L.gust_soldier = "Windstoßsoldat"
	L.wild_vortex = "Wilder Vortex"
	L.lurking_tempest = "Lauernder Sturm"
	L.cloud_prince = "Wolkenprinz"
	L.turbulent_squall = "Turbulente Böe"
	L.empyrean_assassin = "Himmelsattentäter"
	L.young_storm_dragon = "Junger Sturmdrache"
	L.executor_of_the_caliph = "Exekutor des Kalifen"
	L.temple_adept = "Tempeladept"
	L.servant_of_asaad = "Diener von Asaad"
	L.minister_of_air = "Priester der Lüfte"
end

-- Well of Eternity

L = BigWigs:NewBossLocale("Well Of Eternity Trash", "deDE")
if L then
	L.custom_on_autotalk_desc = "Wählt direkt Illidans Sprachoption zum Beginn des Kampfes."
end

-- Zul'Aman

L = BigWigs:NewBossLocale("Daakara", "deDE")
if L then
	L[42594] = "Bärenform" -- short form for "Essence of the Bear"
	L[42607] = "Fuchsform"
	L[42606] = "Adlerform"
	L[42608] = "Drachenfalkenform"
end

L = BigWigs:NewBossLocale("Halazzi", "deDE")
if L then
	L.spirit_message = "Geisterphase"
	L.normal_message = "Normale Phase"
end

L = BigWigs:NewBossLocale("Nalorakk", "deDE")
if L then
	L.troll_message = "Trollform"
	L.troll_trigger = "Macht Platz für Nalorakk!"
end

-- Zul'Gurub

L = BigWigs:NewBossLocale("Jin'do the Godbreaker", "deDE")
if L then
	L.barrier_down_message = "Barriere gebrochen, %d verbleibend" -- short name for "Brittle Barrier" (97417)
end
