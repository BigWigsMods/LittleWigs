--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ikuzz the Light Hunter", 2859, 2770)
if not mod then return end
mod:SetEncounterID(3200)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1237091, sound = "warning"}, -- Bloodthirsty Gaze
	{1237267, sound = "alarm"}, -- Incise
	{1272290, sound = "warning"}, -- Crunched
})

--------------------------------------------------------------------------------
-- Locals
--

local verdantStompCount = 1
local thorncallerRoarCount = 1
local bloodthirstyGazeCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1236746] = {1236746}, -- Verdant Stomp
	[1236709] = {1236709}, -- Thorncaller Roar
	[1237090] = {1237090, CL.you:format(mod:SpellName(1237090)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1237090, CL.you:format(mod:SpellName(1237090))}}, -- Bloodthirsty Gaze
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1236746, -- Verdant Stomp
		1236709, -- Thorncaller Roar
		1237090, -- Bloodthirsty Gaze
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	verdantStompCount = 1
	thorncallerRoarCount = 1
	bloodthirstyGazeCount = 1
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
	if duration >= 60 then return end
	if BigWigsLoader.isNext then
		if duration == 6 or duration == 29 then -- Verdant Stomp
			barInfo = self:VerdantStompTimeline(eventInfo)
		elseif duration == 22 then -- Thorncaller Roar
			barInfo = self:ThorncallerRoarTimeline(eventInfo)
		elseif duration == 50 then -- Bloodthirsty Gaze
			barInfo = self:BloodthirstyGazeTimeline(eventInfo)
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
		if duration == 6 then -- Verdant Stomp
			barInfo = self:VerdantStompTimeline(eventInfo)
		elseif duration == 20 then -- Thorncaller Roar
			barInfo = self:ThorncallerRoarTimeline(eventInfo)
		elseif duration == 40 then -- Bloodthirsty Gaze
			barInfo = self:BloodthirstyGazeTimeline(eventInfo)
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
			if not self:IsWiping() and barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
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

function mod:VerdantStompTimeline(eventInfo) -- Verdant Stomp
	local barText = CL.count:format(self:GetRename(1236746), verdantStompCount)
	self:CDBar(1236746, eventInfo.duration, barText, nil, eventInfo.id)
	verdantStompCount = verdantStompCount + 1
	return {
		msg = barText,
		key = 1236746,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1236746, "orange", barText)
			self:PlaySound(1236746, "alert")
		end,
		cancelCallback = function()
			verdantStompCount = verdantStompCount - 1
		end
	}
end

function mod:ThorncallerRoarTimeline(eventInfo) -- Thorncaller Roar
	local barText = CL.count:format(self:GetRename(1236709), thorncallerRoarCount)
	self:CDBar(1236709, eventInfo.duration, barText, nil, eventInfo.id)
	thorncallerRoarCount = thorncallerRoarCount + 1
	return {
		msg = barText,
		key = 1236709,
		callback = function()
			self:Message(1236709, "yellow", barText)
			self:PlaySound(1236709, "long")
		end
	}
end

do
	local function IfOnMe(self)
		self:PlaySound(1237090, "warning", nil, self:UnitName("player"))
	end
	function mod:BloodthirstyGazeTimeline(eventInfo) -- Bloodthirsty Gaze
		local barText = CL.count:format(self:GetRename(1237090), bloodthirstyGazeCount)
		self:CDBar(1237090, eventInfo.duration, barText, nil, eventInfo.id)
		bloodthirstyGazeCount = bloodthirstyGazeCount + 1
		return {
			msg = barText,
			key = 1237090,
			callback = function()
				self:PersonalMessageFromBlizzMessage(1237090, 1, false, self:GetRename(1237090, 2), nil, nil, IfOnMe)
				self:Message(1237090, "red", barText)
			end
		}
	end
end
