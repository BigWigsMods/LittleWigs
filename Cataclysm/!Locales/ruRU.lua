-- End Time

local L = BigWigs:NewBossLocale("Echo of Baine", "ruRU")
if not L then return end
if L then
	L.totemDrop = "Тотем поставлен"
	L.totemThrow = "Тотем выброшен %s"
end

-- Grim Batol

L = BigWigs:NewBossLocale("Erudax", "ruRU")
if L then
	--L.summon = "Summon Faceless Corruptor"
	--L.summon_desc = "Warn when Erudax summons a Faceless Corruptor."
	--L.summon_message = "Faceless Corruptor Summoned"
	--L.summon_trigger = "summons a"
end

L = BigWigs:NewBossLocale("Grim Batol Trash", "ruRU")
if L then
	--L.twilight_earthcaller = "Twilight Earthcaller"
	--L.twilight_brute = "Twilight Brute"
	--L.twilight_destroyer = "Twilight Destroyer"
	L.twilight_overseer = "Сумеречный надзиратель"
	--L.twilight_beguiler = "Twilight Beguiler"
	--L.molten_giant = "Molten Giant"
	--L.twilight_warlock = "Twilight Warlock"
	--L.twilight_flamerender = "Twilight Flamerender"
	--L.twilight_lavabender = "Twilight Lavabender"
	--L.faceless_corruptor = "Faceless Corruptor"
end

-- Hour of Twilight

L = BigWigs:NewBossLocale("The Hour of Twilight Trash", "ruRU")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Thrall's gossip options."
end

-- Lost City of the Tol'vir

L = BigWigs:NewBossLocale("Siamat", "ruRU")
if L then
	L.servant = "Призывание Служителя"
	L.servant_desc = "Сообщать когда Служитель Сиамата призван."
end

-- Shadowfang Keep

L = BigWigs:NewBossLocale("Lord Walden", "ruRU")
if L then
	-- %s will be either "Toxic Coagulant" or "Toxic Catalyst"
	--L.coagulant = "%s: Move to dispel"
	--L.catalyst = "%s: Crit Buff"
	--L.toxin_healer_message = "%s: DoT on everyone"
end

-- The Stonecore

L = BigWigs:NewBossLocale("Corborus", "ruRU")
if L then
	L.burrow = "Закапывается/вылезает"
	L.burrow_desc = "Сообщить, когда Корбор закапывается или вылезает на поверхность."
	L.burrow_message = "Корбор закапывается"
	L.burrow_warning = "Закапается через 5 сек!"
	L.emerge_message = "Корбор вылезает на поверхность!"
	L.emerge_warning = "Велезет через 5 сек!"
end

-- Throne of the Tides

L = BigWigs:NewBossLocale("Throne of the Tides Trash", "ruRU")
if L then
	L.nazjar_oracle = "Оракул леди Наз'жар"
	L.vicious_snap_dragon = "Злобный морской варан"
	L.nazjar_sentinel = "Часовой Леди Наз'жар"
	L.nazjar_ravager = "Опустошительница леди Наз'жар"
	L.nazjar_tempest_witch = "Ведьма бурь Леди Наз'жар"
	L.faceless_seer = "Безликий провидец"
	L.faceless_watcher = "Безликий дозорный"
	L.tainted_sentry = "Опороченный часовой"

	--L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "ruRU")
if L then
	--L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	--L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

-- The Vortex Pinnacle

L = BigWigs:NewBossLocale("The Vortex Pinnacle Trash", "ruRU")
if L then
	L.armored_mistral = "Бронированный мистраль"
	L.gust_soldier = "Клубящийся солдат"
	L.wild_vortex = "Дикое завихрение"
	L.lurking_tempest = "Затаившаяся буря"
	L.cloud_prince = "Принц облаков"
	L.turbulent_squall = "Вихревой шквал"
	L.empyrean_assassin = "Небесный убийца"
	L.young_storm_dragon = "Молодой грозовой дракон"
	L.executor_of_the_caliph = "Палач калифа"
	L.temple_adept = "Служитель храма"
	L.servant_of_asaad = "Слуга Асаада"
	L.minister_of_air = "Служитель воздуха"
end

-- Well of Eternity

L = BigWigs:NewBossLocale("Well Of Eternity Trash", "ruRU")
if L then
	--L.custom_on_autotalk_desc = "Instantly select Illidan's gossip option."
end

-- Zul'Aman

L = BigWigs:NewBossLocale("Daakara", "ruRU")
if L then
	--L[42594] = "Bear Form" -- short form for "Essence of the Bear"
	--L[42607] = "Lynx Form"
	--L[42606] = "Eagle Form"
	--L[42608] = "Dragonhawk Form"
end

L = BigWigs:NewBossLocale("Halazzi", "ruRU")
if L then
	--L.spirit_message = "Spirit Phase"
	--L.normal_message = "Normal Phase"
end

L = BigWigs:NewBossLocale("Nalorakk", "ruRU")
if L then
	--L.troll_message = "Troll Form"
	--L.troll_trigger = "Make way for da Nalorakk!"
end

-- Zul'Gurub

L = BigWigs:NewBossLocale("Jin'do the Godbreaker", "ruRU")
if L then
	--L.barrier_down_message = "Barrier down, %d remaining" -- short name for "Brittle Barrier" (97417)
end
