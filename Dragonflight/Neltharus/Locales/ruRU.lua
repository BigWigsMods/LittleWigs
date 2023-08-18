local L = BigWigs:NewBossLocale("Neltharus Trash", "ruRU")
if not L then return end
if L then
	L.custom_on_autotalk = "Авторазговор"
	--L.custom_on_autotalk_desc = "Instantly selects the gossip options to get profession buffs."

	L.burning_chain = "Горящая цепь"
	L.qalashi_warden = "Куалаши-страж"
	L.qalashi_hunter = "Куалаши-охотник"
	L.overseer_lahar = "Надзиратель Лахар"
	L.qalashi_trainee = "Куалаши-новобранец"
	L.qalashi_bonetender = "Куалаши-костестраж"
	L.qalashi_irontorch = "Куалаши-факельщица"
	L.qalashi_bonesplitter = "Куалаши-костедробительница"
	L.qalashi_lavabearer = "Куалаши - воин лавы"
	L.irontorch_commander = "Командир Железного Факела"
	L.qalashi_blacksmith = "Куалаши-кузнец"
	L.forgewrought_monstrosity = "Выкованное чудовище"
	L.qalashi_plunderer = "Куалаши-расхититель"
	L.qalashi_thaumaturge = "Куалаши-чудотворица"
	L.apex_blazewing = "Жарокрыл-вожак"
	L.qalashi_lavamancer = "Куалаши-лавамант"
end

L = BigWigs:NewBossLocale("Chargath, Bane of Scales", "ruRU")
if L then
	L.slow = "Замедление"
end

L = BigWigs:NewBossLocale("Warlord Sargha", "ruRU")
if L then
	L.magical_implements_desc = "Находящиеся рядом кучи сокровищ содержат магические предметы, которые могут помочь истощить Щит магмы."
	L.magma_shield = "Щит магмы - берите сокровища из золотых куч"
end
