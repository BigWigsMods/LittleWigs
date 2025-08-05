-- Artifact Scenarios

local L = BigWigs:NewBossLocale("Tugar Bloodtotem", "zhTW")
if L then
	--L.tugar = "Tugar Bloodtotem"
	--L.jormog = "Jormog the Behemoth"

	--L.remaining = "Scales Remaining"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Submerges below the ground, summoning spitter eggs and falling spikes."

	--L.charge_desc = "When Jormog is submerged, he will periodically charge in your direction."

	--L.rupture = "{243382} (X)"
	--L.rupture_desc = "A Fel Rupture in the shape of an X appears under you. After 5 seconds it will rupture the ground, sending spikes into the air and knocking back players on top of it."

	--L.totem_warning = "The totem hit you!"
end

L = BigWigs:NewBossLocale("Raest", "zhTW")
if L then
	--L.name = "Raest Magespear"

	--L.handFromBeyond = "Hand from Beyond"

	--L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."

	--L.warmup_text = "Karam Magespear Active"
	--L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	--L.warmup_trigger2 = "Kill this interloper, brother!"
end

L = BigWigs:NewBossLocale("Kruul", "zhTW")
if L then
	--L.name = "Highlord Kruul"
	--L.inquisitor = "Inquisitor Variss"
	--L.velen = "Prophet Velen"

	--L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	--L.win_trigger = "So be it. You will not stand in our way any longer."

	--L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."

	--L.smoldering_infernal = "Smoldering Infernal"
	--L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
end

L = BigWigs:NewBossLocale("Lord Erdris Thorn", "zhTW")
if L then
	--L.erdris = "Lord Erdris Thorn"

	--L.warmup_trigger = "Your arrival is well-timed."
	--L.warmup_trigger2 = "What's... happening?" --Stage 5 Warm up

	--L.mage = "Corrupted Risen Mage"
	--L.soldier = "Corrupted Risen Soldier"
	--L.arbalest = "Corrupted Risen Arbalest"
end

L = BigWigs:NewBossLocale("Archmage Xylem", "zhTW")
if L then
	--L.name = "Archmage Xylem"
	--L.corruptingShadows = "Corrupting Shadows"

	--L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	--L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
end

L = BigWigs:NewBossLocale("Agatha", "zhTW")
if L then
	--L.name = "Agatha"
	--L.imp_servant = "Imp Servant"
	--L.fuming_imp = "Fuming Imp"
	--L.levia = "Levia" -- Shortcut for warmup_trigger1, since the name "Levia" should be unique

	--L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	--L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	--L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	--L.stacks = "Stacks"
end

L = BigWigs:NewBossLocale("Sigryn", "zhTW")
if L then
	--L.sigryn = "Sigryn"
	--L.jarl = "Jarl Velbrand"
	--L.faljar = "Runenseher Faljar"

	--L.warmup_trigger = "What's this? The outsider has come to stop me?"
end

-- Assault on Violet Hold

L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "zhTW")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold."
	--L.keeper = "Portal Keeper"
	--L.guardian = "Portal Guardian"
	--L.infernal = "Blazing Infernal"
end

L = BigWigs:NewBossLocale("Thalena", "zhTW")
if L then
	--L.essence = "Essence"
end

-- Black Rook Hold

L = BigWigs:NewBossLocale("Black Rook Hold Trash", "zhTW")
if L then
	L.ghostly_retainer = "鬼魅侍從"
	L.ghostly_protector = "鬼魅保衛者"
	L.ghostly_councilor = "鬼魅參事"
	L.lord_etheldrin_ravencrest = "埃賽德林．黑羽"
	L.lady_velandras_ravencrest = "維蘭卓斯．黑羽女士"
	L.rook_spiderling = "玄鴉幼蛛"
	L.soultorn_champion = "喪魂勇士"
	L.risen_scout = "復活的斥候"
	L.risen_archer = "復活的弓箭手"
	L.risen_arcanist = "復活的祕法師"
	L.wyrmtongue_scavenger = "蟲舌魔拾荒者"
	L.bloodscent_felhound = "血腥惡魔犬"
	L.felspite_dominator = "魔恨支配者"
	L.risen_swordsman = "復活的劍兵"
	L.risen_lancer = "復活的矛兵"

	L.door_open_desc = "顯示開啟通往密道門的計時條。"
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "zhTW")
if L then
	L.phase_2_trigger = "夠了！我不耐煩了。"
end

-- Cathedral of Eternal Night

L = BigWigs:NewBossLocale("Mephistroth", "zhTW")
if L then
	L.custom_on_time_lost = "黑暗漸隱期間計時器"
	L.custom_on_time_lost_desc = "將黑暗漸隱持續時間的計時器顯示為|cffff0000紅色|r。"
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "zhTW")
if L then
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "zhTW")
if L then
	--L.dulzak = "Dul'zak"
	--L.wrathguard = "Wrathguard Invader"
	L.felguard = "惡魔守衛摧毀者"
	L.soulmender = "獄炎魔能使者"
	L.temptress = "獄炎妖女"
	L.botanist = "魔裔植物學家"
	L.orbcaster = "獄炎補魂者"
	--L.waglur = "Wa'glur"
	--L.scavenger = "Wyrmtongue Scavenger"
	L.gazerax = "賈澤拉克斯"
	--L.vilebark = "Vilebark Walker"

	--L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

-- Court of Stars

L = BigWigs:NewBossLocale("Court of Stars Trash", "zhTW")
if L then
	--L.duskwatch_sentry = "Duskwatch Sentry"
	--L.duskwatch_reinforcement = "Duskwatch Reinforcement"
	L.Guard = "暮衛守衛"
	L.Construct = "守護者傀儡"
	L.Enforcer = "魔縛執行者"
	L.Hound = "燃燒軍團獵犬"
	--L.Mistress = "Shadow Mistress"
	L.Gerenth = "『鄙惡者』葛任斯"
	L.Jazshariu = "賈茲夏魯"
	L.Imacutya = "伊瑪庫緹雅"
	L.Baalgar = "『警戒者』包爾加"
	L.Inquisitor = "警戒的審判官"
	L.BlazingImp = "熾炎小鬼"
	L.Energy = "束縛能量"
	L.Manifestation = "秘法化身"
	L.Wyrm = "法力龍鰻"
	L.Arcanist = "暮衛祕法師"
	L.InfernalImp = "熾炎小鬼"
	L.Malrodi = "祕法化身"
	L.Velimar = "威利瑪"
	L.ArcaneKeys = "祕法鑰匙"
	L.clues = "線索"

	L.InfernalTome = "煉獄秘典"
	L.MagicalLantern = "魔法燈籠"
	L.NightshadeRefreshments = "夜影餐點"
	L.StarlightRoseBrew = "星輝玫瑰酒"
	L.UmbralBloom = "暗影之花"
	L.WaterloggedScroll = "浸水的卷軸"
	L.BazaarGoods = "市集商品"
	L.LifesizedNightborneStatue = "等身大小的夜裔雕像"
	L.DiscardedJunk = "拋棄的雜物"
	L.WoundedNightborneCivilian = "受傷的夜裔平民"

	L.announce_buff_items = "通告增益物品"
	L.announce_buff_items_desc = "通告此地城所有可用的增益物品，並通告誰可以使用。"

	L.available = "%s|cffffffff%s|r可用" -- Context: item is available to use
	L.usableBy = "使用者：%s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "立即使用增益物品"
	L.custom_on_use_buff_items_desc = "啟用此選項後，自動確認使用物品前的對話選項並使用物品，這不包含二王前使用會引來守衛的物品。"

	L.spy_helper = "間諜事件助手"
	L.spy_helper_desc = "在一個訊息視窗內顯示隊伍得到間諜的線索，並通告線索給其他隊員。"

	L.clueFound = "找到第%d/5條線索：|cffffffff%s|r"
	L.spyFound = "間諜被%s找到了！"
	L.spyFoundChat = "我找到間諜了，快來！"
	L.spyFoundPattern = "別太快下定論。" -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	L.hints[1] = "斗篷"
	L.hints[2] = "沒有斗蓬"
	L.hints[3] = "腰袋"
	L.hints[4] = "藥水瓶"
	L.hints[5] = "長袖"
	L.hints[6] = "短袖"
	L.hints[7] = "手套"
	L.hints[8] = "沒有手套"
	L.hints[9] = "男性"
	L.hints[10] = "女性"
	L.hints[11] = "淺色上衣"
	L.hints[12] = "深色上衣"
	L.hints[13] = "無藥水瓶"
	L.hints[14] = "書本"
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "zhTW")
if L then
	--L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end

-- Darkheart Thicket

L = BigWigs:NewBossLocale("Darkheart Thicket Trash", "zhTW")
if L then
	L.archdruid_glaidalis_warmup_trigger = "污染者…我能聞到你血液裡的夢魘。離開這片林地，否則就面對大自然的憤怒吧！"

	L.mindshattered_screecher = "碎心尖嘯鴞"
	L.dreadsoul_ruiner = "懼魂毀滅者"
	L.dreadsoul_poisoner = "懼魂投毒者"
	L.crazed_razorbeak = "瘋狂的鋒喙角鷹獸"
	L.festerhide_grizzly = "瘡皮灰熊"
	L.vilethorn_blossom = "惡刺蘭花"
	L.rotheart_dryad = "腐心林精"
	L.rotheart_keeper = "腐心看守者"
	L.nightmare_dweller = "夢魘居者"
	L.bloodtainted_fury = "污血怒靈"
	L.bloodtainted_burster = "污血爆靈"
	L.taintheart_summoner = "腐心召喚師"
	L.dreadfire_imp = "懼火小鬼"
	L.tormented_bloodseeker = "痛苦的覓血蝙蝠"
end

L = BigWigs:NewBossLocale("Oakheart", "zhTW")
if L then
	L.throw = "投擲"
end

-- Eye of Azshara

L = BigWigs:NewBossLocale("Eye of Azshara Trash", "zhTW")
if L then
	--L.wrangler = "Hatecoil Wrangler"
	--L.stormweaver = "Hatecoil Stormweaver"
	--L.crusher = "Hatecoil Crusher"
	--L.oracle = "Hatecoil Oracle"
	--L.siltwalker = "Mak'rana Siltwalker"
	--L.tides = "Restless Tides"
	--L.arcanist = "Hatecoil Arcanist"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "zhTW")
if L then
	--L.custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning"
	--L.custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r."

	--L.water_safe = "%s (water is safe)"
	--L.land_safe = "%s (land is safe)"
end

-- Halls of Valor

L = BigWigs:NewBossLocale("Odyn", "zhTW")
if L then
	--L.gossip_available = "Gossip available"
	--L.gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand."

	--L[197963] = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	--L[197964] = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	--L[197965] = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	--L[197966] = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	--L[197967] = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "zhTW")
if L then
	--L.warmup_text = "God-King Skovald Active"
	--L.warmup_trigger = "The vanquishers have already taken possession of it, Skovald, as was their right. Your protest comes too late."
	--L.warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "zhTW")
if L then
	--L.mug_of_mead = "Mug of Mead"
	--L.valarjar_thundercaller = "Valarjar Thundercaller"
	--L.storm_drake = "Storm Drake"
	--L.stormforged_sentinel = "Stormforged Sentinel"
	--L.valarjar_runecarver = "Valarjar Runecarver"
	--L.valarjar_mystic = "Valarjar Mystic"
	--L.valarjar_purifier = "Valarjar Purifier"
	--L.valarjar_shieldmaiden = "Valarjar Shieldmaiden"
	--L.valarjar_aspirant = "Valarjar Aspirant"
	--L.solsten = "Solsten"
	--L.olmyr = "Olmyr the Enlightened"
	--L.valarjar_marksman = "Valarjar Marksman"
	--L.gildedfur_stag = "Gildedfur Stag"
	--L.angerhoof_bull = "Angerhoof Bull"
	--L.valarjar_trapper = "Valarjar Trapper"
	--L.fourkings = "The Four Kings"
end

-- Return to Karazhan

L = BigWigs:NewBossLocale("Karazhan Trash", "zhTW")
if L then
	-- Opera Event
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "歌劇大廳：綠野巫蹤"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "歌劇大廳：西荒故事"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "歌劇大廳：美女與猛獸"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	--L.barnes = "Barnes"
	--L.ghostly_philanthropist = "Ghostly Philanthropist"
	--L.skeletal_usher = "Skeletal Usher"
	--L.spectral_attendant = "Spectral Attendant"
	--L.spectral_valet = "Spectral Valet"
	--L.spectral_retainer = "Spectral Retainer"
	--L.phantom_guardsman = "Phantom Guardsman"
	--L.wholesome_hostess = "Wholesome Hostess"
	--L.reformed_maiden = "Reformed Maiden"
	--L.spectral_charger = "Spectral Charger"

	-- Return to Karazhan: Upper
	L.chess_event = "西洋棋事件"
	--L.king = "King"
end

L = BigWigs:NewBossLocale("Moroes", "zhTW")
if L then
	--L.cc = "Crowd Control"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "zhTW")
if L then
	--L.name = "Nightbane"
end

-- Maw of Souls

L = BigWigs:NewBossLocale("Maw of Souls Trash", "zhTW")
if L then
	--L.soulguard = "Waterlogged Soul Guard"
	--L.champion = "Helarjar Champion"
	--L.mariner = "Night Watch Mariner"
	--L.swiftblade = "Seacursed Swiftblade"
	--L.mistmender = "Seacursed Mistmender"
	--L.mistcaller = "Helarjar Mistcaller"
	--L.skjal = "Skjal"
end

-- Neltharion's Lair

L = BigWigs:NewBossLocale("Neltharions Lair Trash", "zhTW")
if L then
	L.rokmora_first_warmup_trigger = "納瓦羅格？！叛徒！你竟然帶領入侵者對抗我們？"
	L.rokmora_second_warmup_trigger = "就算這樣，我也樂見其成。羅克摩拉，碾碎他們！"

	L.vileshard_crawler = "邪裂爬行蛛"
	L.tarspitter_lurker = "噴油潛伏者"
	L.rockback_gnasher = "石背銳齒蜥"
	L.vileshard_hulk = "邪裂巨石怪"
	--L.vileshard_chunk = "Vileshard Chunk"
	L.understone_drummer = "底石擊鼓兵"
	L.mightstone_breaker = "力石破壞者"
	L.blightshard_shaper = "荒碎塑形者"
	L.stoneclaw_grubmaster = "石爪蟲王"
	L.tarspitter_grub = "噴油幼蟲"
	--L.rotdrool_grabber = "Rotdrool Grabber"
	L.understone_demolisher = "底石毀滅者"
	L.rockbound_trapper = "岩縛陷補者"
	L.emberhusk_dominator = "燼殼支配者"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "zhTW")
if L then
	--L.hands = "Hands" -- Short for "Stone Hands"
end

-- Seat of the Triumvirate

L = BigWigs:NewBossLocale("Viceroy Nezhar", "zhTW")
if L then
	--L.guards = "Guards"
	--L.interrupted = "%s interrupted %s (%.1fs left)!"
end

L = BigWigs:NewBossLocale("L'ura", "zhTW")
if L then
	--L.warmup_text = "L'ura Active"
	--L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	--L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "zhTW")
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

L = BigWigs:NewBossLocale("The Arcway Trash", "zhTW")
if L then
	L.anomaly = "祕法異常體"
	L.shade = "扭曲之影"
	L.wraith = "凋萎者法力怨靈"
	L.blade = "憤怒守衛魔刃兵"
	--L.chaosbringer = "Eredar Chaosbringer"
end

-- Vault of the Wardens

L = BigWigs:NewBossLocale("Cordana Felsong", "zhTW")
if L then
	L.kick_combo = "連環踢"

	L.light_dropped = "%s丟掉了光。"
	L.light_picked = "%s撿起了光。"

	L.warmup_trigger = "我已經拿到我要找的東西了。但為了你們，我最好還是留下來…斬草除根！"
	--L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "zhTW")
if L then
	--L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "zhTW")
if L then
	L.infester = "魔誓感染者"
	L.myrmidon = "魔誓部屬"
	L.fury = "魔能怒衛"
	--L.mother = "Foul Mother"
	L.illianna = "刃舞者伊利安娜"
	L.mendacius = "驚懼領主曼達希斯"
	L.grimhorn = "『奴役者』恐角"
end
