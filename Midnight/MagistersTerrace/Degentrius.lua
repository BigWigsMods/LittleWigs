--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Degentrius", 2811, 2662)
if not mod then return end
mod:SetEncounterID(3074)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1215157, sound = "alarm"}, -- Unstable Void Essence
	{1215161, sound = "alert"}, -- Void Destruction
	{1215897, sound = "warning"}, -- Devouring Entropy
	{1269631, sound = "alert"}, -- Entropy Orb
})

--------------------------------------------------------------------------------
-- Locals
--

local hulkingFragmentCount = 1
local devouringEntropyCount = 1
local unstableVoidEssenceCount = 1
local count22 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1280113, -- Hulking Fragment
		1215897, -- Devouring Entropy
		1215087, -- Unstable Void Essence
		{1215157, "PRIVATE"}, -- Unstable Void Essence
		{1215161, "PRIVATE"}, -- Void Destruction
		--{1215897, "PRIVATE"}, -- Devouring Entropy
		{1269631, "PRIVATE"}, -- Entropy Orb
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	hulkingFragmentCount = 1
	devouringEntropyCount = 1
	unstableVoidEssenceCount = 1
	count22 = 1
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
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if self:Mythic() then
		if duration == 3 or (duration == 22 and count22 % 3 == 1) then -- Hulking Fragment
			barInfo = self:HulkingFragmentTimeline(eventInfo)
		elseif duration == 9 or (duration == 22 and count22 % 3 == 2) then -- Devouring Entropy
			barInfo = self:DevouringEntropyTimeline(eventInfo)
		elseif duration == 15 or (duration == 22 and count22 % 3 == 0) then -- Unstable Void Essence
			barInfo = self:UnstableVoidEssenceTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
		end
		if duration == 22 then
			count22 = count22 + 1
		end
	else -- Normal
		if duration == 7 or duration == 15 then -- Hulking Fragment
			barInfo = self:HulkingFragmentTimeline(eventInfo)
		elseif duration == 13 or duration == 20 then -- Devouring Entropy
			barInfo = self:DevouringEntropyTimeline(eventInfo)
		elseif duration == 16 or duration == 31 then -- Unstable Void Essence
			barInfo = self:UnstableVoidEssenceTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
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

function mod:HulkingFragmentTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1280113), hulkingFragmentCount)
	self:CDBar(1280113, eventInfo.duration, barText, nil, eventInfo.id)
	hulkingFragmentCount = hulkingFragmentCount + 1
	return {
		msg = barText,
		key = 1280113,
		callback = function()
			self:Message(1280113, "purple", barText)
			self:PlaySound(1280113, "alarm")
		end
	}
end

function mod:DevouringEntropyTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1215897), devouringEntropyCount)
	self:CDBar(1215897, eventInfo.duration, barText, nil, eventInfo.id)
	devouringEntropyCount = devouringEntropyCount + 1
	return {
		msg = barText,
		key = 1215897,
		callback = function()
			self:Message(1215897, "yellow", barText)
			self:PlaySound(1215897, "alert")
		end
	}
end

function mod:UnstableVoidEssenceTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1215087), unstableVoidEssenceCount)
	self:CDBar(1215087, eventInfo.duration, barText, nil, eventInfo.id)
	unstableVoidEssenceCount = unstableVoidEssenceCount + 1
	return {
		msg = barText,
		key = 1215087,
		--callback = function() has Blizzard alert
			--self:Message(1215087, "red", barText)
			--self:PlaySound(1215087, "info")
		--end
	}
end
