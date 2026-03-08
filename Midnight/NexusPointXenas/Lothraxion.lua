--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lothraxion", 2915, 2815)
if not mod then return end
mod:SetEncounterID(3333)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1255310, sound = "underyou"}, -- Radiant Scar
	{1255335, sound = "alarm"}, -- Searing Rend
	{1255503, sound = "alert"}, -- Brilliant Dispersion
})

--------------------------------------------------------------------------------
-- Locals
--

local searingRendCount = 1
local brilliantDispersionCount = 1
local flickerCount = 1
local divineGuileCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1253950, -- Searing Rend
		1253855, -- Brilliant Dispersion
		1255531, -- Flicker
		1257595, -- Divine Guile
		{1255310, "PRIVATE"}, -- Radiant Scar
		{1255335, "PRIVATE"}, -- Searing Rend
		{1255503, "PRIVATE"}, -- Brilliant Dispersion
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	searingRendCount = 1
	brilliantDispersionCount = 1
	divineGuileCount = 1
	flickerCount = 1
	activeBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = math.floor(eventInfo.duration + 0.5)
	local barInfo
	if duration == 2 or duration == 26 then -- Searing Rend
		barInfo = self:SearingRendTimeline(eventInfo)
	elseif duration == 11 or duration == 25 then -- Brilliant Dispersion
		barInfo = self:BrilliantDispersionTimeline(eventInfo)
	elseif duration == 24 or duration == 10 then -- Flicker
		barInfo = self:FlickerTimeline(eventInfo)
	elseif duration == 52 then -- Divine Guile
		barInfo = self:DivineGuileTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
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

function mod:SearingRendTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253950), searingRendCount)
	self:CDBar(1253950, eventInfo.duration, barText, nil, eventInfo.id)
	searingRendCount = searingRendCount + 1
	return {
		msg = barText,
		key = 1253950,
		callback = function()
			self:Message(1253950, "purple", barText)
			self:PlaySound(1253950, "alert")
		end
	}
end

function mod:BrilliantDispersionTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253855), brilliantDispersionCount)
	self:CDBar(1253855, eventInfo.duration, barText, nil, eventInfo.id)
	brilliantDispersionCount = brilliantDispersionCount + 1
	return {
		msg = barText,
		key = 1253855,
		callback = function()
			self:Message(1253855, "yellow", barText)
			self:PlaySound(1253855, "alarm")
		end
	}
end

function mod:FlickerTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1255531), flickerCount)
	self:CDBar(1255531, eventInfo.duration, barText, nil, eventInfo.id)
	flickerCount = flickerCount + 1
	return {
		msg = barText,
		key = 1255531,
		callback = function()
			self:Message(1255531, "orange", barText)
			self:PlaySound(1255531, "alarm")
		end
	}
end

function mod:DivineGuileTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1257595), divineGuileCount)
	self:CDBar(1257595, eventInfo.duration, barText, nil, eventInfo.id)
	divineGuileCount = divineGuileCount + 1
	return {
		msg = barText,
		key = 1257595,
		callback = function()
			self:Message(1257595, "cyan", barText)
			self:PlaySound(1257595, "long")
		end
	}
end
