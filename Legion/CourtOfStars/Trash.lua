-- GLOBALS: BigWigs, table

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Court of Stars Trash", 1571)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	104251, -- Duskwatch Sentry
	107073, -- Duskwatch Reinforcement
	104246, -- Duskwatch Guard
	111563, -- Duskwatch Guard
	104270, -- Guardian Construct
	104278, -- Felbound Enforcer
	104277, -- Legion Hound
	104300, -- Shadow Mistress
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
	106018, -- Bazaar Goods
	106112, -- Wounded Nightborne Civilian
	106113, -- Lifesized Nightborne Statue
	105215, -- Discarded Junk
	108154  -- Arcane Keys
)

--------------------------------------------------------------------------------
-- Locals
--

local knownClues, clueCount = {}, 0
local englishSpyFound
local englishClueNames

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.duskwatch_sentry = "Duskwatch Sentry"
	L.duskwatch_reinforcement = "Duskwatch Reinforcement"
	L.Guard = "Duskwatch Guard"
	L.Construct = "Guardian Construct"
	L.Enforcer = "Felbound Enforcer"
	L.Hound = "Legion Hound"
	L.Mistress = "Shadow Mistress"
	L.Gerenth = "Gerenth the Vile"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Imacu'tya"
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
	L.spyFoundChat = "I found the spy!"
	L.spyFoundPattern = "Now now, let's not be hasty" -- Now now, let's not be hasty [player]. Why don't you follow me so we can talk about this in a more private setting...

	L.hints = {}
	L.hints[1] = "Cape"
	L.hints[2] = "No Cape"
	L.hints[3] = "Pouch"
	L.hints[4] = "Potions"
	L.hints[5] = "Long Sleeves"
	L.hints[6] = "Short Sleeves"
	L.hints[7] = "Gloves"
	L.hints[8] = "No Gloves"
	L.hints[9] = "Male"
	L.hints[10] = "Female"
	L.hints[11] = "Light Vest"
	L.hints[12] = "Dark Vest"
	L.hints[13] = "No Potions"
	L.hints[14] = "Book"
end

englishSpyFound = L.spyFoundChat
englishClueNames = L.hints

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"announce_buff_items",
		"custom_on_use_buff_items",
		{"spy_helper", "INFOBOX"},
		210261, -- Sound Alarm (Duskwatch Sentry)
		212773, -- Subdue (Duskwatch Reinforcement)
		209027, -- Quelling Strike (Duskwatch Guard)
		209033, -- Fortification (Duskwatch Guard)
		225100, -- Charging Station (Guardian Construct)
		209495, -- Charged Smash (Guardian Construct)
		209512, -- Disrupting Energy (Guardian Construct)
		209413, -- Suppress (Guardian Construct)
		211464, -- Fel Detonation (Felbound Enforcer)
		211391, -- Felblaze Puddle (Legion Hound)
		211470, -- Bewitch (Shadow Mistress)
		{211473, "TANK_HEALER"}, -- Shadow Slash (Shadow Mistress)
		214692, -- Shadow Bolt Volley (Gerenth the Vile)
		214688, -- Carrion Swarm (Gerenth the Vile)
		214690, -- Cripple (Gerenth the Vile)
		207979, -- Shockwave (Jazshariu)
		397897, -- Crushing Leap (Jazshariu)
		209378, -- Whirling Blades (Imacu'tya)
		397892, -- Scream of Pain (Imacu'tya)
		207980, -- Disintegration Beam (Baalgar the Watchful)
		{397907, "SAY", "SAY_COUNTDOWN"}, -- Impending Doom (Baalgar the Watchful)
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
		[210261] = L.duskwatch_sentry,
		[212773] = L.duskwatch_reinforcement,
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

function mod:OnBossEnable()
	-- Duskwatch Sentry
	self:Log("SPELL_CAST_START", "SoundAlarm", 210261)

	-- Duskwatch Reinforcement
	self:Log("SPELL_CAST_START", "Subdue", 212773)
	self:Log("SPELL_AURA_APPLIED", "SubdueApplied", 212773)

	-- Duskwatch Guard
	self:Log("SPELL_CAST_START", "QuellingStrike", 209027)
	self:Log("SPELL_CAST_START", "Fortification", 209033)
	self:Log("SPELL_AURA_APPLIED", "FortificationApplied", 209033)

	-- Mana Wyrm
	self:Log("SPELL_CAST_START", "WildDetonation", 209477)

	-- Charging Station, Shadow Bolt Volley, Carrion Swarm, Drain Magic, Nightfall Orb, Seal Magic, Uncontrolled Blast, Wild Magic, Mighty Stomp, Shadowflame Breath, Bewitch
	self:Log("SPELL_CAST_START", "AlertCasts", 225100, 214692, 214688, 209485, 209410, 209404, 216110, 216096, 216000, 216006, 211470)
	-- Fel Detonation, Searing Glare, Eye Storm, Drifting Embers, Charged Blast, Suppress, Charged Smash, Drifting Embers
	self:Log("SPELL_CAST_START", "AlarmCasts", 211464, 211299, 212784, 211401, 212031, 209413, 209495, 224377)
	-- Felblaze Puddle, Disrupting Energy
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 211391, 209512)
	-- Dispellable stuff
	self:Log("SPELL_AURA_APPLIED", "SealMagic", 209404)
	self:Log("SPELL_AURA_APPLIED", "Suppress", 209413)
	self:Log("SPELL_AURA_APPLIED", "SingleTargetDebuffs", 214690, 211470) -- Cripple, Bewitch
	self:Log("SPELL_AURA_REMOVED", "SingleTargetDebuffsRemoved", 209413, 214690, 211470) -- Suppress, Cripple, Bewitch
	-- Eye Storm
	self:Log("SPELL_CAST_SUCCESS", "EyeStorm", 212784)

	-- Shadow Mistress
	self:Log("SPELL_CAST_START", "ShadowSlash", 211473)

	-- Imacu'tya
	self:Log("SPELL_CAST_START", "WhirlingBlades", 209378)
	self:Log("SPELL_CAST_START", "ScreamOfPain", 397892)
	self:Death("ImacutyaDeath", 104275)

	-- Baalgar the Watchful
	self:Log("SPELL_CAST_START", "DisintegrationBeam", 207980)
	self:Log("SPELL_AURA_APPLIED", "DisintegrationBeamApplied", 207980)
	self:Log("SPELL_CAST_SUCCESS", "ImpendingDoom", 397907)
	self:Log("SPELL_AURA_APPLIED", "ImpendingDoomApplied", 397907)
	self:Log("SPELL_AURA_REMOVED", "ImpendingDoomRemoved", 397907)
	self:Death("BaalgarDeath", 104274)

	-- Jazshariu
	self:Log("SPELL_CAST_START", "Shockwave", 207979)
	self:Log("SPELL_CAST_SUCCESS", "CrushingLeap", 397897)
	self:Death("JazshariuDeath", 104273)

	-- Picking Up
	self:Log("SPELL_CAST_START", "PickingUp", 214697)
	self:Log("SPELL_CAST_SUCCESS", "PickingUpSuccess", 214697)

	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterMessage("BigWigs_BossComm")
	self:RegisterMessage("DBM_AddonMessage") -- Catch DBM clues

	-- ensure LittleWigs handles this event first - this prevents other addons from advancing
	-- the gossip or closing the frame before we have a chance to read the gossip ID
	local frames = {GetFramesRegisteredForEvent("GOSSIP_SHOW")}
	for i = 1, #frames do
		frames[i]:UnregisterEvent("GOSSIP_SHOW")
	end
	self:RegisterEvent("GOSSIP_SHOW")
	for i = 1, #frames do
		frames[i]:RegisterEvent("GOSSIP_SHOW")
	end
end

function mod:OnBossDisable()
	clueCount = 0
	knownClues = {}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local clueIds = {
		[45674] = 1,  -- Cape
		[45675] = 2,  -- No Cape
		[45660] = 3,  -- Pouch
		[45666] = 4,  -- Potions
		[45676] = 5,  -- Long Sleeves
		[45677] = 6,  -- Short Sleeves
		[45673] = 7,  -- Gloves
		[45672] = 8,  -- No Gloves
		[45657] = 9,  -- Male
		[45658] = 10, -- Female
		[45636] = 11, -- Light Vest
		[45635] = 12, -- Dark Vest
		[45667] = 13, -- No Potions
		[45659] = 14, -- Book
	}

	local buffItems = {
		[105157] = { -- Arcane Power Conduit: Disables Constructs
			["name"] = 210466,
			["professions"] = {
				--[136243] = 100, -- Engineering
				[4620673] = 1, -- Engineering
			},
			["races"] = {
				["Gnome"] = true,
				["Goblin"] = true,
			},
			--["gossipIds"] = {45332}, -- Engineering
		},
		[105117] = { -- Flask of the Solemn Night: Poisons first boss
			["name"] = 207815,
			["professions"] = {
				--[136240] = 100, -- Alchemy
				[4620669] = 1, -- Alchemy
			},
			["classes"] = {
				["ROGUE"] = true,
			},
			--["gossipIds"] = {45329, 45331}, -- Alchemy, Rogue
		},
		[105160] = { -- Fel Orb: 10% Crit
			["name"] = 208275,
			["classes"] = {
				["DEMONHUNTER"] = true,
				["WARLOCK"] = true,
				["PRIEST"] = true,
				["PALADIN"] = true,
			},
			--["gossipIds"] = {45327}, -- Priest
		},
		[105831] = { -- Infernal Tome: -10% Dmg taken
			["name"] = "InfernalTome",
			["classes"] = {
				["DEMONHUNTER"] = true,
				["PRIEST"] = true,
				["PALADIN"] = true,
			},
			--["gossipIds"] = {45200}, -- Priest
		},
		[106024] = { -- Magical Lantern: +10% Dmg dealt
			["name"] = "MagicalLantern",
			["classes"] = {
				["MAGE"] = true,
			},
			["professions"] = {
				--[136244] = 100, -- Enchanting
				[4620672] = 1, -- Enchanting
			},
			["races"] = {
				["BloodElf"] = true,
				["NightElf"] = true,
				["Dracthyr"] = true,
			},
		},
		[105249] = { -- Nightshade Refreshments: +25% HP
			["name"] = "NightshadeRefreshments",
			["professions"] = {
				--[133971] = 800, -- Cooking
				[4620671] = 1, -- Cooking
				--[136246] = 100, -- Herbalism
				[4620675] = 1, -- Herbalism
			},
			["races"] = {
				["Pandaren"] = true,
			},
			--["gossipIds"] = {45168}, -- Cooking
		},
		[106108] = { -- Starlight Rose Brew: +HP & Mana reg
			["name"] = "StarlightRoseBrew",
			["classes"] = {
				["DEATHKNIGHT"] = true,
				["MONK"] = true,
			},
			--["gossipIds"] = {45217}, -- Monk
		},
		[105340] = { -- Umbral Bloom: +10% Haste
			["name"] = "UmbralBloom",
			["classes"] = {
				["DRUID"] = true,
			},
			["professions"] = {
				--[136246] = 100, -- Herbalism
				[4620675] = 1, -- Herbalism
				[4620671] = 1, -- Cooking
			},
			--["gossipIds"] = {45278}, -- Cooking
		},
		[106110] = { -- Waterlogged Scroll: +30% Movement speed
			["name"] = "WaterloggedScroll",
			["classes"] = {
				["SHAMAN"] = true,
			},
			["professions"] = {
				--[134366] = 100, -- Skinning
				[4620680] = 1, -- Skinning
				--[237171] = 100, -- Inscription
				[4620676] = 1, -- Inscription
			},
			--["gossipIds"] = {45152}, -- Skinning
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
				--[136247] = 100, -- Leatherworking
				[4620678] = 1, -- Leatherworking
			},
			--["gossipIds"] = {45474}, -- Rogue
		},
		[106113] = { -- Lifesized Nightborne Statue
			["name"] = "LifesizedNightborneStatue",
			["professions"] = {
				--[134708] = 100, -- Mining
				[4620679] = 1, -- Mining
				--[134071] = 100, -- Jewelcrafting
				[4620677] = 1, -- Jewelcrafting
			},
		},
		[105215] = { -- Discarded Junk
			["name"] = "DiscardedJunk",
			["classes"] = {
				["HUNTER"] = true,
			},
			["professions"] = {
				--[136241] = 100, -- Blacksmithing
				[4620670] = 1, -- Blacksmithing
			},
		},
		[106112] = { -- Wounded Nightborne Civilian
			["name"] = "WoundedNightborneCivilian",
			["roles"] = {
				["Healer"] = true,
			},
			["professions"] = {
				--[136249] = 100, -- Tailoring
				[4620681] = 1, -- Tailoring
			},
			--["gossipIds"] = {45155}, -- Healer
		},
	}

	local professionCache = {}

	local raceIcons = {
		["Pandaren"] = "|T626190:0|t",
		["NightElf"] = "|T236449:0|t",
		["BloodElf"] = "|T236439:0|t",
		["Gnome"] = "|T236445:0|t",
		["Goblin"] = "|T632354:0|t",
		["Dracthyr"] = "|T4696175:0|t",
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
		if prefix == "M" and event == "CoS" and tonumber(clue) then
			self:BigWigs_BossComm(nil, "clue", clue)
		end
	end

	function mod:GOSSIP_SHOW()
		local mobId = self:MobId(self:UnitGUID("npc"))
		if self:GetOption("custom_on_use_buff_items") and buffItems[mobId] then
			self:SelectGossipOption(1)
			return
		end
		local spyHelperEnabled = self:GetOption("spy_helper") > 0
		for gossipId, clueId in pairs(clueIds) do
			if self:GetGossipID(gossipId) then
				if spyHelperEnabled then
					self:SelectGossipID(gossipId)
					if not knownClues[clueId] then
						local text = L.hints[clueId]
						sendChatMessage(text, englishClueNames[clueId] ~= text and englishClueNames[clueId])
					end
				end
				mod:Sync("clue", clueId)
				return
			end
		end
		if spyHelperEnabled then
			if self:GetGossipID(45624) then
				-- Use the Signal Lantern to start the boat RP
				self:SelectGossipID(45624)
			elseif self:GetGossipID(45656) then
				-- Get the costume from Ly'leth
				self:SelectGossipID(45656)
			end
		end
	end

	function mod:CHAT_MSG_MONSTER_SAY(_, msg, _, _, _, target)
		if msg:find(L.spyFoundPattern) and self:GetOption("spy_helper") > 0 then
			self:Message("spy_helper", "green", L.spyFound:format(self:ColorName(target)), false)
			self:PlaySound("spy_helper", "info")
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

-- Duskwatch Sentry

function mod:SoundAlarm(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Duskwatch Reinforcement

function mod:Subdue(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:SubdueApplied(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Duskwatch Guard

do
	local prev = 0
	function mod:QuellingStrike(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:Fortification(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:FortificationApplied(args)
	if self:Dispeller("magic", true) and not self:Player(args.destFlags) then -- Mages can spellsteal it
		self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
		if not throttleMessages(args.spellId) then
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Mana Wyrm

do
	local prev = 0
	function mod:WildDetonation(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Generic Casts

function mod:AlertCasts(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:AlarmCasts(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:PeriodicDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
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

-- Watchful Inquisitor

function mod:EyeStorm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

-- Shadow Mistress

function mod:ShadowSlash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Imacu'tya

function mod:WhirlingBlades(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.2)
end

function mod:ScreamOfPain(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 14.6)
end

function mod:ImacutyaDeath(args)
	self:StopBar(209378) -- Whirling Blades
	self:StopBar(397892) -- Scream of Pain
end

-- Baalgar the Watchful

function mod:DisintegrationBeam(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 6.1)
end

function mod:DisintegrationBeamApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "long", nil, args.destName)
end

do
	local playerList = {}

	function mod:ImpendingDoom(args)
		playerList = {}
		self:Bar(args.spellId, 14.6)
	end

	function mod:ImpendingDoomApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "orange", playerList, 2)
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Impending Doom")
			self:SayCountdown(args.spellId, 6)
		end
	end

	function mod:ImpendingDoomRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:BaalgarDeath(args)
	self:StopBar(207980) -- Disintegration Beam
	self:StopBar(397907) -- Impending Doom
end

-- Jazshariu

function mod:Shockwave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 8.5)
end

function mod:CrushingLeap(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 17)
end

function mod:JazshariuDeath(args)
	self:StopBar(207979) -- Shockwave
	self:StopBar(397897) -- Crushing Leap
end

do
	local prev = 0
	function mod:PickingUp(args)
		local t = args.time
		if t - prev > 10 then
			prev = t
			self:TargetMessage(args.spellId, "cyan", args.sourceName)
			self:PlaySound(args.spellId, "info", nil, args.sourceName)
		end
	end
end

do
	local prev = 0
	function mod:PickingUpSuccess(args)
		local t = args.time
		if t - prev > 10 then
			prev = t
			self:TargetMessage(args.spellId, "green", args.sourceName, args.destName)
			self:PlaySound(args.spellId, "long", nil, args.sourceName)
		end
	end
end
