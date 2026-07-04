--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lightblossom Trinity", 2859, 2769)
if not mod then return end
mod:SetEncounterID(3199)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1234802, sound = "underyou"}, -- Fertile Loam
	{1235574, sound = "info"}, -- Lightblossom Beam
	{1235828, sound = "underyou"}, -- Light-Scorched Earth
	{1235865, sound = "alert"}, -- Thornblade
})

--------------------------------------------------------------------------------
-- Locals
--

local bedrockSlamCount = 1
local thornbladeCount = 1
local lightsowerDashCount = 1
local lightblossomBeamCount = 1
local count40something = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1234753] = {1234753}, -- Bedrock Slam
	[1235640] = {1235640}, -- Thornblade
	[1234850] = {1234850}, -- Lightsower Dash
	[1235564] = {1235564}, -- Lightblossom Beam
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1234753, -- Bedrock Slam
		1235640, -- Thornblade
		1234850, -- Lightsower Dash
		1235564, -- Lightblossom Beam
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	bedrockSlamCount = 1
	thornbladeCount = 1
	lightsowerDashCount = 1
	lightblossomBeamCount = 1
	count40something = 1
	activeBars = {}
	backupBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

function mod:OnWin()
	activeBars = {}
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
	if BigWigsLoader.isNext then
		if duration == 5 or (count40something % 3 == 1 and duration > 40 and duration <= 45) then -- Bedrock Slam
			barInfo = self:BedrockSlamTimeline(eventInfo)
		elseif duration == 8 then -- Thornblade
			barInfo = self:ThornbladeTimeline(eventInfo)
		elseif duration == 20 or (count40something % 3 == 2 and duration > 40 and duration <= 45) then -- Lightsower Dash
			barInfo = self:LightsowerDashTimeline(eventInfo)
		elseif duration == 35 or (count40something % 3 == 0 and duration > 40 and duration <= 45) then -- Lightblossom Beam
			barInfo = self:LightblossomBeamTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
		end
	else -- XXX remove in 12.1
		if duration == 5 or (count40something % 3 == 1 and duration > 40 and duration <= 45) then -- Bedrock Slam
			barInfo = self:BedrockSlamTimeline(eventInfo)
		elseif duration == 4 or duration == 10 then -- Thornblade
			barInfo = self:ThornbladeTimeline(eventInfo)
		elseif duration == 20 or (count40something % 3 == 2 and duration > 40 and duration <= 45) then -- Lightsower Dash
			barInfo = self:LightsowerDashTimeline(eventInfo)
		elseif duration == 35 or (count40something % 3 == 0 and duration > 40 and duration <= 45) then -- Lightblossom Beam
			barInfo = self:LightblossomBeamTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
		end
	end
	if duration > 40 and duration <= 45 then
		count40something = count40something + 1
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

function mod:BedrockSlamTimeline(eventInfo) -- Bedrock Slam
	local barText = CL.count:format(self:GetRename(1234753), bedrockSlamCount)
	self:CDBar(1234753, eventInfo.duration, barText, nil, eventInfo.id)
	bedrockSlamCount = bedrockSlamCount + 1
	return {
		msg = barText,
		key = 1234753,
		callback = function()
			self:Message(1234753, "purple", barText)
			self:PlaySound(1234753, "alert")
		end
	}
end

do
	local prev = 0
	function mod:ThornbladeTimeline(eventInfo) -- Thornblade
		local barText = CL.count:format(self:GetRename(1235640), thornbladeCount)
		self:CDBar(1235640, eventInfo.duration, barText, nil, eventInfo.id)
		thornbladeCount = thornbladeCount + 1
		return {
			msg = barText,
			key = 1235640,
			callback = function()
				-- first Thornblade double alerts (and all other Thornblade casts have no timer)
				if GetTime() - prev > 2 then
					prev = GetTime()
					self:Message(1235640, "yellow", barText)
					self:PlaySound(1235640, "alert")
				end
			end
		}
	end
end

function mod:LightsowerDashTimeline(eventInfo) -- Lightsower Dash
	local barText = CL.count:format(self:GetRename(1234850), lightsowerDashCount)
	self:CDBar(1234850, eventInfo.duration, barText, nil, eventInfo.id)
	lightsowerDashCount = lightsowerDashCount + 1
	return {
		msg = barText,
		key = 1234850,
		callback = function()
			self:Message(1234850, "red", barText)
			self:PlaySound(1234850, "alarm")
		end
	}
end

function mod:LightblossomBeamTimeline(eventInfo) -- Lightblossom Beam
	local barText = CL.count:format(self:GetRename(1235564), lightblossomBeamCount)
	self:CDBar(1235564, eventInfo.duration, barText, nil, eventInfo.id)
	lightblossomBeamCount = lightblossomBeamCount + 1
	return {
		msg = barText,
		key = 1235564,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1235564, "cyan", barText)
			self:PlaySound(1235564, "long")
		end
	}
end
