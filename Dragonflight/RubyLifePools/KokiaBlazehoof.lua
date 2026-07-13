--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kokia Blazehoof", 2521, 2485)
if not mod then return end
mod:RegisterEnableMob(189232) -- Kokia Blazehoof
mod:SetEncounterID(2606)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local ritualOfBlazebindingCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Kokia Blazehoof
		372863, -- Ritual of Blazebinding
		{372107, "SAY"}, -- Molten Boulder
		{372858, "TANK_HEALER"}, -- Searing Blows
		-- Blazebound Firestorm
		373017, -- Roaring Blaze
		373087, -- Burnout
	}, {
		[372863] = self.displayName,
		[373017] = -24945, -- Blazebound Firestorm
	}
end

function mod:OnBossEnable()
	-- Kokia Blazehoof
	self:Log("SPELL_CAST_START", "RitualOfBlazebinding", 372863)
	self:Log("SPELL_CAST_START", "MoltenBoulder", 372107)
	self:Log("SPELL_CAST_SUCCESS", "SearingBlows", 372858)

	-- Blazebound Firestorm
	self:Log("SPELL_CAST_START", "RoaringBlaze", 373017)
	self:Log("SPELL_CAST_START", "Burnout", 373087)
end

function mod:OnEngage()
	ritualOfBlazebindingCount = 1
	self:Bar(372863, 7.3, CL.count:format(self:SpellName(372863), 1)) -- Ritual of Blazebinding (1)
	self:Bar(372107, 14.5) -- Molten Boulder
	self:Bar(372858, 21.6) -- Searing Blows
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local moltenBoulderCount = 1
local searingBlowsCount = 1
local count40 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[372864] = {372864}, -- Ritual of Blazebinding
		[372110] = {372110}, -- Molten Boulder
		[372858] = {372858}, -- Searing Blows
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			372864, -- Ritual of Blazebinding
			372110, -- Molten Boulder
			372858, -- Searing Blows
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		ritualOfBlazebindingCount = 1
		moltenBoulderCount = 1
		searingBlowsCount = 1
		count40 = 1
		activeBars = {}
		backupBars = {}
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
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 8 or (duration == 40 and count40 % 2 == 1) then -- Ritual of Blazebinding
		barInfo = self:RitualOfBlazebindingTimeline(eventInfo)
	elseif duration == 19 or duration == 20 then -- Molten Boulder
		barInfo = self:MoltenBoulderTimeline(eventInfo)
	elseif duration == 28 or (duration == 40 and count40 % 2 == 0) then -- Searing Blows
		barInfo = self:SearingBlowsTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 40 then
		count40 = count40 + 1
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

function mod:RitualOfBlazebindingTimeline(eventInfo) -- Ritual of Blazebinding
	local barText = CL.count:format(self:GetRename(372864), ritualOfBlazebindingCount)
	self:CDBar(372864, eventInfo.duration, barText, nil, eventInfo.id)
	ritualOfBlazebindingCount = ritualOfBlazebindingCount + 1
	return {
		msg = barText,
		key = 372864,
		callback = function()
			self:TargetMessageFromBlizzMessage(372864, 1, "red", false)
			self:PlaySound(372864, "long")
		end
	}
end

function mod:MoltenBoulderTimeline(eventInfo) -- Molten Boulder
	local barText = CL.count:format(self:GetRename(372110), moltenBoulderCount)
	self:CDBar(372110, eventInfo.duration, barText, nil, eventInfo.id)
	moltenBoulderCount = moltenBoulderCount + 1
	return {
		msg = barText,
		key = 372110,
		callback = function()
			self:Message(372110, "orange", barText)
			self:PlaySound(372110, "alarm")
		end
	}
end

function mod:SearingBlowsTimeline(eventInfo) -- Searing Blows
	local barText = CL.count:format(self:GetRename(372858), searingBlowsCount)
	self:CDBar(372858, eventInfo.duration, barText, nil, eventInfo.id)
	searingBlowsCount = searingBlowsCount + 1
	return {
		msg = barText,
		key = 372858,
		callback = function()
			self:Message(372858, "purple", barText)
			self:PlaySound(372858, "alert")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Kokia Blazehoof

function mod:RitualOfBlazebinding(args)
	local ritualOfBlazebindingMessage = CL.count:format(args.spellName, ritualOfBlazebindingCount)
	self:StopBar(ritualOfBlazebindingMessage)
	ritualOfBlazebindingCount = ritualOfBlazebindingCount + 1
	self:Message(args.spellId, "red", ritualOfBlazebindingMessage)
	self:CDBar(args.spellId, 33.9, CL.count:format(args.spellName, ritualOfBlazebindingCount))
	self:PlaySound(args.spellId, "long")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(372107, "orange", name)
		if self:Me(guid) then
			self:Say(372107, nil, nil, "Molten Boulder")
		end
		self:PlaySound(372107, "alarm", nil, name)
	end

	function mod:MoltenBoulder(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:Bar(args.spellId, 17)
	end
end

function mod:SearingBlows(args)
	self:Message(args.spellId, "purple")
	self:Bar(args.spellId, 32.7)
	self:PlaySound(args.spellId, "alert")
end

-- Blazebound Firestorm

function mod:RoaringBlaze(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:Burnout(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
