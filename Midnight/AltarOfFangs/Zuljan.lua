--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zul'jan", 2993, 2880)
if not mod then return end
mod:SetEncounterID(3458)
mod:SetRespawnTime(30)
mod:SetAuraData({
	{1300885}, -- Ritual of the Fang
	{1300894, soundOnApplied = "info", soundOnAppliedDose = "none"}, -- Ritual Venom
	{1301508}, -- Boneslicer
	{1301231, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Bloodletting
})

--------------------------------------------------------------------------------
-- Locals
--

local ritualOfTheFangCount = 1
local axegrinderCount = 1
local chopDownCount = 1
local boneslicerCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1300876] = {1300876}, -- Ritual of the Fang
	[1301111] = {1301111}, -- Axegrinder
	[1301350] = {1301350}, -- Chop Down
	[1301413] = {1301413, CL.you:format(mod:SpellName(1301413)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1301413, CL.you:format(mod:SpellName(1301413))}}, -- Boneslicer
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1300876, -- Ritual of the Fang
		1301111, -- Axegrinder
		{1301350, "TANK_HEALER"}, -- Chop Down
		1301413, -- Boneslicer
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	ritualOfTheFangCount = 1
	axegrinderCount = 1
	chopDownCount = 1
	boneslicerCount = 1
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

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 3 or duration == 65 then -- Ritual of the Fang
		barInfo = self:RitualOfTheFangTimeline(eventInfo)
	elseif duration == 18 then -- Axegrinder
		barInfo = self:AxegrinderTimeline(eventInfo)
	elseif duration == 26 or (not self:IsWiping() and duration == 30) then -- Chop Down
		barInfo = self:ChopDownTimeline(eventInfo)
	elseif duration == 36 or duration == 16 then -- Boneslicer
		barInfo = self:BoneslicerTimeline(eventInfo)
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

function mod:RitualOfTheFangTimeline(eventInfo) -- Ritual of the Fang
	local barText = CL.count:format(self:GetRename(1300876), ritualOfTheFangCount)
	self:CDBar(1300876, eventInfo.duration, barText, nil, eventInfo.id)
	if self:RoundNumber(eventInfo.duration, 0) == 3 then
		-- the 65s bar is always canceled with ~4s left and replaced by a 3s bar for the actual cast
		ritualOfTheFangCount = ritualOfTheFangCount + 1
	end
	return {
		msg = barText,
		key = 1300876,
		callback = function()
			self:Message(1300876, "cyan", barText)
			self:PlaySound(1300876, "long")
		end
	}
end

function mod:AxegrinderTimeline(eventInfo) -- Axegrinder
	local barText = CL.count:format(self:GetRename(1301111), axegrinderCount)
	self:CDBar(1301111, eventInfo.duration, barText, nil, eventInfo.id)
	axegrinderCount = axegrinderCount + 1
	return {
		msg = barText,
		key = 1301111,
		callback = function()
			self:Message(1301111, "orange", barText)
			self:PlaySound(1301111, "alert")
		end
	}
end

function mod:ChopDownTimeline(eventInfo) -- Chop Down
	local barText = CL.count:format(self:GetRename(1301350), chopDownCount)
	self:CDBar(1301350, eventInfo.duration, barText, nil, eventInfo.id)
	chopDownCount = chopDownCount + 1
	return {
		msg = barText,
		key = 1301350,
		callback = function()
			self:Message(1301350, "purple", barText)
			self:PlaySound(1301350, "alert")
		end
	}
end

function mod:BoneslicerTimeline(eventInfo) -- Boneslicer
	local barText = CL.count:format(self:GetRename(1301413), boneslicerCount)
	self:CDBar(1301413, eventInfo.duration, barText, nil, eventInfo.id)
	boneslicerCount = boneslicerCount + 1
	return {
		msg = barText,
		key = 1301413,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1301413, 1, false, self:GetRename(1301413, 2))
			self:Message(1301413, "red", barText)
			self:PlaySound(1301413, "alarm")
		end
	}
end
