--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ranjit", 1209, 965)
if not mod then return end
mod:RegisterEnableMob(75964)
mod:SetEncounterID(1698)
mod:SetRespawnTime(15)
if mod:Retail() then
	mod:SetPrivateAuraSounds({
		{153757, sound = "alert"}, -- Fan of Blades
		{1252733, sound = "none"}, -- Gale Surge
	})
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		156793, -- Four Winds
		153315, -- Windwall
		165731, -- Piercing Rush
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FourWinds", 156793)
	self:Log("SPELL_CAST_START", "Windwall", 153315)
	self:Log("SPELL_CAST_SUCCESS", "PiercingRush", 165731)
end

function mod:OnEngage()
	self:Bar(156793, 36) -- Four Winds
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local galeSurgeCount = 1
local fanOfBladesCount = 1
local windChakramCount = 1
local chakramVortexCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			1252690, -- Gale Surge
			153757, -- Fan of Blades
			1258152, -- Wind Chakram
			156793, -- Chakram Vortex
			--{153757, "PRIVATE"}, -- Fan of Blades
			{1252733, "PRIVATE"}, -- Gale Surge
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		galeSurgeCount = 1
		fanOfBladesCount = 1
		windChakramCount = 1
		chakramVortexCount = 1
		activeBars = {}
		if self:ShouldShowBars() then
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		end
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 5 then -- Gale Surge
		barInfo = self:GaleSurgeTimeline(eventInfo)
	elseif duration == 12 or duration == 20 then -- Fan of Blades
		barInfo = self:FanOfBladesTimeline(eventInfo)
	elseif duration == 10 or duration == 18 then -- Wind Chakram
		barInfo = self:WindChakramTimeline(eventInfo)
	elseif duration == 35 then -- Chakram Vortex
		barInfo = self:ChakramVortexTimeline(eventInfo)
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

function mod:GaleSurgeTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1252690), galeSurgeCount)
	self:CDBar(1252690, eventInfo.duration, barText, nil, eventInfo.id)
	galeSurgeCount = galeSurgeCount + 1
	return {
		msg = barText,
		key = 1252690,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1252690, 1)
			self:Message(1252690, "red", barText)
			self:PlaySound(1252690, "alarm")
		end
	}
end

function mod:FanOfBladesTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(153757), fanOfBladesCount)
	self:CDBar(153757, eventInfo.duration, barText, nil, eventInfo.id)
	fanOfBladesCount = fanOfBladesCount + 1
	return {
		msg = barText,
		key = 153757,
		callback = function()
			self:Message(153757, "yellow", barText)
			self:PlaySound(153757, "alert")
		end
	}
end

function mod:WindChakramTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1258152), windChakramCount)
	self:CDBar(1258152, eventInfo.duration, barText, nil, eventInfo.id)
	windChakramCount = windChakramCount + 1
	return {
		msg = barText,
		key = 1258152,
		callback = function()
			self:Message(1258152, "red", barText)
			self:PlaySound(1258152, "alarm")
		end
	}
end

function mod:ChakramVortexTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(156793), chakramVortexCount)
	self:CDBar(156793, eventInfo.duration, barText, nil, eventInfo.id)
	chakramVortexCount = chakramVortexCount + 1
	return {
		msg = barText,
		key = 156793,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(156793, "orange", barText)
			self:PlaySound(156793, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FourWinds(args)
	self:Message(args.spellId, "orange")
	self:Bar(args.spellId, 36)
	self:PlaySound(args.spellId, "long")
end

function mod:Windwall(args)
	self:Message(args.spellId, "red")
end

function mod:PiercingRush(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end
