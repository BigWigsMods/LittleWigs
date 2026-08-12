-- Altar of Fangs

local L = BigWigs:NewBossLocale("Altar of Fangs Trash", "deDE")
if L then
	L.custom_on_mixture_autotalk_desc = "|cFFFF0000Benötigt 25 Fertigkeitspunkte der Kochkunst von Midnight oder Alchemie von Midnight.|r Wählt automatisch die NSC Dialogoption zur Gewährung des Buffs 'Mutierendes Elixier'.\n\n|T136242:16|tMutierendes Elixier\n{1310012}"
end

-- Delves: Atal'Aman

L = BigWigs:NewBossLocale("Spiritflayer Jin'ma", "deDE")
if L then
	L.spiritflayer_jinma = "Geisterschänder Jin'Ma"
end

-- Delves: Collegiate Calamity

L = BigWigs:NewBossLocale("Hydrangea", "deDE")
if L then
	L.hydrangea = "Hortensie"
end

L = BigWigs:NewBossLocale("Infiltrator Garand", "deDE")
if L then
	L.infiltrator_garand = "Spitzel Garand"
end

L = BigWigs:NewBossLocale("Voidscorned Vagrant", "deDE")
if L then
	L.voidscorned_vagrant = "Leerenverschmähter Landstreicher"
end

-- Delves: Parhelion Plaza

L = BigWigs:NewBossLocale("Gladius Slaurna", "deDE")
if L then
	L.gladius_slaurna = "Gladius Slaurna"
end

-- Delves: Shadowguard Point

L = BigWigs:NewBossLocale("Chief-Arcanist Patram", "deDE")
if L then
	L.chiefarcanist_patram = "Chefarkanist Patram"
end

-- Delves: Sunkiller Sanctum

L = BigWigs:NewBossLocale("Esuritus", "deDE")
if L then
	L.esuritus = "Esuritus"
end

-- Delves: The Darkway

L = BigWigs:NewBossLocale("Infiltrator Gulkat", "deDE")
if L then
	L.infiltrator_gulkat = "Spitzel Gulkat"
end

-- Delves: The Grudge Pit

L = BigWigs:NewBossLocale("Brightthorn", "deDE")
if L then
	L.brightthorn = "Strahldorn"
end

L = BigWigs:NewBossLocale("Gyrospore", "deDE")
if L then
	--L.gyrospore = "Gyrospore"
end

L = BigWigs:NewBossLocale("Mycomight", "deDE")
if L then
	L.mycomight = "Myzelan"
end

-- Delves: The Gulf of Memory

L = BigWigs:NewBossLocale("Lumenia", "deDE")
if L then
	L.lumenia = "Lumenia"
end

L = BigWigs:NewBossLocale("Mul'tha'ul", "deDE")
if L then
	L.multhaul = "Mul'tha'ul"
end

-- Delves: The Shadow Enclave

L = BigWigs:NewBossLocale("Antenorian", "deDE")
if L then
	L.antenorian = "Antenorian"
end

-- Delves: Torment's Rise

L = BigWigs:NewBossLocale("Nullaeus", "deDE")
if L then
	L.nullaeus = "Nullaeus"
end

-- Delves: Twilight Crypts

L = BigWigs:NewBossLocale("Blademaster Darza", "deDE")
if L then
	L.blademaster_darza = "Klingenmeisterin Darza"
end

-- Delves: Venomfall Deeps

L = BigWigs:NewBossLocale("Azta'rec", "deDE")
if L then
	L.aztarec = "Azta'rec"
end

-- Delves: Trash

L = BigWigs:NewBossLocale("Midnight Delve Trash", "deDE")
if L then
	L.nullaeus = "Nullaeus"
end

-- Den of Nalorakk

L = BigWigs:NewBossLocale("Den of Nalorakk Trash", "deDE")
if L then
	L.offerings_acquired = "Gaben erhalten"
	L.offerings_acquired_desc = "Zeigt einen Alarm, wenn eine Gabe erhalten wurde."
end

-- Maisara Caverns

L = BigWigs:NewBossLocale("Maisara Caverns Trash", "deDE")
if L then
	L.prisoners_freed = "Gefangene befreit"
	L.prisoners_freed_desc = "Zeigt einen Alarm, wenn ein Gefangener befreit wurde."
	L.custom_on_cooking_pot_autotalk_desc = "Wählt automatisch die NSC Dialogoption zur Gewährung des Buffs 'Herzhafter Eintopf der Blutfratzen'.\n\n|T4659336:16|tHerzhafter Eintopf der Blutfratzen\n{1269056}"
	L.custom_on_ritual_cauldron_autotalk_desc = "Wählt automatisch die NSC Dialogoption zur Gewährung des Buffs 'Ritualgemisch'.\n\n|T236271:16|tRitualgemisch\n{1271300}"

	L.cooking_pot = "Kochtopf"
	L.ritual_cauldron = "Ritualkessel"
end

-- Murder Row

L = BigWigs:NewBossLocale("Murder Row Trash", "deDE")
if L then
	L.snitches_interrogated = "Spitzel verhört"
	L.snitches_interrogated_desc = "Zeigt einen Alarm, wenn ein Spitzel verhört wurde."
end

-- Nexus-Point Xenas

L = BigWigs:NewBossLocale("Nexus-Point Xenas Trash", "deDE")
if L then
	L.custom_on_arcane_tripwire_autotalk_desc = "|cFFFF0000Benötigt 25 Fertigkeitspunkte der Ingenieurskunst von Midnight.|r Wählt automatisch die NSC Dialogoption zum Deaktivieren des arkanen Stolperdrahtes."
end

-- Common Trash

L = BigWigs:NewBossLocale("Common Trash", "deDE")
if L then
    L.common_trash = "Gemeinsamer Trash"
	L.trash_cast = "Zauber"
	L.trash_cast_desc = "Alarmieren wenn ein normaler Gegner einen Zauber wirkt."
	L.lieutenant_cast = "Zauber (Leutnant)"
	L.lieutenant_cast_desc = "Alarmieren wenn ein Leutnant einen Zauber wirkt."
	L.trash_channel = "Kanalisieren"
	L.trash_channel_desc = "Alarmieren, wenn ein Gegner einen Zauber kanalisiert."
	L.customization = "Anpassung"
	L.custom_select_unit = "Zu berücksichtigende Einheiten"
    L.custom_select_unit_desc = "Legt fest, welche Einheiten Nachrichten anzeigen und Sounds wiedergeben."
    L.custom_select_unit_value1 = "Alle Einheiten zeigen Nachrichten und geben Sounds wieder"
    L.custom_select_unit_value2 = "Alle Einheiten zeigen Nachrichten, aber nur Dein Ziel gibt Sounds wieder"
    L.custom_select_unit_value3 = "Nur Dein Ziel zeigt Nachrichten und gibt Sounds wieder"
    L.custom_select_throttle_type = "Drossel Typ"
    L.custom_select_throttle_type_desc = "Welche Funktionen sollen gedrosselt werden"
    L.custom_select_throttle_type_value1 = "Sowohl Nachrichten als auch Sounds"
	L.custom_select_throttle_type_value2 = "Nur Sounds"
    L.custom_select_throttle_duration = "Drossel Dauer"
	L.custom_select_throttle_duration_desc = "Wartezeit zwischen Alarmen. Dein Ziel wird nie gedrosselt."
	L.custom_select_throttle_duration_value1 = "2 Sekunden"
	L.custom_select_throttle_duration_value2 = "1 Sekunde"
	L.custom_select_throttle_duration_value3 = "3 Sekunden"
end
