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
	{470966, sound = "warning"}, -- Bladestorm
	{468924, sound = "underyou"}, -- Bladestorm
	{1283247, sound = "none"}, -- Reckless Leap
	{472054, sound = "none"}, -- Reckless Leap
	{1253030, sound = "warning"}, -- Intimidating Shout
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

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1250851, -- Shield Wall
		{1283335, "TANK_HEALER"}, -- Rampage
		1271676, -- Bladestorm
		472053, -- Reckless Leap
		1253272, -- Intimidating Shout
		{467620, "PRIVATE"}, -- Rampage
		{468659, "PRIVATE"}, -- Throw Axe
		{470966, "PRIVATE"}, -- Bladestorm
		{468924, "PRIVATE"}, -- Bladestorm
		{1283247, "PRIVATE"}, -- Reckless Leap
		{472054, "PRIVATE"}, -- Reckless Leap
		{1253030, "PRIVATE"}, -- Intimidating Shout
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

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if C_EncounterTimeline.GetEventState(eventInfo.id) == 1 then -- Paused
		return -- ignore paused bars when added, they are always canceled immediately
	end
	local duration = math.floor(eventInfo.duration + 0.5)
	local barInfo
	if duration > 120 then return end -- filter placeholder bars
	if duration == 3 or (not self:IsWiping() and duration == 30) then -- Rampage
		barInfo = self:RampageTimeline(eventInfo)
	elseif duration == 8 or duration == 0 then -- Bladestorm
		barInfo = self:BladestormTimeline(eventInfo)
	elseif duration == 10 or duration == 37 then -- Reckless Leap
		barInfo = self:RecklessLeapTimeline(eventInfo)
	elseif duration == 18 or duration == 45 then -- Intimidating Shout
		barInfo = self:IntimidatingShoutTimeline(eventInfo)
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

function mod:RampageTimeline(eventInfo)
	self:SetStage(1)
	local barText = CL.count:format(self:SpellName(1283335), rampageCount)
	self:CDBar(1283335, eventInfo.duration, barText, nil, eventInfo.id)
	rampageCount = rampageCount + 1
	return {
		msg = barText,
		key = 1283335,
		callback = function()
			self:Message(1283335, "purple", barText)
			self:PlaySound(1283335, "alert")
		end
	}
end

do
	local prevShieldWall, prevBladestorm = 0, 0
	function mod:BladestormTimeline(eventInfo)
		if eventInfo.duration == 0.001 and GetTime() - prevShieldWall > 2 then -- happeans 3x in a row on stage change
			prevShieldWall = GetTime()
			bladestormCount = 1
			self:SetStage(2)
			if shieldWallCount == 1 then
				self:Message(1250851, "cyan", CL.percent:format(self:SpellName(1250851), 66)) -- Shield Wall
			else
				self:Message(1250851, "cyan", CL.percent:format(self:SpellName(1250851), 33)) -- Shield Wall
			end
			shieldWallCount = shieldWallCount + 1
			self:PlaySound(1250851, "long") -- Shield Wall
		elseif eventInfo.duration == 8 and GetTime() - prevBladestorm > 2 then -- happens 3x in a row on stage change
			prevBladestorm = GetTime()
			local barText = CL.count:format(self:SpellName(1271676), bladestormCount)
			self:CDBar(1271676, eventInfo.duration, barText, nil, eventInfo.id)
			bladestormCount = bladestormCount + 1
			return {
				msg = barText,
				key = 1271676,
			}
		end
	end
end

function mod:RecklessLeapTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(472053), recklessLeapCount)
	self:CDBar(472053, eventInfo.duration, barText, nil, eventInfo.id)
	recklessLeapCount = recklessLeapCount + 1
	return {
		msg = barText,
		key = 472053,
		callback = function()
			self:Message(472053, "orange", barText)
			self:PlaySound(472053, "alarm")
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
			self:Message(1253272, "red", barText)
			self:PlaySound(1253272, "warning")
		end
	}
end
