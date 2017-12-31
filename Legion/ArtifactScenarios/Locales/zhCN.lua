local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "zhCN")
if not L then return end
if L then
	L.tugar = "图加·鲜血图腾"
	L.jormog = "“巨兽”乔莫格"

	L.remaining = "鳞片剩余"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Kruul", "zhCN")
if L then
	L.name = "魔王库鲁尔"
	L.inquisitor = "审判官瓦里斯"
	L.velen = "先知维伦"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."
	
	--L.engage_message = "Highlord Kruul's Challenge Engaged!"

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Raest", "zhCN")
if L then
	L.name = "莱斯特·法师之矛"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	L.killed = "%s已击杀"

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "zhCN")
if L then
	L.name = "大法师克希雷姆"
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "zhCN")
if L then
	--L.warmup_trigger = "Your arrival is well-timed."
	L.warmup_trigger2 = "出……出什么事了？" --Stage 5 Warm up
	L.erdris = "艾德里斯·索恩领主"
	L.mage = "腐化的幽灵法师"
	L.soldier = "腐化的幽灵士兵"
	L.arbalest = "腐化的幽灵弩手"
end
