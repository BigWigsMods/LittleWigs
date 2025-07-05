-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "ruRU")
if not L then return end
if L then
	L.affliction = "Колдовство"
	L.demonology = "Демонология"
	L.destruction = "Разрушение"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "ruRU")
if L then
	L.abyssal = "Абиссал Скверны"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "ruRU")
if L then
	L.bloodmaul_enforcer = "Головорез из клана Кровавого Молота"
	L.bloodmaul_overseer = "Надзиратель из клана Кровавого Молота"
	L.bloodmaul_warder = "Страж из клана Кровавого Молота"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "ruRU")
if L then
	L.dropped = "%s уронены!"
	L.add_trigger1 = "Зададим им жару!"
	L.add_trigger2 = "Не щадите их!"

	L.waves[1] = "1x Гром'карский подрывник, 1x Гром'карская опалительница"
	L.waves[2] = "1x Гром'карская опалительница, 1x Гром'карский гренадер"
	L.waves[3] = "Железный пехотинец"
	L.waves[4] = "2x Гром'карский подрывник"
	L.waves[5] = "Железный пехотинец"
	L.waves[6] = "2x Гром'карская опалительница"
	L.waves[7] = "Железный пехотинец"
	L.waves[8] = "1x Гром'карский подрывник, 1x Гром'карский гренадер"
	L.waves[9] = "3x Гром'карский подрывник, 1x Гром'карская опалительница"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "ruRU")
if L then
	L.grimrail_technician = "Техник Мрачных Путей"
	L.grimrail_overseer = "Надзиратель Мрачных Путей"
	L.gromkar_gunner = "Гром'карская опалительница"
	L.gromkar_cinderseer = "Гром'карская пророчица на пепле"
	L.gromkar_boomer = "Гром'карский подрывник"
	L.gromkar_hulk = "Гром'карский исполин"
	L.gromkar_far_seer = "Гром'карский ясновидящий"
	L.gromkar_captain = "Гром'карский капитан"
	L.grimrail_scout = "Разведчица Мрачных Путей"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "ruRU")
if L then
	L.sphere_fail_message = "Щит снят - Они все исцелились :("
end

L = BigWigs:NewBossLocale("Oshir", "ruRU")
if L then
	L.freed = "Освобожден спустя %.1f сек!"
	L.wolves = "Волки"
	L.rylak = "Рилак"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "ruRU")
if L then
	L.gromkar_battlemaster = "Гром'карский военачальник"
	L.gromkar_flameslinger = "Гром'карская огненная лучница"
	L.gromkar_technician = "Гром'карский техник"
	L.siegemaster_olugar = "Осадный мастер Олугар"
	L.pitwarden_gwarnok = "Страж ям Гварнок"
	L.ogron_laborer = "Огрон-работник"
	L.gromkar_chainmaster = "Гром'карский мастер цепей"
	L.thunderlord_wrangler = "Укротитель из клана Громоборцев"
	L.rampaging_clefthoof = "Буйный копытень"
	L.ironwing_flamespitter = "Железнокрылый изрыгатель огня"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Bonemaw", "ruRU")
if L then
	L.summon_worms = "Призыв помощников"
	L.summon_worms_desc = "Костебрюх призывает двух червей-трупоедов"
	L.summon_worms_trigger = "привлекает ближайших червей-трупоедов"

	L.submerge = "Погружение"
	L.submerge_desc = "Костебрюх погружается и появляется в другом месте"
	L.submerge_trigger = "шипит и уползает обратно в темные глубины!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "ruRU")
if L then
	L.shadowmoon_bonemender = "Подчинитель костей из клана Призрачной Луны"
	L.reanimated_ritual_bones = "Оживленные ритуальные кости"
	L.void_spawn = "Дитя Бездны"
	L.shadowmoon_loyalist = "Верная служительница из клана Призрачной Луны"
	L.defiled_spirit = "Оскверненный дух"
	L.shadowmoon_dominator = "Поработитель из клана Призрачной Луны"
	L.shadowmoon_exhumer = "Извлекатель душ из клана Призрачной Луны"
	L.exhumed_spirit = "Эксгумированный дух"
	L.monstrous_corpse_spider = "Чудовищный трупный паук"
	L.carrion_worm = "Червь-трупоед"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "ruRU")
if L then
	L.solar_zealot = "Солнечный ревнитель"
	L.construct = "Голем-защитник Небесного Пути"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "ruRU")
if L then
	--L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "ruRU")
if L then
	L.dreadpetal = "Страхоцвет"
	L.everbloom_naturalist = "Натуралист Вечного Цветения"
	L.everbloom_cultivator = "Культиватор Вечного Цветения"
	L.rockspine_stinger = "Камнеспинный жальщик"
	L.everbloom_mender = "Лекарь Вечного Цветения"
	L.gnarlroot = "Кривокорень"
	L.melded_berserker = "Зараженный берсерк"
	L.twisted_abomination = "Искаженное поганище"
	L.infested_icecaller = "Зараженная сотворительница льда"
	L.putrid_pyromancer = "Гнилостный пиромант"
	L.addled_arcanomancer = "Одурманенный маг"

	--L.gate_open_desc = "Show a bar indicating when Undermage Kesalon will open the gate to Yalnu."
	--L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "ruRU")
if L then
	--L.counduitLeft = "%d |4Conduit:Conduits; left"
end
