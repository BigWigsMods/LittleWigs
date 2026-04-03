--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nalorakk Den", 2825, 2778)
if not mod then return end
mod:SetEncounterID(3209)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1242869, sound = "alarm"}, -- Echoing Maul
	{1243590, sound = "alarm"}, -- Overwhelming Onslaught
	{1255577, sound = "warning"}, -- Spectral Slash
	{1262253, sound = "info"}, -- Demoralizing Scream
	{1261781, sound = "info"}, -- Defensive Stance
})

--------------------------------------------------------------------------------
-- Locals
--

local echoingMaulCount = 1
local overwhemlingOnslaughtCount = 1
local forcefulRoarCount = 1
local furyOfTheWarGodCount = 1
local activeBars = {}
local activeBarBySpellId = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1242860, -- Echoing Maul
		1243569, -- Overwhelming Onslaught
		1255385, -- Forceful Roar
		1243011, -- Fury of the War God
		--{1242869, "PRIVATE"}, -- Echoing Maul
		--{1243590, "PRIVATE"}, -- Overwhelming Onslaught
		{1255577, "PRIVATE"}, -- Spectral Slash
		{1262253, "PRIVATE"}, -- Demoralizing Scream
		{1261781, "PRIVATE"}, -- Defensive Stance
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	echoingMaulCount = 1
	overwhemlingOnslaughtCount = 1
	forcefulRoarCount = 1
	furyOfTheWarGodCount = 1
	activeBars = {}
	activeBarBySpellId = {}
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
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration > 90 then return end -- filter placeholder bars
	if duration == 5 or duration == 33 then -- Echoing Maul
		self:CancelBarForSpell(1242860)
		barInfo = self:EchoingMaulTimeline(eventInfo)
	elseif duration == 15 then -- Overwhelming Onslaught
		self:CancelBarForSpell(1243569)
		barInfo = self:OverwhemlingOnslaughtTimeline(eventInfo)
	elseif duration == 27 then -- Forceful Roar
		self:CancelBarForSpell(1255385)
		barInfo = self:ForcefulRoarTimeline(eventInfo)
	elseif duration == 48 then -- Fury of the War God
		self:CancelBarForSpell(1243011)
		barInfo = self:FuryOfTheWarGodTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
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

function mod:EchoingMaulTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1242860), echoingMaulCount)
	self:CDBar(1242860, eventInfo.duration, barText, nil, eventInfo.id)
	echoingMaulCount = echoingMaulCount + 1
	return {
		msg = barText,
		key = 1242860,
		callback = function()
			self:Message(1242860, "red", barText)
			self:PlaySound(1242860, "info")
		end,
		cancelCallback = function()
			echoingMaulCount = echoingMaulCount - 1
		end
	}
end

function mod:OverwhemlingOnslaughtTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1243569), overwhemlingOnslaughtCount)
	self:CDBar(1243569, eventInfo.duration, barText, nil, eventInfo.id)
	overwhemlingOnslaughtCount = overwhemlingOnslaughtCount + 1
	return {
		msg = barText,
		key = 1243569,
		callback = function()
			self:Message(1243569, "purple", barText)
			self:PlaySound(1243569, "alert")
		end,
		cancelCallback = function()
			overwhemlingOnslaughtCount = overwhemlingOnslaughtCount - 1
		end
	}
end

function mod:ForcefulRoarTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1255385), forcefulRoarCount)
	self:CDBar(1255385, eventInfo.duration, barText, nil, eventInfo.id)
	forcefulRoarCount = forcefulRoarCount + 1
	return {
		msg = barText,
		key = 1255385,
		callback = function()
			self:Message(1255385, "orange", barText)
			self:PlaySound(1255385, "alarm")
		end,
		cancelCallback = function()
			forcefulRoarCount = forcefulRoarCount - 1
		end
	}
end

function mod:FuryOfTheWarGodTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1243011), furyOfTheWarGodCount)
	self:CDBar(1243011, eventInfo.duration, barText, nil, eventInfo.id)
	furyOfTheWarGodCount = furyOfTheWarGodCount + 1
	return {
		msg = barText,
		key = 1243011,
		callback = function()
			-- cancel + decrement the Echoing Maul bar when this ability occurs, it will be restarted later
			local echoingMaulBarId = activeBarBySpellId[1242860] -- Echoing Maul
			if echoingMaulBarId then
				local barInfo = activeBars[echoingMaulBarId]
				self:StopBar(barInfo.msg)
				barInfo.cancelCallback()
				activeBars[echoingMaulBarId] = nil
				activeBarBySpellId[barInfo.key] = nil
			end
			-- has Blizzard message
			--self:Message(1243011, "yellow", barText)
			--self:PlaySound(1243011, "long")
		end,
		cancelCallback = function()
			furyOfTheWarGodCount = furyOfTheWarGodCount - 1
		end
	}
end
