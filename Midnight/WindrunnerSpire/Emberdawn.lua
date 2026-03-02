--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Emberdawn", 2805, 2655)
if not mod then return end
mod:SetEncounterID(3056)
mod:SetRespawnTime(30)
mod:SetStage(1)
mod:SetPrivateAuraSounds({
	{466091, sound = "alarm"}, -- Searing Beak
	{466559, sound = "warning"}, -- Flaming Updraft
	{470212, sound = "warning"}, -- Flaming Twisters
	{472118, sound = "underyou"}, -- Ignited Embers
})

--------------------------------------------------------------------------------
-- Locals
--

local flamingUpdraftCount = 1
local searingBeakCount = 1
local burningGaleCount = 1
local flamingUpdraftRemaining = 2
local searingBeakRemaining = 2
local activeBars = {}
local activeBarBySpellId = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		466556, -- Flaming Updraft
		{466064, "TANK_HEALER"}, -- Searing Beak
		{465904, "CASTBAR"}, -- Burning Gale
		{466091, "PRIVATE"}, -- Searing Beak
		{466559, "PRIVATE"}, -- Flaming Updraft
		{470212, "PRIVATE"}, -- Flaming Twisters
		{472118, "PRIVATE"}, -- Ignited Embers
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	flamingUpdraftCount = 1
	searingBeakCount = 1
	burningGaleCount = 1
	flamingUpdraftRemaining = 1
	searingBeakRemaining = 1
	activeBars = {}
	activeBarBySpellId = {}
	self:SetStage(1)
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

function mod:OnWin()
	activeBars = {}
	activeBarBySpellId = {}
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:CancelBarForSpell(spellId)
	local priorEventID = activeBarBySpellId[spellId]
	if priorEventID then
		local barInfo = activeBars[priorEventID]
		if barInfo and barInfo.createdAt and (GetTime() - barInfo.createdAt) < 3 then
			self:StopBar(barInfo.msg)
			activeBars[priorEventID] = nil
			activeBarBySpellId[spellId] = nil
			if spellId == 466556 then -- Flaming Updraft
				flamingUpdraftCount = flamingUpdraftCount - 1
				flamingUpdraftRemaining = flamingUpdraftRemaining + 1
			elseif spellId == 466064 then -- Searing Beak
				searingBeakCount = searingBeakCount - 1
				searingBeakRemaining = searingBeakRemaining + 1
			elseif spellId == 465904 then -- Burning Gale
				burningGaleCount = burningGaleCount - 1
			end
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if C_EncounterTimeline.GetEventState(eventInfo.id) == 1 then -- Paused
		return -- ignore paused bars when added, they are always canceled some time later
	end
	local duration = math.floor(eventInfo.duration * 10.0 + 0.5) / 10.0
	local barInfo
	if duration == 6 or duration == 15.5 then -- Flaming Updraft
		self:CancelBarForSpell(466556)
		barInfo = self:FlamingUpdraftTimeline(eventInfo)
	elseif duration == 10 or duration == 13 then -- Searing Beak
		self:CancelBarForSpell(466064)
		barInfo = self:SearingBeakTimeline(eventInfo)
	elseif duration == 15 or (not self:IsWiping() and duration == 30) then -- Burning Gale
		self:CancelBarForSpell(465904)
		barInfo = self:BurningGaleTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if barInfo then
		barInfo.createdAt = GetTime()
		activeBars[eventInfo.id] = barInfo
		activeBarBySpellId[barInfo.key] = eventInfo.id
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
			if activeBarBySpellId[barInfo.key] == eventID then
				activeBarBySpellId[barInfo.key] = nil
			end
		elseif state == 3 then -- Canceled
			self:StopBar(barInfo.msg)
			if not self:IsWiping() and barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[eventID] = nil
			if activeBarBySpellId[barInfo.key] == eventID then
				activeBarBySpellId[barInfo.key] = nil
			end
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_REMOVED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		self:StopBar(barInfo.msg)
		activeBars[eventID] = nil
		if activeBarBySpellId[barInfo.key] == eventID then
			activeBarBySpellId[barInfo.key] = nil
		end
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:FlamingUpdraftTimeline(eventInfo)
	if flamingUpdraftRemaining == 0 then return end
	flamingUpdraftRemaining = flamingUpdraftRemaining - 1
	local barText = CL.count:format(self:SpellName(466556), flamingUpdraftCount)
	self:CDBar(466556, eventInfo.duration, barText, nil, eventInfo.id)
	flamingUpdraftCount = flamingUpdraftCount + 1
	return {
		msg = barText,
		key = 466556,
		callback = function()
			self:Message(466556, "orange", barText)
			self:PlaySound(466556, "alarm")
		end
	}
end

function mod:SearingBeakTimeline(eventInfo)
	if searingBeakRemaining == 0 then return end
	searingBeakRemaining = searingBeakRemaining - 1
	local barText = CL.count:format(self:SpellName(466064), searingBeakCount)
	self:CDBar(466064, eventInfo.duration, barText, nil, eventInfo.id)
	searingBeakCount = searingBeakCount + 1
	return {
		msg = barText,
		key = 466064,
		callback = function()
			self:Message(466064, "purple", barText)
			self:PlaySound(466064, "alert")
		end
	}
end

function mod:BurningGaleTimeline(eventInfo)
	self:StopCastBar(465904)
	self:SetStage(1)
	local barText = CL.count:format(self:SpellName(465904), burningGaleCount)
	self:CDBar(465904, eventInfo.duration, barText, nil, eventInfo.id)
	burningGaleCount = burningGaleCount + 1
	return {
		msg = barText,
		key = 465904,
		cancelCallback = function()
			flamingUpdraftRemaining = 2
			searingBeakRemaining = 2
			self:SetStage(2)
			self:Message(465904, "yellow", barText)
			self:CastBar(465904, 20.5) -- 3s cast + 18s channel - some delay
			self:PlaySound(465904, "long")
		end
	}
end
