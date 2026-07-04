--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ziekket", 2859, 2772)
if not mod then return end
mod:SetEncounterID(3202)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1246751, sound = "warning"}, -- Concentrated Lightbeam
	{1246753, sound = "underyou"}, -- Lightsap
	{1247746, sound = "alarm"}, -- Thornspike
})

--------------------------------------------------------------------------------
-- Locals
--

local awakenTheLightbloomCount = 1
local lightbloomsEssenceCount = 1
local thornspikeCount = 1
local concentratedLightbeamCount = 1
local sharedCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1246372] = {1246372}, -- Awaken the Lightbloom
	[1246858] = {1246858}, -- Lightbloom's Essence
	[1247685] = {1247685}, -- Thornspike
	[1246607] = {1246607, CL.you:format(mod:SpellName(1246607)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1246607, CL.you:format(mod:SpellName(1246607))}}, -- Concentrated Lightbeam
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1246372, -- Awaken the Lightbloom
		1246858, -- Lightbloom's Essence
		1247685, -- Thornspike
		1246607, -- Concentrated Lightbeam
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	awakenTheLightbloomCount = 1
	lightbloomsEssenceCount = 1
	thornspikeCount = 1
	concentratedLightbeamCount = 1
	sharedCount = 1
	activeBars = {}
	backupBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
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
	if self:Mythic() then
		if duration == 4 or (duration == 50 and sharedCount % 4 == 1) then
			barInfo = self:AwakenTheLightbloomTimeline(eventInfo)
		elseif duration == 14 or (duration == 50 and sharedCount % 4 == 2) then
			barInfo = self:LightbloomsEssenceTimeline(eventInfo)
		elseif duration == 26 or (duration == 50 and sharedCount % 4 == 3) then
			barInfo = self:ThornspikeTimeline(eventInfo)
		elseif duration == 40 or (duration == 50 and sharedCount % 4 == 0) then
			barInfo = self:ConcentratedLightbeamTimeline(eventInfo)
		end
	else -- Normal, Heroic
		if duration == 4 or (duration == 45 and sharedCount % 3 == 1) then
			barInfo = self:AwakenTheLightbloomTimeline(eventInfo)
		elseif duration == 18 or (duration == 45 and sharedCount % 3 == 2) then
			barInfo = self:ThornspikeTimeline(eventInfo)
		elseif duration == 32 or (duration == 45 and sharedCount % 3 == 0) then
			barInfo = self:ConcentratedLightbeamTimeline(eventInfo)
		end
	end
	if not barInfo and not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 45 or duration == 50 then
		sharedCount = sharedCount + 1
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

function mod:AwakenTheLightbloomTimeline(eventInfo) -- Awaken the Lightbloom
	local barText = CL.count:format(self:GetRename(1246372), awakenTheLightbloomCount)
	self:CDBar(1246372, eventInfo.duration, barText, nil, eventInfo.id)
	awakenTheLightbloomCount = awakenTheLightbloomCount + 1
	return {
		msg = barText,
		key = 1246372,
		callback = function()
			self:Message(1246372, "cyan", barText)
			self:PlaySound(1246372, "long")
		end
	}
end

function mod:LightbloomsEssenceTimeline(eventInfo) -- Lightbloom's Essence
	local barText = CL.count:format(self:GetRename(1246858), lightbloomsEssenceCount)
	self:CDBar(1246858, eventInfo.duration, barText, nil, eventInfo.id)
	lightbloomsEssenceCount = lightbloomsEssenceCount + 1
	return {
		msg = barText,
		key = 1246858,
		callback = function()
			self:Message(1246858, "yellow", barText)
			self:PlaySound(1246858, "info")
		end
	}
end

function mod:ThornspikeTimeline(eventInfo) -- Thornspike
	local barText = CL.count:format(self:GetRename(1247685), thornspikeCount)
	self:CDBar(1247685, eventInfo.duration, barText, nil, eventInfo.id)
	thornspikeCount = thornspikeCount + 1
	return {
		msg = barText,
		key = 1247685,
		callback = function()
			self:Message(1247685, "purple", barText)
			self:PlaySound(1247685, "alert")
		end
	}
end

function mod:ConcentratedLightbeamTimeline(eventInfo) -- Concentrated Lightbeam
	local barText = CL.count:format(self:GetRename(1246607), concentratedLightbeamCount)
	self:CDBar(1246607, eventInfo.duration, barText, nil, eventInfo.id)
	concentratedLightbeamCount = concentratedLightbeamCount + 1
	return {
		msg = barText,
		key = 1246607,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1246607, 1, false, self:GetRename(1246607, 2))
			self:Message(1246607, "orange", barText)
			self:PlaySound(1246607, "alarm")
		end
	}
end
