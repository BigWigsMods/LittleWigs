-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "ruRU")
if not L then return end
if L then
	L.name = "Канретад Чернодрев"

	--L.summons = "Summons"
	--L.debuffs = "Debuffs"

	--L.start_say = "BEHOLD" -- BEHOLD! I have truly mastered the fel energies of this world! The demonic power I now command... It is indescribable, unlimited, OMNIPOTENT!
	--L.win_say = "Jubeka" -- Jubeka?! What are you...?!
end

L = BigWigs:NewBossLocale("Essence of Order", "ruRU")
if L then
	L.name = "Сущность порядка"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "ruRU")
if L then
	--L.engage_yell = "My endless agony shall be yours, as well!"
end

L = BigWigs:NewBossLocale("Brother Korloff", "ruRU")
if L then
	--L.engage_yell = "I will break you."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "ruRU")
if L then
	--L.engage_yell = "My legend begins NOW!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "ruRU")
if L then
	L.the_headless_horseman = "Всадник без головы"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "ruRU")
if L then
	--L.stage_2_trigger = "Now, Lilian, it is time for your transformation."
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "ruRU")
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	--L.stage3_yell = "was but a cub"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "ruRU")
if L then
	L.destroying_sha = "Разрушительный ша"
	L.slain_shado_pan_defender = "Убитый защитник Шадо-Пан"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "ruRU")
if L then
	--L.summon_desc = "Warn when Yan-Zhu summons a Yeasty Brew Alemental. They can cast |cff71d5ffFerment|r to heal the boss."
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "ruRU")
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	L.yaungol_warmup_trigger = "Ах, это еще не конец"

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	L.five_suns_warmup_trigger = "Насколько я могу судить"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "ruRU")
if L then
	L.corrupt_living_water = "Оскверненная живая вода"
	L.fallen_waterspeaker = "Падший заклинатель воды"
	L.haunting_sha = "Навязчивый ша"
	L.the_talking_fish = "Говорящая рыба"
	L.the_songbird_queen = "Королева певчих птиц"
	L.the_crybaby_hozen = "Хозен-плакса"
	L.the_nodding_tiger = "Кивающий тигр"
	L.the_golden_beetle = "Золотой жук"
	L.sha_touched_guardian = "Пораженный ша страж"
	L.depraved_mistweaver = "Порочная ткачиха туманов"
	L.shambling_infester = "Неуклюжий заразитель"
	L.minion_of_doubt = "Служитель Сомнения"
end
