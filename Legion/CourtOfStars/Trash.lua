
-- GLOBALS: BigWigs, table

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Court of Stars Trash", 1571)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	104246, -- Duskwatch Guard
	111563, -- Duskwatch Guard
	104270, -- Guardian Construct
	104278, -- Felbound Enforcer
	104277, -- Legion Hound
	107435, -- Gerenth the Vile & Suspicious Noble
	104273, -- Jazshariu
	104275, -- Imacu'tya
	104274, -- Baalgar the Watchful
	105715, -- Watchful Inquisitor
	104295, -- Blazing Imp
	105705, -- Bound Energy
	105704, -- Arcane Manifestation
	105703, -- Mana Wyrm
	104247, -- Duskwatch Arcanist
	112668, -- Infernal Imp
	108796, -- Arcanist Malrodi (Court of Stars: The Deceitful Student World Quest)
	108740, -- Velimar (Court of Stars: Bring Me the Eyes World Quest)
	106468, -- Ly'leth Lunastre
	107486, -- Chatty Rumormonger
	105729, -- Signal Lantern: Boat at the start
	105157, -- Arcane Power Conduit: Disables Constructs
	105117, -- Flask of the Solemn Night: Poisons first boss
	105160, -- Fel Orb: 10% Crit
	105831, -- Infernal Tome: -10% Dmg taken
	106024, -- Magical Lantern: +10% Dmg dealt
	105249, -- Nightshade Refreshments: +25% HP
	106108, -- Starlight Rose Brew: +HP & Mana reg
	105340, -- Umbral Bloom: +10% Haste
	106110, -- Waterlogged Scroll: +30% Movement speed
	108154 -- Arcane Keys
)

--------------------------------------------------------------------------------
-- Locals
--

local englishSpyFound = "I found the spy!"
local englishClueNames = {
	"Cape",
	"No Cape",
	"Pouch",
	"Potions",
	"Long Sleeves",
	"Short Sleeves",
	"Gloves",
	"No Gloves",
	"Male",
	"Female",
	"Light Vest",
	"Dark Vest",
	"No Potions",
	"Book",
}
local localized_clues = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.Guard = "Duskwatch Guard"
	L.Construct = "Guardian Construct"
	L.Enforcer = "Felbound Enforcer"
	L.Hound = "Legion Hound"
	L.Mistress = "Shadow Mistress"
	L.Gerenth = "Gerenth the Vile"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Imacutya"
	L.Baalgar = "Baalgar the Watchful"
	L.Inquisitor = "Watchful Inquisitor"
	L.BlazingImp = "Blazing Imp"
	L.Energy = "Bound Energy"
	L.Manifestation = "Arcane Manifestation"
	L.Wyrm = "Mana Wyrm"
	L.Arcanist = "Duskwatch Arcanist"
	L.InfernalImp = "Infernal Imp"
	L.Malrodi = "Arcanist Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Arcane Keys"
	L.clues = "Clues"

	L.InfernalTome = "Infernal Tome"
	L.MagicalLantern = "Magical Lantern"
	L.NightshadeRefreshments = "Nightshade Refreshments"
	L.StarlightRoseBrew = "Starlight Rose Brew"
	L.UmbralBloom = "Umbral Bloom"
	L.WaterloggedScroll = "Waterlogged Scroll"
	L.BazaarGoods = "Bazaar Goods"
	L.LifesizedNightborneStatue = "Lifesized Nightborne Statue"
	L.DiscardedJunk = "Discarded Junk"
	L.WoundedNightborneCivilian = "Wounded Nightborne Civilian"

	L.announce_buff_items = "Announce buff items"
	L.announce_buff_items_desc = "Announces all available buff items around the dungeon and who is able to use them."
	L.announce_buff_items_icon = 211080

	L.available = "%s|cffffffff%s|r available" -- Context: item is available to use
	L.usableBy = "usable by %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Instantly use buff items"
	L.custom_on_use_buff_items_desc = "Enable this option to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss."
	L.custom_on_use_buff_items_icon = 211110

	L.spy_helper = "Spy Event Helper"
	L.spy_helper_desc = "Shows an InfoBox with all clues your group gathered about the spy. The clues will also be sent to your party members in chat."
	L.spy_helper_icon = 213213

	L.clueFound = "Clue found (%d/5): |cffffffff%s|r"
	L.spyFound = "Spy found by %s!"
	L.spyFoundChat = englishSpyFound
	L.spyFoundPattern = "Now now, let's not be hasty" -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	L.hints = englishClueNames

	-- Cape
	L.clue_1_1 = "I heard the spy enjoys wearing capes."
	L.clue_1_2 = "Someone mentioned the spy came in earlier wearing a cape."

	-- No Cape
	L.clue_2_1 = "I heard that the spy left their cape in the palace before coming here."
	L.clue_2_2 = "I heard the spy dislikes capes and refuses to wear one."

	-- Pouch
	L.clue_3_1 = "A friend said the spy loves gold and a belt pouch filled with it."
	L.clue_3_2 = "I heard the spy's belt pouch is filled with gold to show off extravagance."
	L.clue_3_3 = "I heard the spy carries a magical pouch around at all times."
	L.clue_3_4 = "I heard the spy's belt pouch is lined with fancy threading."
	L.clue_3_5 = "" -- for ruRU
	L.clue_3_6 = "" -- for ruRU

	-- Potions
	L.clue_4_1 = "I heard the spy brought along some potions... just in case."
	L.clue_4_2 = "I'm pretty sure the spy has potions at the belt."
	L.clue_4_3 = "I heard the spy brought along potions, I wonder why?"
	L.clue_4_4 = "I didn't tell you this... but the spy is masquerading as an alchemist and carrying potions at the belt."
	L.clue_4_5 = "" -- for ruRU
	L.clue_4_6 = "" -- for ruRU

	-- Long Sleeves
	L.clue_5_1 = "I just barely caught a glimpse of the spy's long sleeves earlier in the evening."
	L.clue_5_2 = "I heard the spy's outfit has long sleeves tonight."
	L.clue_5_3 = "Someone said the spy is covering up their arms with long sleeves tonight."
	L.clue_5_4 = "A friend of mine mentioned the spy has long sleeves on."
	L.clue_5_5 = "" -- for ruRU

	-- Short Sleeves
	L.clue_6_1 = "I heard the spy enjoys the cool air and is not wearing long sleeves tonight."
	L.clue_6_2 = "A friend of mine said she saw the outfit the spy was wearing. It did not have long sleeves."
	L.clue_6_3 = "Someone told me the spy hates wearing long sleeves."
	L.clue_6_4 = "I heard the spy wears short sleeves to keep their arms unencumbered."
	L.clue_6_5 = "" -- for ruRU

	-- Gloves
	L.clue_7_1 = "I heard the spy always dons gloves."
	L.clue_7_2 = "There's a rumor that the spy always wears gloves."
	L.clue_7_3 = "Someone said the spy wears gloves to cover obvious scars."
	L.clue_7_4 = "I heard the spy carefully hides their hands."
	L.clue_7_5 = "" -- for ruRU
	L.clue_7_6 = "" -- for ruRU

	-- No Gloves
	L.clue_8_1 = "There's a rumor that the spy never has gloves on."
	L.clue_8_2 = "I heard the spy dislikes wearing gloves."
	L.clue_8_3 = "I heard the spy avoids having gloves on, in case some quick actions are needed."
	L.clue_8_4 = "You know... I found an extra pair of gloves in the back room. The spy is likely to be bare handed somewhere around here."
	L.clue_8_5 = "" -- for ruRU
	L.clue_8_6 = "" -- for ruRU
	L.clue_8_7 = "" -- for ruRU

	-- Male
	L.clue_9_1 = "A guest said she saw him entering the manor alongside the Grand Magistrix."
	L.clue_9_2 = "I heard somewhere that the spy isn't female."
	L.clue_9_3 = "I heard the spy is here and he's very good looking."
	L.clue_9_4 = "One of the musicians said he would not stop asking questions about the district."
	L.clue_9_5 = "" -- for ruRU
	L.clue_9_6 = "" -- for ruRU

	-- Female
	L.clue_10_1 = "A guest saw both her and Elisande arrive together earlier."
	L.clue_10_2 = "I hear some woman has been constantly asking about the district..."
	L.clue_10_3 = "Someone's been saying that our new guest isn't male."
	L.clue_10_4 = "They say that the spy is here and she's quite the sight to behold."
	L.clue_10_5 = "" -- for ruRU

	-- Light Vest
	L.clue_11_1 = "The spy definitely prefers the style of light colored vests."
	L.clue_11_2 = "I heard that the spy is wearing a lighter vest to tonight's party."
	L.clue_11_3 = "People are saying the spy is not wearing a darker vest tonight."

	-- Dark Vest
	L.clue_12_1 = "I heard the spy's vest is a dark, rich shade this very night."
	L.clue_12_2 = "The spy enjoys darker colored vests... like the night."
	L.clue_12_3 = "Rumor has it the spy is avoiding light colored clothing to try and blend in more."
	L.clue_12_4 = "The spy definitely prefers darker clothing."

	-- No Potions
	L.clue_13_1 = "I heard the spy is not carrying any potions around."
	L.clue_13_2 = "A musician told me she saw the spy throw away their last potion and no longer has any left."

	-- Book
	L.clue_14_1 = "I heard the spy always has a book of written secrets at the belt."
	L.clue_14_2 = "Rumor has is the spy loves to read and always carries around at least one book."
	L.clue_14_3 = "" -- for ruRU
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"announce_buff_items",
		"custom_on_use_buff_items",
		{"spy_helper", "INFOBOX"},
		209027, -- Quelling Strike (Duskwatch Guard)
		209033, -- Fortification (Duskwatch Guard)
		225100, -- Charging Station (Guardian Construct)
		209495, -- Charged Smash (Guardian Construct)
		209512, -- Disrupting Energy (Guardian Construct)
		209413, -- Suppress (Guardian Construct)
		211464, -- Fel Detonation (Felbound Enforcer)
		211391, -- Felblaze Puddle (Legion Hound)
		211470, -- Bewitch (Shadow Mistress)
		214692, -- Shadow Bolt Volley (Gerenth the Vile)
		214688, -- Carrion Swarm (Gerenth the Vile)
		214690, -- Cripple (Gerenth the Vile)
		207979, -- Shockwave (Jazshariu)
		209378, -- Whirling Blades (Imacu'tya)
		207980, -- Disintegration Beam (Baalgar the Watchful)
		211299, -- Searing Glare (Watchful Inquisitor)
		212784, -- Eye Storm (Watchful Inquisitor)
		211401, -- Drifting Embers (Blazing Imp)
		212031, -- Charged Blast (Bound Energy)
		209485, -- Drain Magic (Arcane Manifestation)
		209477, -- Wild Detonation (Mana Wyrm)
		209410, -- Nightfall Orb (Duskwatch Arcanist)
		209404, -- Seal Magic (Duskwatch Arcanist)
		224377, -- Drifting Embers (Infernal Imp)
		216110, -- Uncontrolled Blast (Arcanist Malrodi)
		216096, -- Wild Magic (Arcanist Malrodi)
		216000, -- Mighty Stomp (Velimar)
		216006, -- Shadowflame Breath (Velimar)
		214697, -- Picking Up (Arcane Keys)
	}, {
		["announce_buff_items"] = "general",
		[209027] = L.Guard,
		[225100] = L.Construct,
		[211464] = L.Enforcer,
		[211391] = L.Hound,
		[211470] = L.Mistress,
		[214692] = L.Gerenth,
		[207979] = L.Jazshariu,
		[209378] = L.Imacutya,
		[207980] = L.Baalgar,
		[211299] = L.Inquisitor,
		[211401] = L.BlazingImp,
		[212031] = L.Energy,
		[209485] = L.Manifestation,
		[209477] = L.Wyrm,
		[209410] = L.Arcanist,
		[224377] = L.InfernalImp,
		[216110] = L.Malrodi,
		[216000] = L.Velimar,
		[214697] = L.ArcaneKeys,
	}
end

function mod:OnRegister()
	-- populate our clue lookup table
	for i = 1, 14 do
		local j = 1
		local clue = L[("clue_%d_%d"):format(i, j)]
		while clue and clue ~= "" do
			localized_clues[clue] = i
			j = j + 1
			clue = L[("clue_%d_%d"):format(i, j)]
		end
	end
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	-- Charging Station, Shadow Bolt Volley, Carrion Swarm, Shockwave, Whirling Blades, Drain Magic, Wild Detonation, Nightfall Orb, Seal Magic, Fortification, Uncontrolled Blast, Wild Magic, Mighty Stomp, Shadowflame Breath, Bewitch
	self:Log("SPELL_CAST_START", "AlertCasts", 225100, 214692, 214688, 207979, 209378, 209485, 209477, 209410, 209404, 209033, 216110, 216096, 216000, 216006, 211470)
	-- Quelling Strike, Fel Detonation, Searing Glare, Eye Storm, Drifting Embers, Charged Blast, Suppress, Charged Smash, Drifting Embers
	self:Log("SPELL_CAST_START", "AlarmCasts", 209027, 211464, 211299, 212784, 211401, 212031, 209413, 209495, 224377)
	-- Felblaze Puddle, Disrupting Energy
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 211391, 209512)
	-- Dispellable stuff
	self:Log("SPELL_AURA_APPLIED", "Fortification", 209033)
	self:Log("SPELL_AURA_APPLIED", "SealMagic", 209404)
	self:Log("SPELL_AURA_APPLIED", "Suppress", 209413)
	self:Log("SPELL_AURA_APPLIED", "SingleTargetDebuffs", 214690, 211470) -- Cripple, Bewitch
	self:Log("SPELL_AURA_REMOVED", "SingleTargetDebuffsRemoved", 209413, 214690, 211470) -- Suppress, Cripple, Bewitch
	-- Disintegration Beam
	self:Log("SPELL_AURA_APPLIED", "DisintegrationBeam", 207980)
	-- Eye Storm
	self:Log("SPELL_CAST_SUCCESS", "EyeStorm", 212784)
	-- Picking Up
	self:Log("SPELL_CAST_START", "PickingUp", 214697)
	self:Log("SPELL_CAST_SUCCESS", "PickingUpSuccess", 214697)

	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterMessage("BigWigs_BossComm")
	self:RegisterMessage("DBM_AddonMessage") -- Catch DBM clues

	-- Purely because DBM, and maybe others, call CloseGossip. That is just sooooo useful.
	local frames = {GetFramesRegisteredForEvent("GOSSIP_SHOW")}
	for i = 1, #frames do
		frames[i]:UnregisterEvent("GOSSIP_SHOW")
	end
	self:RegisterEvent("GOSSIP_SHOW")
	for i = 1, #frames do
		frames[i]:RegisterEvent("GOSSIP_SHOW")
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local autoTalk = {
		[107486] = true, -- Chatty Rumormonger
		[106468] = true, -- Ly'leth Lunastre
		[105729] = true, -- Signal Lantern: Boat at the start
	}

	local buffItems = {
		[105157] = { -- Arcane Power Conduit: Disables Constructs
			["name"] = 210466,
			["professions"] = {
				[136243] = 100, -- Engineering
			},
			["races"] = {
				["Gnome"] = true,
				["Goblin"] = true,
			},
		},
		[105117] = { -- Flask of the Solemn Night: Poisons first boss
			["name"] = 207815,
			["professions"] = {
				[136240] = 100, -- Alchemy
			},
			["classes"] = {
				["ROGUE"] = true,
			},
		},
		[105160] = { -- Fel Orb: 10% Crit
			["name"] = 208275,
			["classes"] = {
				["DEMONHUNTER"] = true,
				["WARLOCK"] = true,
				["PRIEST"] = true,
				["PALADIN"] = true,
			},
		},
		[105831] = { -- Infernal Tome: -10% Dmg taken
			["name"] = "InfernalTome",
			["classes"] = {
				["DEMONHUNTER"] = true,
				["PRIEST"] = true,
				["PALADIN"] = true,
			},
		},
		[106024] = { -- Magical Lantern: +10% Dmg dealt
			["name"] = "MagicalLantern",
			["classes"] = {
				["MAGE"] = true,
			},
			["professions"] = {
				[136244] = 100, -- Enchanting
			},
			["races"] = {
				["BloodElf"] = true,
				["NightElf"] = true,
			},
		},
		[105249] = { -- Nightshade Refreshments: +25% HP
			["name"] = "NightshadeRefreshments",
			["professions"] = {
				[133971] = 800, -- Cooking
				[136246] = 100, -- Herbalism
			},
			["races"] = {
				["Pandaren"] = true,
			},
		},
		[106108] = { -- Starlight Rose Brew: +HP & Mana reg
			["name"] = "StarlightRoseBrew",
			["classes"] = {
				["DEATHKNIGHT"] = true,
				["MONK"] = true,
			},
		},
		[105340] = { -- Umbral Bloom: +10% Haste
			["name"] = "UmbralBloom",
			["classes"] = {
				["DRUID"] = true,
			},
			["professions"] = {
				[136246] = 100, -- Herbalism
			}
		},
		[106110] = { -- Waterlogged Scroll: +30% Movement speed
			["name"] = "WaterloggedScroll",
			["classes"] = {
				["SHAMAN"] = true,
			},
			["professions"] = {
				[134366] = 100, -- Skinning
				[237171] = 100, -- Inscription
			}
		},
	}

	local buffs = {
		[105160] = 211081, -- Fel Orb = Fel Surge
		[105831] = 211080, -- Infernal Tome = Comforting Light
		[106024] = 211093, -- Magical Lantern = Arcane Infusion
		[105249] = 211102, -- Nightshade Refreshments = Succulent Cuisine
		[106108] = 211071, -- Starlight Rose Brew = Starlight Rose Brew
		[105340] = 211110, -- Umbral Bloom = Umbral Spores
		[106110] = 211084, -- Waterlogged Scroll = Flowing Waters
	}

	local guardItems = {
		[106018] = { -- Bazaar Goods
			["name"] = "BazaarGoods",
			["classes"] = {
				["ROGUE"] = true,
				["WARRIOR"] = true,
			},
			["professions"] = {
				[136247] = 100, -- Leatherworking
			},
		},
		[106113] = { -- Lifesized Nightborne Statue
			["name"] = "LifesizedNightborneStatue",
			["professions"] = {
				[134708] = 100, -- Mining
				[134071] = 100, -- Jewelcrafting
			},
		},
		[105215] = { -- Discarded Junk
			["name"] = "DiscardedJunk",
			["classes"] = {
				["HUNTER"] = true,
			},
			["professions"] = {
				[136241] = 100, -- Blacksmithing
			},
		},
		[106112] = { -- Wounded Nightborne Civilian
			["name"] = "WoundedNightborneCivilian",
			["roles"] = {
				["Healer"] = true,
			},
			["professions"] = {
				[136249] = 100, -- Tailoring
			},
		},
	}

	local professionCache = {}

	local raceIcons = {
		["Pandaren"] = "|T626190:0|t",
		["NightElf"] = "|T236449:0|t",
		["BloodElf"] = "|T236439:0|t",
		["Gnome"] = "|T236445:0|t",
		["Goblin"] = "|T632354:0|t",
	}

	local roleIcons = {
		["Healer"] = "|T337497:0:0:0:0:64:64:20:39:1:20|t",
	}

	local function getClassIcon(class)
		return ("|TInterface/Icons/classicon_%s:0|t"):format(strlower(class))
	end

	local function getIconById(id)
		return ("|T%d:0|t"):format(id)
	end

	local dbmClues = {
		["cape"] = 1,
		["no cape"] = 2,
		["pouch"] = 3,
		["potions"] = 4,
		["long sleeves"] = 5,
		["short sleeves"] = 6,
		["gloves"] = 7,
		["no gloves"] = 8,
		["male"] = 9,
		["female"] = 10,
		["light vest"] = 11,
		["dark vest"] = 12,
		["no potion"] = 13,
		["book"] = 14,
	}

	local knownClues, clueCount, timer = {}, 0, nil

	function mod:OnBossDisable()
		clueCount = 0
		timer = nil
		knownClues = {}
	end

	local function sendChatMessage(msg, english)
		if IsInGroup() then
			BigWigsLoader.SendChatMessage(english and ("[LittleWigs] %s / %s"):format(msg, english) or ("[LittleWigs] %s"):format(msg), IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
		end
	end

	local function addClue(self, clue)
		if clueCount == 0 then
			self:OpenInfo("spy_helper", L.clues)
		end
		if not knownClues[clue] then
			knownClues[clue] = true
			clueCount = clueCount + 1
			self:SetInfo("spy_helper", (clueCount*2)-1, L.hints[clue])
			self:MessageOld("spy_helper", "cyan", "info", L.clueFound:format(clueCount, L.hints[clue]), false)
		end
	end

	function mod:DBM_AddonMessage(_, _, prefix, _, _, event, clue)
		if prefix == "M" and event == "CoS" and dbmClues[clue] then
			self:BigWigs_BossComm(nil, "clue", dbmClues[clue])
		end
	end

	local function printNew(locale, clue)
		timer = nil
		knownClues[clue] = true -- Throttle to only show once per new message
		if clue == C_GossipInfo.GetText() then -- Extra safety
			RaidNotice_AddMessage(RaidWarningFrame, "LittleWigs: Unknown clue detected, see chat for info.", {r=1,g=1,b=1})
			BigWigs:Print("LittleWigs has found an unknown clue, please report it on Discord or GitHub so we can add it and shorten the message.")
			BigWigs:Error(("|cffffff00TELL THE AUTHORS:|r New clue '%s' with '%s'"):format(clue, locale))
		end
	end

	local prev = 0
	function mod:GOSSIP_SHOW()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end

		local mobId = self:MobId(self:UnitGUID("npc"))
		local spyEventHelper = self:GetOption("spy_helper") > 0
		if autoTalk[mobId] or buffItems[mobId] then
			if not self:GetGossipOptions() and mobId == 107486 then -- Chatty Rumormonger
				local clue = C_GossipInfo.GetText()
				local num = localized_clues[clue]
				if num then
					prev = GetTime()
					if spyEventHelper and not knownClues[num] then
						local text = L.hints[num]
						sendChatMessage(text, englishClueNames[num] ~= text and englishClueNames[num])
					end
					mod:Sync("clue", num)
				else
					-- GetTime: Sometimes it's 1st screen (chat) > 2nd screen (clue) > 1st screen (chat, no gossip selection) and would trigger this
					if spyEventHelper and not knownClues[clue] and (GetTime()-prev) > 2 then
						timer = self:ScheduleTimer(printNew, 2, GetLocale(), clue)
					end
				end
			end
			if (spyEventHelper and autoTalk[mobId]) or (self:GetOption("custom_on_use_buff_items") and buffItems[mobId]) then
				self:SelectGossipOption(1)
			end
		end
	end

	function mod:CHAT_MSG_MONSTER_SAY(_, msg, _, _, _, target)
		if msg:find(L.spyFoundPattern) and self:GetOption("spy_helper") > 0 then
			self:MessageOld("spy_helper", "green", "info", L.spyFound:format(self:ColorName(target)), false)
			self:CloseInfo("spy_helper")
			if target == self:UnitName("player") then
				sendChatMessage(L.spyFoundChat, englishSpyFound ~= L.spyFoundChat and englishSpyFound)
				self:CustomIcon(false, "target", 8)
			else
				for unit in self:IterateGroup() do
					if self:UnitGUID(unit) == self:UnitGUID(target) then
						self:CustomIcon(false, unit.."target", 8)
						break
					end
				end
			end
		end
	end

	local function announceUsable(self, id, item)
		self:Sync("itemAvailable", id)
		local players = {} -- who can use the item
		local icons = {}
		if item.professions then
			for profIcon, requiredSkill in pairs(item.professions) do
				if professionCache[profIcon] then
					for _,v in pairs(professionCache[profIcon]) do
						if v.skill >= requiredSkill then
							players[v.name] = true
						end
					end
				end
				icons[#icons+1] = getIconById(profIcon)
			end
		end
		if item.races then
			for race, _ in pairs(item.races) do
				for unit in self:IterateGroup() do
					local _, unitRace = UnitRace(unit)
					if unitRace == race then
						players[self:UnitName(unit)] = true
					end
				end
				icons[#icons+1] = raceIcons[race]
			end
		end
		if item.classes then
			for class, _ in pairs(item.classes) do
				for unit in self:IterateGroup() do
					local _, unitClass = UnitClass(unit)
					if unitClass == class then
						players[self:UnitName(unit)] = true
					end
				end
				icons[#icons+1] = getClassIcon(class)
			end
		end
		if item.roles then
			for role, _ in pairs(item.roles) do
				for unit in self:IterateGroup() do
					if self[role](self, unit) then
						players[self:UnitName(unit)] = true
					end
				end
				icons[#icons+1] = roleIcons[role]
			end
		end

		local name = type(item.name) == "number" and self:SpellName(item.name) or L[item.name]
		local message = (L.available):format(table.concat(icons, ""), name)

		if next(players) then
			local list = ""
			for player in pairs(players) do
				if UnitInParty(player) then -- don't announce players from previous groups
					list = list .. self:ColorName(player) .. ", "
				end
			end
			if list:len() > 0 then
				message = message .. " - ".. L.usableBy:format(list:sub(0, list:len()-2))
			end
		end

		self:MessageOld("announce_buff_items", "cyan", "info", message, false)
	end

	local prevTable, lastProfessionUpdate = {}, 0
	local function usableFound(self, id, item)
		if buffs[id] and self:UnitBuff("player", self:SpellName(buffs[id]), buffs[id]) then -- there's no point in showing a message if we already have the buff
			return
		end

		local t = GetTime()
		if t-(prevTable[id] or 0) > 300 then
			prevTable[id] = t

			local delayAnnouncement = false
			if item.professions then
				if t-lastProfessionUpdate > 300 then
					lastProfessionUpdate = t
					self:Sync("getProfessions")
					delayAnnouncement = true
				end
			end
			if delayAnnouncement then
				self:ScheduleTimer(announceUsable, 0.3, self, id, item)
			else
				announceUsable(self, id, item)
			end
		end
	end

	function mod:UPDATE_MOUSEOVER_UNIT()
		local id = self:MobId(self:UnitGUID("mouseover"))
		local item = buffItems[id] or guardItems[id]
		if item then
			usableFound(self, id, item)
		end
	end

	function mod:BigWigs_BossComm(_, msg, data, sender)
		if msg == "clue" and self:GetOption("spy_helper") > 0 then
			local clue = tonumber(data)
			if clue and clue > 0 and clue <= #L.hints then
				addClue(self, clue)
			end
		elseif msg == "getProfessions" then
			local professions = {}
			for _,id in pairs({GetProfessions()}) do
				local _, icon, skill = GetProfessionInfo(id) -- name is localized, so use icon instead
				professions[icon] = skill
			end
			local profString = ""
			for k,v in pairs(professions) do
				profString = profString .. k .. ":" .. v .. "#"
			end
			self:Sync("professions", profString)
		elseif msg == "professions" then
			lastProfessionUpdate = GetTime()
			for icon, skill in data:gmatch("(%d+):(%d+)#") do
				icon = tonumber(icon)
				skill = tonumber(skill)
				if not professionCache[icon] then
					professionCache[icon] = {}
				end
				professionCache[icon][#professionCache[icon]+1] = {name=sender, skill=skill}
			end
		elseif msg == "itemAvailable" then
			local id = tonumber(data)
			local item = buffItems[id] or guardItems[id]
			if item then
				usableFound(self, id, item)
			end
		end
	end
end

local prevTable = {}
local function throttleMessages(key)
	local t = GetTime()
	if t-(prevTable[key] or 0) > 1.5 then
		prevTable[key] = t
		return false
	else
		return true
	end
end

function mod:AlertCasts(args)
	if throttleMessages(args.spellId) then return end
	self:MessageOld(args.spellId, "yellow", "alert", CL.casting:format(args.spellName))
end

function mod:AlarmCasts(args)
	if throttleMessages(args.spellId) then return end
	self:MessageOld(args.spellId, "red", "alarm", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:PeriodicDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "warning", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:Fortification(args)
	if self:Dispeller("magic", true) and not UnitIsPlayer(args.destName) then -- mages can spellsteal it
		self:TargetMessageOld(args.spellId, args.destName, "orange", not throttleMessages(args.spellId) and "alert", nil, nil, true)
	end
end

function mod:Suppress(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", not throttleMessages(args.spellId) and "alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 6, args.destName)
end

function mod:SingleTargetDebuffs(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "orange", not throttleMessages(args.spellId) and "alert", nil, nil, self:Dispeller("magic"))
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

function mod:SingleTargetDebuffsRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

do
	local playerList = mod:NewTargetList()
	function mod:SealMagic(args)
		playerList[#playerList + 1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, args.destName, "orange", not throttleMessages(args.spellId) and "alert", nil, nil, self:Dispeller("magic"))
		end
	end
end

function mod:DisintegrationBeam(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:CastBar(args.spellId, 5)
end

function mod:EyeStorm(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:CastBar(args.spellId, 8)
end

do
	local prev = 0
	function mod:PickingUp(args)
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:TargetMessageOld(args.spellId, args.sourceName, "cyan", "info")
		end
	end
end

do
	local prev = 0
	function mod:PickingUpSuccess(args)
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:TargetMessageOld(args.spellId, args.sourceName, "green", "long", args.destName)
		end
	end
end
