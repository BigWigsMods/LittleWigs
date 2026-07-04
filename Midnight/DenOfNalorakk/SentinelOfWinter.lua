--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sentinel of Winter", 2825, 2777)
if not mod then return end
mod:SetEncounterID(3208)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1235549, sound = "alert"}, -- Glacial Torment
	{1235829, sound = "warning"}, -- Winter's Shroud
	{1235841, sound = "underyou"}, -- Snowdrift
	{1235641, sound = "underyou"}, -- Raging Squall
	{1236289, sound = "underyou"}, -- Blizzard's Wrath
})

--------------------------------------------------------------------------------
-- Locals
--

local shatteringFrostspikeCount = 1
local glacialTormentCount = 1
local ragingSquallCount = 1
local eternalWinterCount = 1
local activeBars = {}
local activeBarBySpellId = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1235783] = {1235783}, -- Shattering Frostspike
	[1235548] = {1235548}, -- Glacial Torment
	[1235623] = {1235623}, -- Raging Squall
	[1235656] = {1235656}, -- Eternal Winter
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1235783, -- Shattering Frostspike
		1235548, -- Glacial Torment
		1235623, -- Raging Squall
		1235656, -- Eternal Winter
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	shatteringFrostspikeCount = 1
	glacialTormentCount = 1
	ragingSquallCount = 1
	eternalWinterCount = 1
	activeBars = {}
	activeBarBySpellId = {}
	backupBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

function mod:OnWin()
	activeBars = {}
	activeBarBySpellId = {}
end

function mod:OnBossDisable()
	for eventID in next, backupBars do
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:CancelBarForSpell(spellId)
	local priorEventID = activeBarBySpellId[spellId]
	if priorEventID then
		local barInfo = activeBars[priorEventID]
		if barInfo and barInfo.createdAt and (GetTime() - barInfo.createdAt) < 2 then
			self:StopBar(barInfo.msg)
			if barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[priorEventID] = nil
			activeBarBySpellId[spellId] = nil
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration > 60 then return end -- filter placeholder bars
	if duration == 7 then -- Shattering Frostspike
		self:CancelBarForSpell(1235783)
		barInfo = self:ShatteringFrostspikeTimeline(eventInfo)
	elseif duration == 17 then -- Glacial Torment
		self:CancelBarForSpell(1235548)
		barInfo = self:GlacialTormentTimeline(eventInfo)
	elseif not self:IsWiping() and duration == 30 then -- Raging Squall
		self:CancelBarForSpell(1235623)
		barInfo = self:RagingSquallTimeline(eventInfo)
	elseif duration == 38 then -- Eternal Winter
		self:CancelBarForSpell(1235656)
		barInfo = self:EternalWinterTimeline(eventInfo)
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
		barInfo.createdAt = GetTime()
		activeBars[eventInfo.id] = barInfo
		activeBarBySpellId[barInfo.key] = eventInfo.id
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		local state = C_EncounterTimeline.GetEventState(eventID)
		if state == 0 then -- Active
			self:ResumeBar(barInfo.key, barInfo.msg)
		elseif state == 1 then -- Paused
			-- all bars pause during Eternal Winter, but they are canceled when it ends.
			-- so we can just cancel them now instead of pausing.
			self:StopBar(barInfo.msg)
			activeBars[eventID] = nil
			if activeBarBySpellId[barInfo.key] == eventID then
				activeBarBySpellId[barInfo.key] = nil
			end
		elseif state == 2 then -- Finished
			self:StopBar(barInfo.msg)
			if barInfo.callback then
				barInfo.callback()
			end
			activeBars[eventID] = nil
			if activeBarBySpellId[barInfo.key] == eventID then
				activeBarBySpellId[barInfo.key] = nil
			end
		elseif state == 3 then -- Canceled
			self:StopBar(barInfo.msg)
			if not self:IsWiping() and barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[eventID] = nil
			if activeBarBySpellId[barInfo.key] == eventID then
				activeBarBySpellId[barInfo.key] = nil
			end
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
		if activeBarBySpellId[barInfo.key] == eventID then
			activeBarBySpellId[barInfo.key] = nil
		end
	elseif backupBars[eventID] then
		backupBars[eventID] = nil
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:ShatteringFrostspikeTimeline(eventInfo) -- Shattering Frostspike
	local barText = CL.count:format(self:GetRename(1235783), shatteringFrostspikeCount)
	self:CDBar(1235783, eventInfo.duration, barText, nil, eventInfo.id)
	shatteringFrostspikeCount = shatteringFrostspikeCount + 1
	return {
		msg = barText,
		key = 1235783,
		callback = function()
			self:Message(1235783, "orange", barText)
			self:PlaySound(1235783, "alarm")
		end,
		cancelCallback = function()
			shatteringFrostspikeCount = shatteringFrostspikeCount - 1
		end
	}
end

function mod:GlacialTormentTimeline(eventInfo) -- Glacial Torment
	local barText = CL.count:format(self:GetRename(1235548), glacialTormentCount)
	self:CDBar(1235548, eventInfo.duration, barText, nil, eventInfo.id)
	glacialTormentCount = glacialTormentCount + 1
	return {
		msg = barText,
		key = 1235548,
		callback = function()
			self:Message(1235548, "red", barText)
			self:PlaySound(1235548, "alert")
		end,
		cancelCallback = function()
			glacialTormentCount = glacialTormentCount - 1
		end
	}
end

function mod:RagingSquallTimeline(eventInfo) -- Raging Squall
	local barText = CL.count:format(self:GetRename(1235623), ragingSquallCount)
	self:CDBar(1235623, eventInfo.duration, barText, nil, eventInfo.id)
	ragingSquallCount = ragingSquallCount + 1
	return {
		msg = barText,
		key = 1235623,
		callback = function()
			self:Message(1235623, "cyan", barText)
			self:PlaySound(1235623, "info")
		end,
		cancelCallback = function()
			ragingSquallCount = ragingSquallCount - 1
		end
	}
end

function mod:EternalWinterTimeline(eventInfo) -- Eternal Winter
	local barText = CL.count:format(self:GetRename(1235656), eternalWinterCount)
	self:CDBar(1235656, eventInfo.duration, barText, nil, eventInfo.id)
	eternalWinterCount = eternalWinterCount + 1
	return {
		msg = barText,
		key = 1235656,
		--callback = function() has Blizzard message + sound
			--self:Message(1235656, "yellow", barText)
			--self:PlaySound(1235656, "long")
		--end,
		cancelCallback = function()
			eternalWinterCount = eternalWinterCount - 1
		end
	}
end
