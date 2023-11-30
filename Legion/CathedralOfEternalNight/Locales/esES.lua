local L = BigWigs:NewBossLocale("Mephistroth", "esES") or BigWigs:NewBossLocale("Mephistroth", "esMX")
if not L then return end
if L then
	--L.custom_on_time_lost = "Time lost during Shadow Fade"
	--L.custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "esES") or BigWigs:NewBossLocale("Domatrax", "esMX")
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "esES") or BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "esMX")
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

