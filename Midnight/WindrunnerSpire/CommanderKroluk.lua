--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Kroluk", 2805, 2657)
if not mod then return end
mod:SetEncounterID(3058)
mod:SetRespawnTime(30)
mod:SetStage(1)
mod:SetPrivateAuraSounds({
	{467620, sound = "none"}, -- Rampage
	{468659, sound = "alert"}, -- Throw Axe
	{1283247, sound = "none"}, -- Reckless Leap
	{472054, sound = "none"}, -- Reckless Leap
	{1253030, sound = "warning"}, -- Intimidating Shout
	{470966, sound = "warning"}, -- Bladestorm
	{468924, sound = "underyou"}, -- Bladestorm
})

--------------------------------------------------------------------------------
-- Locals
--

local shieldWallCount = 1
local rampageCount = 1
local bladestormCount = 1
local recklessLeapCount = 1
local intimidatingShoutCount = 1
local activeBars = {}
local activeBarBySpellId = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1250851, -- Shield Wall
		{467620, "TANK_HEALER"}, -- Rampage
		472081, -- Reckless Leap
		1253272, -- Intimidating Shout
		470963, -- Bladestorm
		--{467620, "PRIVATE"}, -- Rampage
		{468659, "PRIVATE"}, -- Throw Axe
		--{1283247, "PRIVATE"}, -- Reckless Leap
		--{472054, "PRIVATE"}, -- Reckless Leap
		--{1253030, "PRIVATE"}, -- Intimidating Shout
		--{470966, "PRIVATE"}, -- Bladestorm
		--{468924, "PRIVATE"}, -- Bladestorm
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	shieldWallCount = 1
	rampageCount = 1
	bladestormCount = 1
	recklessLeapCount = 1
	intimidatingShoutCount = 1
	activeBars = {}
	activeBarBySpellId = {}
	self:SetStage(1)
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
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
			if spellId == 467620 then -- Rampage
				rampageCount = rampageCount - 1
			elseif spellId == 472081 then -- Reckless Leap
				recklessLeapCount = recklessLeapCount - 1
			elseif spellId == 470963 then -- Bladestorm
				bladestormCount = bladestormCount - 1
			elseif spellId == 1253272 then -- Intimidating Shout
				intimidatingShoutCount = intimidatingShoutCount - 1
			end
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	if C_EncounterTimeline.GetEventState(eventInfo.id) == 1 then -- Paused
		return -- ignore paused bars when added, they are always canceled immediately
	end
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration > 120 then return end -- filter placeholder bars
	if duration == 3 or (not self:IsWiping() and duration == 30) then -- Rampage
		if not self:Mythic() then
			self:CancelBarForSpell(467620)
		end
		barInfo = self:RampageTimeline(eventInfo)
	elseif duration == 8 or duration == 0 then -- Bladestorm
		if not self:Mythic() then
			self:CancelBarForSpell(470963)
		end
		barInfo = self:BladestormTimeline(eventInfo)
	elseif duration == 10 or duration == 37 then -- Reckless Leap
		if not self:Mythic() then
			self:CancelBarForSpell(472081)
		end
		barInfo = self:RecklessLeapTimeline(eventInfo)
	elseif duration == 18 or duration == 45 then -- Intimidating Shout
		if not self:Mythic() then
			self:CancelBarForSpell(1253272)
		end
		barInfo = self:IntimidatingShoutTimeline(eventInfo)
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

function mod:RampageTimeline(eventInfo)
	if self:GetStage() == 2 then
		self:SetStage(1)
		self:Message(1250851, "green", CL.over:format(self:SpellName(1250851))) -- Shield Wall
		self:PlaySound(1250851, "info")
	end
	local barText = CL.count:format(self:SpellName(467620), rampageCount)
	self:CDBar(467620, eventInfo.duration, barText, nil, eventInfo.id)
	rampageCount = rampageCount + 1
	return {
		msg = barText,
		key = 467620,
		callback = function()
			self:Message(467620, "purple", barText)
			self:PlaySound(467620, "alert")
		end
	}
end

do
	local prevShieldWall = 0
	function mod:BladestormTimeline(eventInfo)
		if eventInfo.duration == 0.001 and GetTime() - prevShieldWall > 2 then -- 3x in a row on stage change
			prevShieldWall = GetTime()
			bladestormCount = 1
			self:SetStage(2)
			if shieldWallCount == 1 then
				self:Message(1250851, "cyan", CL.percent:format(66, self:SpellName(1250851))) -- Shield Wall
			else
				self:Message(1250851, "cyan", CL.percent:format(33, self:SpellName(1250851))) -- Shield Wall
			end
			shieldWallCount = shieldWallCount + 1
			self:PlaySound(1250851, "long") -- Shield Wall
		elseif eventInfo.duration == 8 then
			local barText = CL.count:format(self:SpellName(470963), bladestormCount)
			self:CDBar(470963, eventInfo.duration, barText, nil, eventInfo.id)
			bladestormCount = bladestormCount + 1
			return {
				msg = barText,
				key = 470963,
			}
		end
	end
end

function mod:RecklessLeapTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(472081), recklessLeapCount)
	self:CDBar(472081, eventInfo.duration, barText, nil, eventInfo.id)
	recklessLeapCount = recklessLeapCount + 1
	return {
		msg = barText,
		key = 472081,
		callback = function()
			self:PersonalMessageFromBlizzMessage(472081, 5) -- cast twice
			self:Message(472081, "orange", barText)
			self:PlaySound(472081, "alarm")
		end
	}
end

function mod:IntimidatingShoutTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253272), intimidatingShoutCount)
	self:CDBar(1253272, eventInfo.duration, barText, nil, eventInfo.id)
	intimidatingShoutCount = intimidatingShoutCount + 1
	return {
		msg = barText,
		key = 1253272,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1253272, "red", barText)
			self:PlaySound(1253272, "warning")
		end
	}
end
