--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Corewarden Nysarra", 2915, 2814)
if not mod then return end
mod:SetEncounterID(3332)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1247975, sound = "info"}, -- Lightscar Flare
	{1271433, sound = "none"}, -- Lightscar Flare
	{1249020, sound = "alarm"}, -- Eclipsing Step
	{1252828, sound = "alarm"}, -- Void Gash
})
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local umbralLashCount = 1
local eclipsingStepCount = 1
local nullVanguardCount = 1
local lightscarFlareCount = 1
local devourTheUnworthyCount = 1
local count61 = 1
local activeBars = {}
local activeBarBySpellId = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1247937, "TANK_HEALER"}, -- Umbral Lash
		1249014, -- Eclipsing Step
		1252703, -- Null Vanguard
		1264439, -- Lightscar Flare
		1271684, -- Devour the Unworthy
		--{1247975, "PRIVATE"}, -- Lightscar Flare
		--{1271433, "PRIVATE"}, -- Lightscar Flare
		--{1249020, "PRIVATE"}, -- Eclipsing Step
		{1252828, "PRIVATE"}, -- Void Gash
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	umbralLashCount = 1
	eclipsingStepCount = 1
	nullVanguardCount = 1
	lightscarFlareCount = 1
	devourTheUnworthyCount = 1
	count61 = 1
	activeBars = {}
	activeBarBySpellId = {}
	self:SetStage(1)
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
	if C_EncounterTimeline.GetEventState(eventInfo.id) == 1 then -- Paused
		return -- ignore paused bars when added, they are always canceled some time later
	end
	local duration = self:RoundNumber(eventInfo.duration, 2)
	local barInfo
	if duration > 100 then return end -- filter fake Devour the Unworthy (102.4)
	if duration == 3 or duration == 16.85 then -- Umbral Lash
		self:CancelBarForSpell(1247937)
		barInfo = self:UmbralLashTimeline(eventInfo)
	elseif duration == 5 or duration == 18 then -- Eclipsing Step
		self:CancelBarForSpell(1249014)
		barInfo = self:EclipsingStepTimeline(eventInfo)
	elseif self:GetStage() == 1 and (duration == 15 or (duration == 61 and count61 % 2 == 1)) then -- Null Vanguard
		self:CancelBarForSpell(1252703)
		barInfo = self:NullVanguardTimeline(eventInfo)
	elseif duration == 28 or (duration == 61 and count61 % 2 == 0) then -- Lightscar Flare
		self:CancelBarForSpell(1264439)
		barInfo = self:LightscarFlareTimeline(eventInfo)
	elseif self:GetStage() == 2 and duration == 15 then -- Devour the Unworthy
		barInfo = self:DevourTheUnworthyTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 61 then
		count61 = count61 + 1
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
			self:PauseBar(barInfo.key, barInfo.msg)
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
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:UmbralLashTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1247937), umbralLashCount)
	self:CDBar(1247937, eventInfo.duration, barText, nil, eventInfo.id)
	umbralLashCount = umbralLashCount + 1
	return {
		msg = barText,
		key = 1247937,
		callback = function()
			self:Message(1247937, "purple", barText)
			self:PlaySound(1247937, "alert")
		end,
		cancelCallback = function()
			umbralLashCount = umbralLashCount - 1
		end
	}
end

function mod:EclipsingStepTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1249014), eclipsingStepCount)
	self:CDBar(1249014, eventInfo.duration, barText, nil, eventInfo.id)
	eclipsingStepCount = eclipsingStepCount + 1
	return {
		msg = barText,
		key = 1249014,
		callback = function()
			self:Message(1249014, "orange", barText)
			self:PlaySound(1249014, "alert")
		end,
		cancelCallback = function()
			eclipsingStepCount = eclipsingStepCount - 1
		end
	}
end

function mod:NullVanguardTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1252703), nullVanguardCount)
	self:CDBar(1252703, eventInfo.duration, barText, nil, eventInfo.id)
	nullVanguardCount = nullVanguardCount + 1
	return {
		msg = barText,
		key = 1252703,
		callback = function()
			self:Message(1252703, "cyan", barText)
			self:PlaySound(1252703, "info")
		end,
		cancelCallback = function()
			nullVanguardCount = nullVanguardCount - 1
		end
	}
end

function mod:LightscarFlareTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1264439), lightscarFlareCount)
	self:CDBar(1264439, eventInfo.duration, barText, nil, eventInfo.id)
	lightscarFlareCount = lightscarFlareCount + 1
	return {
		msg = barText,
		key = 1264439,
		callback = function()
			-- in ~9 seconds this cast will finish
			self:ScheduleTimer(function()
				self:SetStage(2)
				self:ScheduleTimer(function()
					-- 18s cast
					self:SetStage(1)
				end, 18)
				self:Message(1264439, "yellow", barText)
				self:PlaySound(1264439, "long")
			end, 9)
		end,
		cancelCallback = function()
			local priorEventID = activeBarBySpellId[1264439]
			if priorEventID then
				local barInfo = activeBars[priorEventID]
				if barInfo and barInfo.createdAt and (GetTime() - barInfo.createdAt) > 10 then
					-- in ~9 seconds this cast will finish
					self:ScheduleTimer(function()
						self:SetStage(2)
						self:ScheduleTimer(function()
							-- 18s cast
							self:SetStage(1)
						end, 18)
						self:Message(1264439, "yellow", barText)
						self:PlaySound(1264439, "long")
					end, 9)
				else
					lightscarFlareCount = lightscarFlareCount - 1
				end
			end
		end
	}
end

function mod:DevourTheUnworthyTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1271684), devourTheUnworthyCount)
	self:CDBar(1271684, eventInfo.duration, barText, nil, eventInfo.id)
	devourTheUnworthyCount = devourTheUnworthyCount + 1
	return {
		msg = barText,
		key = 1271684,
		callback = function() -- not sure if this can actually happen
			if self:GetStage() == 2 then
				self:SetStage(1)
			end
		end,
		cancelCallback = function()
			if self:GetStage() == 2 then
				self:SetStage(1)
			end
		end
	}
end
