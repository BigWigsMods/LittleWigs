--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gemellus", 2811, 2660)
if not mod then return end
mod:SetEncounterID(3073)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1224104, sound = "underyou"}, -- Void Secretions
	{1224401, sound = "alarm"}, -- Cosmic Radiation
	{1284958, sound = "alert"}, -- Cosmic Sting
	{1224299, sound = "warning"}, -- Astral Grasp
	{1253709, sound = "info"}, -- Neural Link
})

--------------------------------------------------------------------------------
-- Locals
--

local triplicateCount = 1
local cosmicStingCount = 1
local neuralLinkCount = 1
local astralGraspCount = 1
local count5 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1223847, -- Triplicate
		1284954, -- Cosmic Sting
		1253709, -- Neural Link
		1224299, -- Astral Grasp
		{1224104, "PRIVATE"}, -- Void Secretions
		{1224401, "PRIVATE"}, -- Cosmic Radiation
		--{1284958, "PRIVATE"}, -- Cosmic Sting
		--{1224299, "PRIVATE"}, -- Astral Grasp
		--{1253709, "PRIVATE"}, -- Neural Link
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	triplicateCount = 1
	cosmicStingCount = 1
	neuralLinkCount = 1
	astralGraspCount = 1
	count5 = 1
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
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration > 60 then return end -- always canceled
	if duration == 5 and count5 == 1 then -- Triplicate
		barInfo = self:TriplicateTimeline(eventInfo)
	elseif duration == 8 or (duration == 5 and count5 >= 2) then -- Cosmic Sting
		barInfo = self:CosmicStingTimeline(eventInfo)
	elseif duration == 16 then -- Neural Link
		barInfo = self:NeuralLinkTimeline(eventInfo)
	elseif duration == 29 then -- Astral Grasp
		barInfo = self:AstralGraspTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 5 then
		count5 = count5 + 1
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

function mod:TriplicateTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1223847), triplicateCount)
	self:CDBar(1223847, eventInfo.duration, barText, nil, eventInfo.id)
	triplicateCount = triplicateCount + 1
	return {
		msg = barText,
		key = 1223847,
		callback = function()
			self:Message(1223847, "cyan", barText)
			self:PlaySound(1223847, "info")
		end
	}
end

function mod:CosmicStingTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1284954), cosmicStingCount)
	self:CDBar(1284954, eventInfo.duration, barText, nil, eventInfo.id)
	cosmicStingCount = cosmicStingCount + 1
	return {
		msg = barText,
		key = 1284954,
		callback = function()
			self:Message(1284954, "yellow", barText)
			self:PlaySound(1284954, "alert")
		end
	}
end

function mod:NeuralLinkTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253709), neuralLinkCount)
	self:CDBar(1253709, eventInfo.duration, barText, nil, eventInfo.id)
	neuralLinkCount = neuralLinkCount + 1
	return {
		msg = barText,
		key = 1253709,
		callback = function()
			self:Message(1253709, "red", barText)
			self:PlaySound(1253709, "info")
		end
	}
end

function mod:AstralGraspTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1224299), astralGraspCount)
	self:CDBar(1224299, eventInfo.duration, barText, nil, eventInfo.id)
	astralGraspCount = astralGraspCount + 1
	return {
		msg = barText,
		key = 1224299,
		callback = function()
			self:Message(1224299, "orange", barText)
			self:PlaySound(1224299, "alert")
		end
	}
end
