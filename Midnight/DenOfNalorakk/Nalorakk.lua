--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nalorakk Den", 2825, 2778)
if not mod then return end
mod:SetEncounterID(3209)
mod:SetRespawnTime(30)
mod:SetAuraData({
	{1242869}, -- Echoing Maul
	{1243590, soundOnApplied = "alarm"}, -- Overwhelming Onslaught
	{1255577, soundOnApplied = "alarm", soundOnAppliedDose = "alarm"}, -- Spectral Slash
	{1262253, soundOnApplied = "alarm"}, -- Demoralizing Scream
	{1261781, soundOnApplied = "info"}, -- Defensive Stance
})

--------------------------------------------------------------------------------
-- Locals
--

local echoingMaulCount = 1
local overwhemlingOnslaughtCount = 1
local furyOfTheWarGodCount = 1
local count25 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1242860] = {1242860}, -- Echoing Maul
	[1243569] = {1243569}, -- Overwhelming Onslaught
	[1243011] = {1243011}, -- Fury of the War God
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1242860, -- Echoing Maul
		1243569, -- Overwhelming Onslaught
		1243011, -- Fury of the War God
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	echoingMaulCount = 1
	overwhemlingOnslaughtCount = 1
	furyOfTheWarGodCount = 1
	count25 = 1
	activeBars = {}
	backupBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		self:SendMessage("BigWigs_BlockBlizzMessages")
		self:RegisterEvent("ENCOUNTER_WARNING")
	end
end

function mod:OnBossDisable()
	self:SendMessage("BigWigs_AllowBlizzMessages")
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
	if self:Mythic() then
		if duration == 5 or (count25 % 2 == 1 and duration == 25) then -- Echoing Maul
			barInfo = self:EchoingMaulTimeline(eventInfo)
		elseif duration == 13 or (count25 % 2 == 0 and duration == 25) then -- Overwhelming Onslaught
			barInfo = self:OverwhemlingOnslaughtTimeline(eventInfo)
		elseif duration == 54 then -- Fury of the War God
			barInfo = self:FuryOfTheWarGodTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
		end
		if duration == 25 then
			count25 = count25 + 1
		end
	else -- Normal, Heroic
		if duration == 5 or duration == 10 then -- Echoing Maul
			barInfo = self:EchoingMaulTimeline(eventInfo)
		elseif duration == 25 then -- Fury of the War God
			barInfo = self:FuryOfTheWarGodTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
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

function mod:ENCOUNTER_WARNING(_, info)
	if info.severity == 2 then -- Fury of the War God
		local barText = CL.count:format(self:GetRename(1243011), furyOfTheWarGodCount - 1)
		self:StopBar(barText)
		self:Message(1243011, "yellow", barText)
		self:PlaySound(1243011, "long")
	end
end

function mod:EchoingMaulTimeline(eventInfo) -- Echoing Maul
	local barText = CL.count:format(self:GetRename(1242860), echoingMaulCount)
	self:CDBar(1242860, eventInfo.duration, barText, nil, eventInfo.id)
	echoingMaulCount = echoingMaulCount + 1
	local timer = self:ScheduleTimer(function()
		self:StopBar(barText)
		self:Message(1242860, "red", barText)
		self:PlaySound(1242860, "info")
	end, eventInfo.duration)
	return {
		msg = barText,
		key = 1242860,
		callback = function()
			self:Error("Echoing Maul now has a callback")
		end,
		cancelCallback = function()
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
		end
	}
end

function mod:OverwhemlingOnslaughtTimeline(eventInfo) -- Overwhelming Onslaught
	local barText = CL.count:format(self:GetRename(1243569), overwhemlingOnslaughtCount)
	self:CDBar(1243569, eventInfo.duration, barText, nil, eventInfo.id)
	overwhemlingOnslaughtCount = overwhemlingOnslaughtCount + 1
	return {
		msg = barText,
		key = 1243569,
		callback = function()
			self:Message(1243569, "orange", barText)
			self:PlaySound(1243569, "alarm")
		end
	}
end

function mod:FuryOfTheWarGodTimeline(eventInfo) -- Fury of the War God
	local barText = CL.count:format(self:GetRename(1243011), furyOfTheWarGodCount)
	self:CDBar(1243011, eventInfo.duration, barText, nil, eventInfo.id)
	furyOfTheWarGodCount = furyOfTheWarGodCount + 1
	return {
		msg = barText,
		key = 1243011,
		-- the callback is broken, so this alerts in :ENCOUNTER_WARNING instead
	}
end
