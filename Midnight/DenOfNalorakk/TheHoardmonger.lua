--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Hoardmonger", 2825, 2776)
if not mod then return end
mod:SetEncounterID(3207)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1234846, sound = "info"}, -- Toxic Spores
	{1235125, sound = "alarm"}, -- Hearty Bellow
})

--------------------------------------------------------------------------------
-- Locals
--

local earthshatterSlamCount = 1
local ravenousBellowCount = 1
local spoiledSuppliesCount = 1
local activeBars = {}
local activeBarBySpellId = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1253268, -- Earthshatter Slam
		1235118, -- Ravenous Bellow
		1234233, -- Spoiled Supplies
		{1234846, "PRIVATE"}, -- Toxic Spores
		{1235125, "PRIVATE"}, -- Hearty Bellow
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	earthshatterSlamCount = 1
	ravenousBellowCount = 1
	spoiledSuppliesCount = 1
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
	if duration == 7 or duration == 21 then -- Earthshatter Slam
		self:CancelBarForSpell(1253268)
		barInfo = self:EarthshatterSlamTimeline(eventInfo)
	elseif duration == 18 then -- Ravenous Bellow
		barInfo = self:RavenousBellowTimeline(eventInfo)
	elseif duration == 39 then -- Spoiled Supplies
		barInfo = self:SpoiledSuppliesTimeline(eventInfo)
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

function mod:EarthshatterSlamTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253268), earthshatterSlamCount)
	self:CDBar(1253268, eventInfo.duration, barText, nil, eventInfo.id)
	earthshatterSlamCount = earthshatterSlamCount + 1
	return {
		msg = barText,
		key = 1253268,
		callback = function()
			self:Message(1253268, "orange", barText)
			self:PlaySound(1253268, "alarm")
		end,
		cancelCallback = function()
			earthshatterSlamCount = earthshatterSlamCount - 1
		end
	}
end

function mod:RavenousBellowTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1235118), ravenousBellowCount)
	self:CDBar(1235118, eventInfo.duration, barText, nil, eventInfo.id)
	ravenousBellowCount = ravenousBellowCount + 1
	return {
		msg = barText,
		key = 1235118,
		callback = function()
			self:Message(1235118, "red", barText)
			self:PlaySound(1235118, "alert")
		end
	}
end

function mod:SpoiledSuppliesTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1234233), spoiledSuppliesCount)
	self:CDBar(1234233, eventInfo.duration, barText, nil, eventInfo.id)
	spoiledSuppliesCount = spoiledSuppliesCount + 1
	return {
		msg = barText,
		key = 1234233,
		callback = function()
			-- cancel + decrement the Earthshatter Slam bar when this ability occurs, it will be restarted later
			local earthshatterSlamBarId = activeBarBySpellId[1253268] -- Earthshatter Slam
			if earthshatterSlamBarId then
				local barInfo = activeBars[earthshatterSlamBarId]
				self:StopBar(barInfo.msg)
				barInfo.cancelCallback()
				activeBars[earthshatterSlamBarId] = nil
				activeBarBySpellId[barInfo.key] = nil
			end
			self:Message(1234233, "yellow", barText)
			self:PlaySound(1234233, "long")
		end
	}
end
