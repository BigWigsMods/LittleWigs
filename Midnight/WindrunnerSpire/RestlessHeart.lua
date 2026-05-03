--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Restless Heart", 2805, 2658)
if not mod then return end
mod:SetEncounterID(3059)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{468442, sound = "warning"}, -- Billowing Wind
	{472662, sound = "alarm"}, -- Tempest Slash
	{474528, sound = "warning"}, -- Bolt Gale
	{1282911, sound = "warning"}, -- Bolt Gale
	{1216042, sound = "alert"}, -- Squall Leap
	{1253979, sound = "warning"}, -- Gust Shot
	{1282955, sound = "underyou"}, -- Storming Soulfont
})

--------------------------------------------------------------------------------
-- Locals
--

local arrowRainCount = 1
local tempestSlashCount = 1
local gustShotCount = 1
local bullseyeWindblastCount = 1
local boltGaleCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		472556, -- Arrow Rain
		472662, -- Tempest Slash
		1253986, -- Gust Shot
		468429, -- Bullseye Windblast
		474528, -- Bolt Gale
		{468442, "PRIVATE"}, -- Billowing Wind
		--{472662, "PRIVATE"}, -- Tempest Slash
		--{474528, "PRIVATE"}, -- Bolt Gale
		{1216042, "PRIVATE"}, -- Squall Leap
		{1253979, "PRIVATE"}, -- Gust Shot
		{1282911, "PRIVATE"}, -- Bolt Gale
		{1282955, "PRIVATE"}, -- Storming Soulfont
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	arrowRainCount = 1
	tempestSlashCount = 1
	gustShotCount = 1
	bullseyeWindblastCount = 1
	boltGaleCount = 1
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
	if duration == 9 or duration == 11 then -- Arrow Rain
		barInfo = self:ArrowRainTimeline(eventInfo)
	elseif duration == 21 then -- Tempest Slash
		barInfo = self:TempestSlashTimeline(eventInfo)
	elseif duration == 23.5 then -- Gust Shot
		barInfo = self:GustShotTimeline(eventInfo)
	elseif duration == 24 or duration == 53 then -- Bullseye Windblast
		barInfo = self:BullseyeWindblastTimeline(eventInfo)
	elseif duration == 39 then -- Bolt Gale
		barInfo = self:BoltGaleTimeline(eventInfo)
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

function mod:ArrowRainTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(472556), arrowRainCount)
	self:CDBar(472556, eventInfo.duration, barText, nil, eventInfo.id)
	arrowRainCount = arrowRainCount + 1
	return {
		msg = barText,
		key = 472556,
		callback = function()
			self:Message(472556, "cyan", barText)
			self:PlaySound(472556, "info")
		end
	}
end

function mod:TempestSlashTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(472662), tempestSlashCount)
	self:CDBar(472662, eventInfo.duration, barText, nil, eventInfo.id)
	tempestSlashCount = tempestSlashCount + 1
	return {
		msg = barText,
		key = 472662,
		callback = function()
			self:Message(472662, "purple", barText)
			self:PlaySound(472662, "alert")
		end
	}
end

function mod:GustShotTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253986), gustShotCount)
	self:CDBar(1253986, eventInfo.duration, barText, nil, eventInfo.id)
	gustShotCount = gustShotCount + 1
	return {
		msg = barText,
		key = 1253986,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1, 1253986)
			self:Message(1253986, "red", barText)
			self:PlaySound(1253986, "alarm")
		end
	}
end

function mod:BullseyeWindblastTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(468429), bullseyeWindblastCount)
	self:CDBar(468429, eventInfo.duration, barText, nil, eventInfo.id)
	bullseyeWindblastCount = bullseyeWindblastCount + 1
	return {
		msg = barText,
		key = 468429,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(468429, "yellow", barText)
			self:PlaySound(468429, "warning")
		end
	}
end

function mod:BoltGaleTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(474528), boltGaleCount)
	self:CDBar(474528, eventInfo.duration, barText, nil, eventInfo.id)
	boltGaleCount = boltGaleCount + 1
	return {
		msg = barText,
		key = 474528,
		callback = function()
			self:Message(474528, "yellow", barText)
			self:PlaySound(474528, "long")
		end
	}
end
