if not BigWigsLoader.isNext then return end -- 12.1
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zul'jan", 2993, 2880)
if not mod then return end
mod:SetEncounterID(3458)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1300894, sound = "info"}, -- Ritual Venom
})

--------------------------------------------------------------------------------
-- Locals
--

local ritualOfTheFangCount = 1
local axegrinderCount = 1
local chopDownCount = 1
local boneslicerCount = 1
local count14 = 1
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
		{1301350, "TANK"}, -- Chop Down
		1301413, -- Boneslicer
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	ritualOfTheFangCount = 1
	axegrinderCount = 1
	chopDownCount = 1
	boneslicerCount = 1
	count14 = 1
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
	if duration == 64 then -- Ritual of the Fang
		barInfo = self:RitualOfTheFangTimeline(eventInfo)
	elseif (duration == 14 and count14 % 2 == 1) then -- Axegrinder
		barInfo = self:AxegrinderTimeline(eventInfo)
	elseif duration == 26 or (not self:IsWiping() and duration == 30) then -- Chop Down
		barInfo = self:ChopDownTimeline(eventInfo)
	elseif duration == 32 or (duration == 14 and count14 % 2 == 0) then -- Boneslicer
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
	if duration == 14 then
		count14 = count14 + 1
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
	local barText = CL.count:format(self:GetRename(1300876), ritualOfTheFangCount + 1)
	self:CDBar(1300876, eventInfo.duration, barText, nil, eventInfo.id)
	self:Message(1300876, "cyan", CL.count:format(self:GetRename(1300876), ritualOfTheFangCount)) -- cast on pull
	ritualOfTheFangCount = ritualOfTheFangCount + 1
	self:PlaySound(1300876, "long")
	return {
		msg = barText,
		key = 1300876,
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
