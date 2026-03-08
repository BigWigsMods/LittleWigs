--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vordaza", 2874, 2811)
if not mod then return end
mod:SetEncounterID(3213)
mod:SetRespawnTime(30)
mod:SetStage(1)
mod:SetPrivateAuraSounds({
	{1251568, sound = "none"}, -- Drain Soul
	{1251775, sound = "warning"}, -- Final Pursuit
	{1251813, sound = "info"}, -- Lingering Dread
	{1251833, sound = "underyou"}, -- Soulrot
	{1252130, sound = "alarm"}, -- Unmake
	{1266706, sound = "info"}, -- Haunting Remains
})

--------------------------------------------------------------------------------
-- Locals
--

local drainSoulCount = 1
local wrestPhantomsCount = 1
local unmakeCount = 1
local necroticConvergenceCount = 1
local count33_5 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1251554, -- Drain Soul
		1251204, -- Wrest Phantoms
		1252054, -- Unmake
		1250708, -- Necrotic Convergence
		{1251568, "PRIVATE"}, -- Drain Soul
		{1251775, "PRIVATE"}, -- Final Pursuit
		{1251813, "PRIVATE"}, -- Lingering Dread
		{1251833, "PRIVATE"}, -- Soulrot
		{1252130, "PRIVATE"}, -- Unmake
		{1266706, "PRIVATE"}, -- Haunting Remains
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	drainSoulCount = 1
	wrestPhantomsCount = 1
	unmakeCount = 1
	necroticConvergenceCount = 1
	count33_5 = 1
	activeBars = {}
	self:SetStage(1)
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

function mod:OnWin()
	activeBars = {}
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = math.floor(eventInfo.duration * 100.0 + 0.5) / 100.0
	local barInfo
	if duration == 3 or (duration == 33.5 and count33_5 % 3 == 1) then -- Drain Soul
		barInfo = self:DrainSoulTimeline(eventInfo)
	elseif duration == 14.17 or (duration == 33.5 and count33_5 % 3 == 2) then -- Wrest Phantoms
		barInfo = self:WrestPhantomsTimeline(eventInfo)
	elseif duration == 25.33 or (duration == 33.5 and count33_5 % 3 == 0) then -- Unmake
		barInfo = self:UnmakeTimeline(eventInfo)
	elseif duration == 70 then -- Necrotic Convergence
		barInfo = self:NecroticConvergenceTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 33.5 then
		count33_5 = count33_5 + 1
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
			if not self:IsWiping() and barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[eventID] = nil
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_REMOVED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		self:StopBar(barInfo.msg)
		activeBars[eventID] = nil
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:DrainSoulTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1251554), drainSoulCount)
	self:CDBar(1251554, eventInfo.duration, barText, nil, eventInfo.id)
	drainSoulCount = drainSoulCount + 1
	return {
		msg = barText,
		key = 1251554,
		callback = function()
			self:Message(1251554, "purple", barText)
			self:PlaySound(1251554, "alert")
		end
	}
end

function mod:WrestPhantomsTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1251204), wrestPhantomsCount)
	self:CDBar(1251204, eventInfo.duration, barText, nil, eventInfo.id)
	wrestPhantomsCount = wrestPhantomsCount + 1
	return {
		msg = barText,
		key = 1251204,
		callback = function()
			self:Message(1251204, "cyan", barText)
			self:PlaySound(1251204, "info")
		end
	}
end

function mod:UnmakeTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1252054), unmakeCount)
	self:CDBar(1252054, eventInfo.duration, barText, nil, eventInfo.id)
	unmakeCount = unmakeCount + 1
	return {
		msg = barText,
		key = 1252054,
		callback = function()
			self:Message(1252054, "orange", barText)
			self:PlaySound(1252054, "alarm")
		end
	}
end

function mod:NecroticConvergenceTimeline(eventInfo)
	self:SetStage(1)
	local barText = CL.count:format(self:SpellName(1250708), necroticConvergenceCount)
	self:CDBar(1250708, eventInfo.duration, barText, nil, eventInfo.id)
	necroticConvergenceCount = necroticConvergenceCount + 1
	return {
		msg = barText,
		key = 1250708,
		cancelCallback = function()
			self:SetStage(2)
			self:Message(1250708, "yellow", barText)
			self:PlaySound(1250708, "long")
		end
	}
end
