--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Council of Tribes", 1762, 2170)
if not mod then return end
mod:RegisterEnableMob(135475, 135470, 135472) -- Kula the Butcher, Aka'ali the Conqueror, Zanazal the Wise
mod:SetEncounterID(2140)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local stage = 0
local bossOrder = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Kula the Butcher
		266206, -- Whirling Axes
		266231, -- Severing Axe
		-- Aka'ali the Conqueror
		{266951, "SAY", "SAY_COUNTDOWN"}, -- Barrel Through
		{266237, "TANK"}, -- Debilitating Backhand
		-- Zanazal the Wise
		267273, -- Poison Nova
		267060, -- Call of the Elements
	}, {
		[266206] = -18261, -- Kula the Butcher
		[266951] = -18264, -- Aka'ali the Conqueror
		[267273] = -18267, -- Zanazal the Wise
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Barrel Through

	self:Log("SPELL_CAST_START", "PoisonNova", 267273)
	self:Log("SPELL_CAST_START", "CalloftheElements", 267060)

	self:Log("SPELL_CAST_START", "WhirlingAxes", 266206)
	self:Log("SPELL_CAST_SUCCESS", "SeveringAxeSuccess", 266231)
	self:Log("SPELL_AURA_APPLIED", "SeveringAxeApplied", 266231)

	self:Log("SPELL_CAST_START", "DebilitatingBackhand", 266237)
end

function mod:OnEngage()
	stage = 0
	bossOrder = {}
	self:SetStage(1)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	-- IEEU engages the boss module, so the first time the event fires, it is not yet registered here.
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local whirlingAxesCount = 1
local severingAxeCount = 1
local barrelThroughCount = 1
local debilitatingBackhandCount = 1
local arcLightningCount = 1
local poisonNovaCount = 1
local calloftheElementsCount = 1
local akaaliAlive = true
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[266206] = {266206}, -- Whirling Axes
		[266231] = {266231}, -- Severing Axe
		[267494] = {267494}, -- Barrel Through
		[266237] = {266237}, -- Debilitating Backhand
		[1305810] = {1305810}, -- Arc Lightning
		[267273] = {267273}, -- Poison Nova
		[267060] = {267060}, -- Call of the Elements
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			-- Kula the Butcher
			266206, -- Whirling Axes
			266231, -- Severing Axe
			-- Aka'ali the Conqueror
			267494, -- Barrel Through
			266237, -- Debilitating Backhand
			-- Zanazal the Wise
			1305810, -- Arc Lightning
			267273, -- Poison Nova
			267060, -- Call of the Elements
		}, {
			[266206] = -18261, -- Kula the Butcher
			[267494] = -18264, -- Aka'ali the Conqueror
			[1305810] = -18267, -- Zanazal the Wise
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		whirlingAxesCount = 1
		severingAxeCount = 1
		barrelThroughCount = 1
		debilitatingBackhandCount = 1
		arcLightningCount = 1
		poisonNovaCount = 1
		calloftheElementsCount = 1
		akaaliAlive = true
		activeBars = {}
		backupBars = {}
		self:SetStage(1)
		if self:ShouldShowBars() then
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		end
	end

	function mod:OnBossDisable()
		for eventID in next, backupBars do
			self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
		end
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration == 8 or duration == 14.8 then -- Whirling Axes
		barInfo = self:WhirlingAxesTimeline(eventInfo)
	elseif duration == 15 or duration == 16.5 then -- Severing Axe
		barInfo = self:SeveringAxeTimeline(eventInfo)
	elseif duration == 5 or (akaaliAlive and duration == 20) then -- Barrel Through
		barInfo = self:BarrelThroughTimeline(eventInfo)
	elseif duration == 14 or duration == 22 then -- Debilitating Backhand
		barInfo = self:DebilitatingBackhandTimeline(eventInfo)
	elseif duration == 2 or duration == 7 then -- Arc Lightning
		barInfo = self:ArcLightningTimeline(eventInfo)
	elseif duration == 10 or duration == 24.4 then -- Poison Nova
		barInfo = self:PoisonNovaTimeline(eventInfo)
	elseif duration == 20 or duration == 52.5 then -- Call of the Elements
		barInfo = self:CallOfTheElementsTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if barInfo then
		activeBars[eventInfo.id] = barInfo
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		local state = C_EncounterTimeline.GetEventState(eventID)
		if state == 0 then -- Active
			self:ResumeBar(barInfo.key, barInfo.msg)
		elseif state == 1 then -- Paused
			self:PauseBar(barInfo.key, barInfo.msg)
		elseif state == 2 then -- Finished
			self:StopBar(barInfo.msg)
			if barInfo.callback then
				barInfo.callback()
			end
			activeBars[eventID] = nil
		elseif state == 3 then -- Canceled
			self:StopBar(barInfo.msg)
			if barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[eventID] = nil
		end
	elseif backupBars[eventID] then
		local newState = C_EncounterTimeline.GetEventState(eventID)
		if newState == 0 then -- Enum.EncounterTimelineEventState.Active
			self:SendMessage("BigWigs_ResumeBar", nil, nil, eventID)
		elseif newState == 1 then -- Enum.EncounterTimelineEventState.Paused
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventID)
		else -- Canceled / Finished
			self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_REMOVED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		self:StopBar(barInfo.msg)
		activeBars[eventID] = nil
	elseif backupBars[eventID] then
		backupBars[eventID] = nil
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:WhirlingAxesTimeline(eventInfo) -- Whirling Axes
	local barText = CL.count:format(self:GetRename(266206), whirlingAxesCount)
	self:CDBar(266206, eventInfo.duration, barText, nil, eventInfo.id)
	whirlingAxesCount = whirlingAxesCount + 1
	return {
		msg = barText,
		key = 266206,
		callback = function()
			self:Message(266206, "orange", barText)
			self:PlaySound(266206, "alarm")
		end
	}
end

function mod:SeveringAxeTimeline(eventInfo) -- Severing Axe
	local barText = CL.count:format(self:GetRename(266231), severingAxeCount)
	self:CDBar(266231, eventInfo.duration, barText, nil, eventInfo.id)
	severingAxeCount = severingAxeCount + 1
	return {
		msg = barText,
		key = 266231,
		callback = function()
			self:Message(266231, "yellow", barText)
			self:PlaySound(266231, "alert")
		end
	}
end

function mod:BarrelThroughTimeline(eventInfo) -- Barrel Through
	if self:GetStage() == 1 then
		self:SetStage(2)
	end
	local barText = CL.count:format(self:GetRename(267494), barrelThroughCount)
	self:CDBar(267494, eventInfo.duration, barText, nil, eventInfo.id)
	barrelThroughCount = barrelThroughCount + 1
	return {
		msg = barText,
		key = 267494,
		callback = function()
			self:TargetMessageFromBlizzMessage(267494, 1, "red", false)
			self:PlaySound(267494, "info")
		end,
		cancelCallback = function()
			akaaliAlive = false
		end
	}
end

function mod:DebilitatingBackhandTimeline(eventInfo) -- Debilitating Backhand
	local barText = CL.count:format(self:GetRename(266237), debilitatingBackhandCount)
	self:CDBar(266237, eventInfo.duration, barText, nil, eventInfo.id)
	debilitatingBackhandCount = debilitatingBackhandCount + 1
	return {
		msg = barText,
		key = 266237,
		callback = function()
			self:Message(266237, "purple", barText)
			self:PlaySound(266237, "alert")
		end
	}
end

function mod:ArcLightningTimeline(eventInfo) -- Arc Lightning
	if self:GetStage() == 2 then
		self:SetStage(3)
	end
	local barText = CL.count:format(self:GetRename(1305810), arcLightningCount)
	self:CDBar(1305810, eventInfo.duration, barText, nil, eventInfo.id)
	arcLightningCount = arcLightningCount + 1
	return {
		msg = barText,
		key = 1305810,
		callback = function()
			self:Message(1305810, "orange", barText)
			self:PlaySound(1305810, "alarm")
		end
	}
end

function mod:PoisonNovaTimeline(eventInfo) -- Poison Nova
	local barText = CL.count:format(self:GetRename(267273), poisonNovaCount)
	self:CDBar(267273, eventInfo.duration, barText, nil, eventInfo.id)
	poisonNovaCount = poisonNovaCount + 1
	return {
		msg = barText,
		key = 267273,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(267273, "red", barText)
			self:PlaySound(267273, "alert")
		end
	}
end

function mod:CallOfTheElementsTimeline(eventInfo) -- Call of the Elements
	local barText = CL.count:format(self:GetRename(267060), calloftheElementsCount)
	self:CDBar(267060, eventInfo.duration, barText, nil, eventInfo.id)
	calloftheElementsCount = calloftheElementsCount + 1
	return {
		msg = barText,
		key = 267060,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(267060, "yellow", barText)
			self:PlaySound(267060, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function startTimer(mobId, time)
		if mobId == 135475 then -- Kula the Butcher
			mod:Bar(266206, time) -- Whirling Axes
		elseif mobId == 135470 then -- Aka'ali the Conqueror
			mod:Bar(266951, time) -- Barrel Through
		elseif mobId == 135472 then -- Zanazal the Wise
			mod:Bar(267273, time) -- Poison Nova
		end
	end

	function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		-- IEEU fires on living boss spawn and death
		-- mobId will be nil if the boss died
		local guid = self:UnitGUID("boss1")
		if guid then -- Boss spawned
			stage = stage + 1
			self:SetStage(stage)
			local mobId = self:MobId(guid)
			bossOrder[stage] = mobId
			-- Start timers
			if mobId == 135475 then -- Kula the Butcher
				self:Bar(266206, 8) -- Whirling Axes
				self:Bar(266231, 24) -- Severing Axe
			elseif mobId == 135470 then -- Aka'ali the Conqueror
				self:Bar(266951, 5.5) -- Barrel Through
			elseif mobId == 135472 then -- Zanazal the Wise
				self:Bar(267273, 16) -- Poison Nova
				self:Bar(267060, 20) -- Call of the Elements
			end

			if stage == 2 or stage == 3 then
				self:Message("stages", "cyan", CL.stage:format(stage), false)
				self:PlaySound("stages", "long")
				-- The dead bosses use their abilities a number of seconds after the current living one spawns
				startTimer(bossOrder[1], 15.8)
				if stage == 3 then
					startTimer(bossOrder[2], 48.1)
				end
			end
		else -- Boss killed
			-- Kula the Butcher
			self:StopBar(266231) -- Severing Axe
			self:StopBar(266206) -- Whirling Axes
			-- Aka'ali the Conqueror
			self:StopBar(266951) -- Barrel Through
			self:CancelSayCountdown(266951) -- Barrel Through
			self:StopBar(266237) -- Debilitating Backhan
			-- Zanazal the Wise
			self:StopBar(267060) -- Call of the Elements
			self:StopBar(267273) -- Poison Nova
			if stage == 1 or stage == 2 then
				self:Bar("stages", 6, CL.stage:format(stage + 1), "achievement_dungeon_kingsrest")
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if not self:IsSecret(msg) and msg:find("266951") then -- Barrel Through
		self:TargetMessage(266951, "red", destName)
		local guid = self:UnitGUID(destName)
		if self:Me(guid) then
			self:Say(266951, nil, nil, "Barrel Through")
			self:SayCountdown(266951, 8)
		end
		local mobId = self:MobId(self:UnitGUID("boss1"))
		if mobId == 135470 then -- Aka'ali the Conqueror
			self:Bar(266951, 23.1) -- Barrel Through
			self:Bar(266237, 9) -- Debilitating Backhand
		else
			self:Bar(266951, 51) -- Barrel Through
		end
		self:PlaySound(266951, "info", nil, destName)
	end
end

function mod:PoisonNova(args)
	self:Message(args.spellId, "red")
	local mobId = self:MobId(self:UnitGUID("boss1"))
	self:Bar(args.spellId, mobId == 135472 and 29.2 or 51) -- Zanazal the Wise
	self:PlaySound(args.spellId, "alert")
end

function mod:CalloftheElements(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 53.5) -- Can be delayed if the boss is casting Poison Nova
	self:PlaySound(args.spellId, "long")
end

function mod:WhirlingAxes(args)
	self:Message(args.spellId, "orange")
	local mobId = self:MobId(self:UnitGUID("boss1"))
	self:Bar(args.spellId, mobId == 135475 and 10.9 or 50) -- Kula the Butcher
	self:PlaySound(args.spellId, "alarm")
end

function mod:SeveringAxeSuccess(args)
	self:Bar(args.spellId, 21.9)
end

function mod:SeveringAxeApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:DebilitatingBackhand(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end
