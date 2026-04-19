--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Arcanotron Custos", 2811, 2659)
if not mod then return end
mod:SetEncounterID(3071)
mod:SetRespawnTime(30)
mod:SetStage(1)
mod:SetPrivateAuraSounds({
	{1214038, sound = "alarm"}, -- Ethereal Shackles
	{1214089, sound = "underyou"}, -- Arcane Residue
	{1243905, sound = "warning"}, -- Unstable Energy
})

--------------------------------------------------------------------------------
-- Locals
--

local repulsingSlamCount = 1
local arcaneExpulsionCount = 1
local etherealShacklesCount = 1
local refuelingProtocolCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		474496, -- Repulsing Slam
		1214081, -- Arcane Expulsion
		1214032, -- Ethereal Shackles
		{474345, "CASTBAR"}, -- Refueling Protocol
		--{1214038, "PRIVATE"}, -- Ethereal Shackles
		{1214089, "PRIVATE"}, -- Arcane Residue
		{1243905, "PRIVATE"}, -- Unstable Energy
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	repulsingSlamCount = 1
	arcaneExpulsionCount = 1
	etherealShacklesCount = 1
	refuelingProtocolCount = 1
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
	if C_EncounterTimeline.GetEventState(eventInfo.id) == 1 then -- Paused
		return -- ignore paused bars when added, they are always canceled some time later
	end
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration > 50 then return end -- filter placeholder bars
	if duration == 5 or duration == 22.5 then -- Repulsing Slam
		if duration == 22.5 and repulsingSlamCount > refuelingProtocolCount * 2 then
			return -- prevent bars that are always canceled by Refueling Protocol
		end
		barInfo = self:RepulsingSlamTimeline(eventInfo)
	elseif duration == 15 or duration == 23 then -- Arcane Expulsion
		if duration == 23 and arcaneExpulsionCount > refuelingProtocolCount * 2 then
			return -- prevent bars that are always canceled by Refueling Protocol
		end
		barInfo = self:ArcaneExpulsionTimeline(eventInfo)
	elseif duration == 22 then -- Ethereal Shackles
		barInfo = self:EtherealShacklesTimeline(eventInfo)
	elseif duration == 45 or duration == 48 then -- Refueling Protocol
		barInfo = self:RefuelingProtocolTimeline(eventInfo)
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
			-- ignore bar pausing, we re-use a bar that pauses as the Refueling Protocol castbar
			return
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

function mod:RepulsingSlamTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(474496), repulsingSlamCount)
	self:CDBar(474496, eventInfo.duration, barText, nil, eventInfo.id)
	repulsingSlamCount = repulsingSlamCount + 1
	return {
		msg = barText,
		key = 474496,
		callback = function()
			self:Message(474496, "purple", barText)
			self:PlaySound(474496, "alert")
		end,
		cancelCallback = function()
			repulsingSlamCount = repulsingSlamCount - 1
		end
	}
end

function mod:ArcaneExpulsionTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1214081), arcaneExpulsionCount)
	self:CDBar(1214081, eventInfo.duration, barText, nil, eventInfo.id)
	arcaneExpulsionCount = arcaneExpulsionCount + 1
	return {
		msg = barText,
		key = 1214081,
		callback = function()
			self:Message(1214081, "orange", barText)
			self:PlaySound(1214081, "alarm")
		end,
		cancelCallback = function()
			arcaneExpulsionCount = arcaneExpulsionCount - 1
		end
	}
end

function mod:EtherealShacklesTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1214032), etherealShacklesCount)
	self:CDBar(1214032, eventInfo.duration, barText, nil, eventInfo.id)
	etherealShacklesCount = etherealShacklesCount + 1
	return {
		msg = barText,
		key = 1214032,
		callback = function()
			self:Message(1214032, "yellow", barText)
			self:PlaySound(1214032, "info")
		end,
		cancelCallback = function()
			etherealShacklesCount = etherealShacklesCount - 1
		end
	}
end

function mod:RefuelingProtocolTimeline(eventInfo)
	local barText
	if eventInfo.duration == 45 then
		if self:GetStage() == 2 then
			self:SetStage(1)
			self:Message(474345, "cyan", CL.over:format(self:SpellName(474345)))
			self:PlaySound(474345, "info")
		end
		barText = CL.count:format(self:SpellName(474345), refuelingProtocolCount)
		self:CDBar(474345, eventInfo.duration, barText, nil, eventInfo.id)
	elseif eventInfo.duration == 48 then
		-- we re-purpose this Refueling Protocol bar with a bogus duration as the 23s castbar
		self:SetStage(2)
		self:Message(474345, "green", CL.count:format(self:SpellName(474345), refuelingProtocolCount))
		refuelingProtocolCount = refuelingProtocolCount + 1
		barText = CL.cast:format(self:SpellName(474345))
		self:CastBar(474345, 23)
		self:PlaySound(474345, "long")
	end
	return {
		msg = barText,
		key = 474345,
	}
end
