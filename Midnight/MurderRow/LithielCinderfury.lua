--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lithiel Cinderfury", 2813, 2682)
if not mod then return end
mod:SetEncounterID(3105)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
})

--------------------------------------------------------------------------------
-- Locals
--

local summonVilefiendCount = 1
local fingersOfGuldanCount = 1
local maleficWaveCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[474408] = {474408},   -- Summon Vilefiend
	[1218203] = {1218203}, -- Fingers of Gul'dan
	[1224478] = {1224478}, -- Malefic Wave
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		474408, -- Summon Vilefiend
		1218203, -- Fingers of Gul'dan
		1224478, -- Malefic Wave
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	summonVilefiendCount = 1
	fingersOfGuldanCount = 1
	maleficWaveCount = 1
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
	if duration == 10 or duration == 57 then -- Summon Vilefiend
		barInfo = self:SummonVilefiendTimeline(eventInfo)
	elseif duration == 15 or duration == 55 then -- Fingers of Gul'dan
		barInfo = self:FingersOfGuldanTimeline(eventInfo)
	elseif duration == 24 or duration == 59 then -- Malefic Wave
		barInfo = self:MaleficWaveTimeline(eventInfo)
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

function mod:SummonVilefiendTimeline(eventInfo) -- Summon Vilefiend
	local barText = CL.count:format(self:GetRename(474408), summonVilefiendCount)
	self:CDBar(474408, eventInfo.duration, barText, nil, eventInfo.id)
	summonVilefiendCount = summonVilefiendCount + 1
	return {
		msg = barText,
		key = 474408,
		callback = function()
			self:Message(474408, "cyan", barText)
			self:PlaySound(474408, "info")
		end
	}
end

function mod:FingersOfGuldanTimeline(eventInfo) -- Fingers of Gul'dan
	local barText = CL.count:format(self:GetRename(1218203), fingersOfGuldanCount)
	self:CDBar(1218203, eventInfo.duration, barText, nil, eventInfo.id)
	fingersOfGuldanCount = fingersOfGuldanCount + 1
	return {
		msg = barText,
		key = 1218203,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1218203, "orange", barText)
			self:PlaySound(1218203, "alarm")
		end
	}
end

if BigWigsLoader.isNext then -- XXX remove in 12.1
	function mod:MaleficWaveTimeline(eventInfo) -- Malefic Wave
		local barText = CL.count:format(self:GetRename(1224478), maleficWaveCount)
		self:CDBar(1224478, eventInfo.duration, barText, nil, eventInfo.id)
		maleficWaveCount = maleficWaveCount + 1
		return {
			msg = barText,
			key = 1224478,
			callback = function()
				self:StopBlizzMessages(1)
				self:Message(1224478, "red", barText)
				self:PlaySound(1224478, "warning")
			end
		}
	end
else
	function mod:MaleficWaveTimeline(eventInfo) -- Malefic Wave
		local barText = CL.count:format(self:GetRename(1224478), maleficWaveCount)
		self:CDBar(1224478, eventInfo.duration, barText, nil, eventInfo.id)
		maleficWaveCount = maleficWaveCount + 1
		local timer = self:ScheduleTimer(function()
			self:StopBar(barText)
			self:Message(1224478, "red", barText)
			self:PlaySound(1224478, "warning")
		end, eventInfo.duration)
		return {
			msg = barText,
			key = 1224478,
			callback = function()
				self:Error("Malefic Wave now has a callback")
			end,
			cancelCallback = function()
				if timer then
					self:CancelTimer(timer)
					timer = nil
				end
			end
		}
	end
end
