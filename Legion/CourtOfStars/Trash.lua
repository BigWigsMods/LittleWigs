
-- GLOBALS: BigWigs

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Court of Stars Trash", 1087)
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
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.Guard = "Duskwatch Guard"
	L.Construct = "Guardian Construct"
	L.Enforcer = "Felbound Enforcer"
	L.Hound = "Legion Hound"
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

	L.use_buff_items = "Instantly use buff items"
	L.use_buff_items_desc = "Enable this options to instantly use the buff items around the dungeon. This will not use items which aggro the guards before the second boss."
	L.use_buff_items_icon = 211110

	L.spy_event_helper = "Spy Event Helper"
	L.spy_event_helper_desc = "Shows an InfoBox with all clues your group gathered about the spy. The clues will also be send to your party members in chat."
	L.spy_event_helper_icon = 213213

	L.clueFound = "Clue found (%d/5): |cffffffff%s|r"
	L.spyFound = "Spy found by %s!"
	L.spyFoundPattern = "Now now, let's not be hasty (.+). Why don't you follow me so we can talk about this in a more private setting..."

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

	-- Cape
	L["I heard the spy enjoys wearing capes."] = 1
	L["Someone mentioned the spy came in earlier wearing a cape."] = 1

	-- No Cape
	L["I heard that the spy left their cape in the palace before coming here."] = 2
	L["I heard the spy dislikes capes and refuses to wear one."] = 2

	-- Pouch
	L["A friend said the spy loves gold and a belt pouch filled with it."] = 3
	L["I heard the spy's belt pouch is filled with gold to show off extravagance."] = 3
	L["I heard the spy carries a magical pouch around at all times."] = 3
	L["I heard the spy's belt pouch is lined with fancy threading."] = 3

	-- Potions
	L["I heard the spy brought along some potions... just in case."] = 4
	L["I'm pretty sure the spy has potions at the belt."] = 4
	L["I heard the spy brought along potions, I wonder why?"] = 4
	L["I didn't tell you this... but the spy is masquerading as an alchemist and carrying potions at the belt."] = 4

	-- Long Sleeves
	L["I just barely caught a glimpse of the spy's long sleeves earlier in the evening."] = 5
	L["I heard the spy's outfit has long sleeves tonight."] = 5
	L["Someone said the spy is covering up their arms with long sleeves tonight."] = 5
	L["A friend of mine mentioned the spy has long sleeves on."] = 5

	-- Short Sleeves
	L["I heard the spy enjoys the cool air and is not wearing long sleeves tonight."] = 6
	L["A friend of mine said she saw the outfit the spy was wearing. It did not have long sleeves."] = 6
	L["Someone told me the spy hates wearing long sleeves."] = 6
	L["I heard the spy wears short sleeves to keep their arms unencumbered."] = 6

	-- Gloves
	L["I heard the spy always dons gloves."] = 7
	L["There's a rumor that the spy always wears gloves."] = 7
	L["Someone said the spy wears gloves to cover obvious scars."] = 7
	L["I heard the spy carefully hides their hands."] = 7

	-- No Gloves
	L["There's a rumor that the spy never has gloves on."] = 8
	L["I heard the spy dislikes wearing gloves."] = 8
	L["I heard the spy avoids having gloves on, in case some quick actions are needed."] = 8
	L["You know... I found an extra pair of gloves in the back room. The spy is likely to be bare handed somewhere around here."] = 8

	-- Male
	L["A guest said she saw him entering the manor alongside the Grand Magistrix."] = 9
	L["I heard somewhere that the spy isn't female."] = 9
	L["I heard the spy is here and he's very good looking."] = 9
	L["One of the musicians said he would not stop asking questions about the district."] = 9

	-- Female
	L["A guest saw both her and Elisande arrive together earlier."] = 10
	L["I hear some woman has been constantly asking about the district..."] = 10
	L["Someone's been saying that our new guest isn't male."] = 10
	L["They say that the spy is here and she's quite the sight to behold."] = 10

	-- Light Vest
	L["The spy definitely prefers the style of light colored vests."] = 11
	L["I heard that the spy is wearing a lighter vest to tonight's party."] = 11
	L["People are saying the spy is not wearing a darker vest tonight."] = 11

	-- Dark Vest
	L["I heard the spy's vest is a dark, rich shade this very night."] = 12
	L["The spy enjoys darker colored vests... like the night."] = 12
	L["Rumor has it the spy is avoiding light colored clothing to try and blend in more."] = 12
	L["The spy definitely prefers darker clothing."] = 12
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"use_buff_items",
		{"spy_event_helper", "INFOBOX"},
		209027, -- Quelling Strike (Duskwatch Guard)
		209033, -- Fortification (Duskwatch Guard)
		225100, -- Charging Station (Guardian Construct)
		209495, -- Charged Smash (Guardian Construct)
		209512, -- Disrupting Energy (Guardian Construct)
		{209413, "FLASH"}, -- Suppress (Guardian Construct)
		211464, -- Fel Detonation (Felbound Enforcer)
		211391, -- Felblaze Puddle (Legion Hound)
		214692, -- Shadow Bolt Volley (Gerenth the Vile)
		214688, -- Carrion Swarm (Gerenth the Vile)
		207979, -- Shockwave (Jazshariu)
		209378, -- Whirling Blades (Imacu'tya)
		{207980, "FLASH"}, -- Disintegration Beam (Baalgar the Watchful)
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
		[209027] = L.Guard,
		[225100] = L.Construct,
		[211464] = L.Enforcer,
		[211391] = L.Hound,
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
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	-- Charging Station, Shadow Bolt Volley, Carrion Swarm, Shockwave, Whirling Blades, Drain Magic, Wild Detonation, Nightfall Orb, Seal Magic, Fortification, Uncontrolled Blast, Wild Magic, Mighty Stomp, Shadowflame Breath
	self:Log("SPELL_CAST_START", "AlertCasts", 225100, 214692, 214688, 207979, 209378, 209485, 209477, 209410, 209404, 209033, 216110, 216096, 216000, 216006)
	-- Quelling Strike, Fel Detonation, Searing Glare, Eye Storm, Drifting Embers, Charged Blast, Suppress, Charged Smash, Drifting Embers
	self:Log("SPELL_CAST_START", "AlarmCasts", 209027, 211464, 211299, 212784, 211401, 212031, 209413, 209495, 224377)
	-- Felblaze Puddle, Disrupting Energy
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 211391, 209512)
	-- Suppress
	self:Log("SPELL_AURA_APPLIED", "Supress", 209413)
	-- Disintegration Beam
	self:Log("SPELL_AURA_APPLIED", "DisintegrationBeam", 207980)
	-- Eye Storm
	self:Log("SPELL_CAST_SUCCESS", "EyeStorm", 212784)
	-- Picking Up
	self:Log("SPELL_CAST_START", "PickingUp", 214697)
	self:Log("SPELL_CAST_SUCCESS", "PickingUpSuccess", 214697)

	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterMessage("BigWigs_BossComm")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local buffItems = {
		[105729] = true, -- Signal Lantern: Boat at the start
		[105157] = true, -- Arcane Power Conduit: Disables Constructs
		[105117] = true, -- Flask of the Solemn Night: Poisons first boss
		[105160] = true, -- Fel Orb: 10% Crit
		[105831] = true, -- Infernal Tome: -10% Dmg taken
		[106024] = true, -- Magical Lantern: +10% Dmg dealt
		[105249] = true, -- Nightshade Refreshments: +25% HP
		[106108] = true, -- Starlight Rose Brew: +HP & Mana reg
		[105340] = true, -- Umbral Bloom: +10% Haste
		[106110] = true, -- Waterlogged Scroll: +30% Movement speed
	}

	local timer, knownClues, clueCount = nil, {}, 0

	function mod:OnBossDisable()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		wipe(knownClues)
		clueCount = 0
	end

	local function sendChatMessage(self, msg)
		SendChatMessage(msg, IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
	end

	local function addClue(self, clue)
		if clueCount == 0 then
			self:OpenInfo("spy_event_helper", L.clues)
		end
		if not knownClues[clue] then
			knownClues[clue] = true
			clueCount = clueCount + 1
			self:SetInfo("spy_event_helper", (clueCount*2)-1, L.hints[clue])
			self:Message("spy_event_helper", "Neutral", "Info", L.clueFound:format(clueCount, L.hints[clue]), false)
		end
	end

	function mod:BigWigs_BossComm(_, msg)
		if self:GetOption("spy_event_helper") and tonumber(msg) and msg > 0 and msg <= #L.hints then
			addClue(self, msg)
		end
	end

	function mod:GOSSIP_SHOW()
		local mobId = self:MobId(UnitGUID("npc"))
		if (self:GetOption("spy_event_helper") and (mobId == 107486 or mobId == 106468)) or -- Chatty Rumormonger, Ly'leth Lunastre
		   (self:GetOption("use_buff_items") and buffItems[mobId]) then
			if GetGossipOptions() then
				if not timer then
					timer = self:ScheduleRepeatingTimer(function()
						SelectGossipOption(1)
					end, 0.01)
				end
			else
				if timer then
					self:CancelTimer(timer)
					timer = nil
				end
				if mobId == 107486 then -- Chatty Rumormonger
					local clue = GetGossipText()
					if L[clue] then
						addClue(self, L[clue])
						mod:Sync(L[clue])
						sendChatMessage(self, ("[LittleWigs] %s"):format(L.hints[L[clue]]))
					else
						sendChatMessage(self, ("[LittleWigs] %s"):format(clue))
						BigWigs:Print(format("New clue discovered '%s', tell the authors.", clue))
					end
				end
			end
		end
	end

	function mod:CHAT_MSG_MONSTER_SAY(_, msg)
		local player = msg:match(L.spyFoundPattern)
		if player then
			self:Message("spy_event_helper", "Positive", "Info", L.spyFound:format(self:ColorName(player)), false)
			self:CloseInfo("spy_event_helper")
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
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
end

function mod:AlarmCasts(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:PeriodicDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Warning", CL.underyou:format(args.spellName))
		end
	end
end

function mod:Supress(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", not throttleMessages(args.spellId) and "Alert", nil, nil, self:Dispeller("magic"))
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:DisintegrationBeam(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 5, CL.cast:format(args.spellName, args.destName))
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:EyeStorm(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 8, CL.cast:format(args.spellName))
end

function mod:PickingUp(args)
	self:TargetMessage(args.spellId, args.sourceName, "Neutral", "Info")
end

function mod:PickingUpSuccess(args)
	self:StopBar(args.spellId, args.sourceName)
	self:TargetMessage(args.spellId, args.sourceName, "Positive", "Long", args.destName)
end
