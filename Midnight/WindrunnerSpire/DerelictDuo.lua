--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Derelict Duo", 2805, 2656)
if not mod then return end
mod:SetEncounterID(3057)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{472777, sound = "underyou"}, -- Gunk Splatter
	{472793, sound = "warning"}, -- Heaving Yank
	{472888, sound = "none"}, -- Bone Hack
	{474129, sound = "none"}, -- Splattering Spew
	{1253834, sound = "info"}, -- Curse of Darkness
	{1215803, sound = "alarm"}, -- Curse of Darkness
	{1219491, sound = "long"}, -- Debilitating Shriek
	{1282272, sound = "alert"}, -- Splattered
})

--------------------------------------------------------------------------------
-- Locals
--

local splatteringSpewCount = 1
local boneHackCount = 1
local curseofDarknessCount = 1
local debilitatingShriekCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		472745, -- Splattering Spew
		{472888, "TANK_HEALER"}, -- Bone Hack
		474105, -- Curse of Darkness
		472736, -- Debilitating Shriek
		{472777, "PRIVATE"}, -- Gunk Splatter
		{472793, "PRIVATE"}, -- Heaving Yank
		--{472888, "PRIVATE"}, -- Bone Hack
		{474129, "PRIVATE"}, -- Splattering Spew
		{1215803, "PRIVATE"}, -- Curse of Darkness
		{1219491, "PRIVATE"}, -- Debilitating Shriek
		{1253834, "PRIVATE"}, -- Curse of Darkness
		{1282272, "PRIVATE"}, -- Splattered
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	splatteringSpewCount = 1
	boneHackCount = 1
	curseofDarknessCount = 1
	debilitatingShriekCount = 1
	activeBars = {}
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
	local duration = self:RoundNumber(eventInfo.duration, 2)
	local barInfo
	if duration == 8 or duration == 27.33 then -- Splattering Spew
		barInfo = self:SplatteringSpewTimeline(eventInfo)
	elseif duration == 17.33 then -- Bone Hack
		barInfo = self:BoneHackTimeline(eventInfo)
	elseif duration == 22.67 then -- Curse of Darkness
		barInfo = self:CurseofDarknessTimeline(eventInfo)
	elseif duration == 48 then -- Debilitating Shriek
		barInfo = self:DebilitatingShriekTimeline(eventInfo)
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

function mod:SplatteringSpewTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(472745), splatteringSpewCount)
	self:CDBar(472745, eventInfo.duration, barText, nil, eventInfo.id)
	splatteringSpewCount = splatteringSpewCount + 1
	return {
		msg = barText,
		key = 472745,
		callback = function()
			self:TargetMessageFromBlizzMessage(1, 472745, "blue")
			self:Message(472745, "orange", barText)
			self:PlaySound(472745, "alarm")
		end
	}
end

function mod:BoneHackTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(472888), boneHackCount)
	self:CDBar(472888, eventInfo.duration, barText, nil, eventInfo.id)
	boneHackCount = boneHackCount + 1
	return {
		msg = barText,
		key = 472888,
		callback = function()
			self:Message(472888, "purple", barText)
			self:PlaySound(472888, "alarm")
		end
	}
end

function mod:CurseofDarknessTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(474105), curseofDarknessCount)
	self:CDBar(474105, eventInfo.duration, barText, nil, eventInfo.id)
	curseofDarknessCount = curseofDarknessCount + 1
	return {
		msg = barText,
		key = 474105,
		callback = function()
			self:Message(474105, "red", barText)
			self:PlaySound(474105, "alert")
		end
	}
end

function mod:DebilitatingShriekTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(472736), debilitatingShriekCount)
	self:CDBar(472736, eventInfo.duration, barText, nil, eventInfo.id)
	debilitatingShriekCount = debilitatingShriekCount + 1
	return {
		msg = barText,
		key = 472736,
		cancelCallback = function()
			self:TargetMessageFromBlizzMessage(1, 472793, "blue") -- Heaving Yank
			self:Message(472736, "yellow", barText)
			self:PlaySound(472736, "long")
		end
	}
end
