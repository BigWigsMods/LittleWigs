--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rak'tul, Vessel of Souls", 2874, 2812)
if not mod then return end
mod:SetEncounterID(3214)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1251023, sound = "alarm"}, -- Spiritbreaker
	{1252675, sound = "alarm"}, -- Crush Souls
	{1252777, sound = "alert"}, -- Soulbind
	{1252816, sound = "underyou"}, -- Chill of Death
	{1253779, sound = "underyou"}, -- Spectral Decay
	{1253844, sound = "info"}, -- Withering Soul
	{1254043, sound = "alarm"}, -- Eternal Suffering
	{1254175, sound = "alarm"}, -- Cries of the Fallen
	{1255629, sound = "info"}, -- Spectral Residue
	{1266188, sound = "alarm"}, -- Shadow Realm
})

--------------------------------------------------------------------------------
-- Locals
--

local spiritbreakerCount = 1
local crushSoulsCount = 1
local soulrendingRoarCount = 1
local count26_4 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1251023, -- Spiritbreaker
		1252676, -- Crush Souls
		1253788, -- Soulrending Roar
		--{1251023, "PRIVATE"}, -- Spiritbreaker
		{1252675, "PRIVATE"}, -- Crush Souls
		{1252777, "PRIVATE"}, -- Soulbind
		{1252816, "PRIVATE"}, -- Chill of Death
		{1253779, "PRIVATE"}, -- Spectral Decay
		{1253844, "PRIVATE"}, -- Withering Soul
		{1254043, "PRIVATE"}, -- Eternal Suffering
		{1254175, "PRIVATE"}, -- Cries of the Fallen
		{1255629, "PRIVATE"}, -- Spectral Residue
		{1266188, "PRIVATE"}, -- Shadow Realm
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	spiritbreakerCount = 1
	crushSoulsCount = 1
	soulrendingRoarCount = 1
	count26_4 = 1
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
	local duration = math.floor(eventInfo.duration * 10.0 + 0.5) / 10.0
	local barInfo
	if duration == 4 or (duration == 26.4 and (count26_4 % 3 == 1 or count26_4 % 3 == 0)) then -- Spiritbreaker
		barInfo = self:SpiritbreakerTimeline(eventInfo)
	elseif duration == 17.2 or (duration == 26.4 and count26_4 % 3 == 2) then -- Crush Souls
		barInfo = self:CrushSoulsTimeline(eventInfo)
	elseif duration == 70 then -- Soulrending Roar
		barInfo = self:SoulrendingRoarTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 26.4 then
		count26_4 = count26_4 + 1
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

function mod:SpiritbreakerTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1251023), spiritbreakerCount)
	self:CDBar(1251023, eventInfo.duration, barText, nil, eventInfo.id)
	spiritbreakerCount = spiritbreakerCount + 1
	return {
		msg = barText,
		key = 1251023,
		callback = function()
			self:Message(1251023, "purple", barText)
			self:PlaySound(1251023, "alert")
		end
	}
end

function mod:CrushSoulsTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1252676), crushSoulsCount)
	self:CDBar(1252676, eventInfo.duration, barText, nil, eventInfo.id)
	crushSoulsCount = crushSoulsCount + 1
	return {
		msg = barText,
		key = 1252676,
		callback = function()
			self:Message(1252676, "orange", barText)
			self:PlaySound(1252676, "alarm")
		end
	}
end

function mod:SoulrendingRoarTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253788), soulrendingRoarCount)
	self:CDBar(1253788, eventInfo.duration, barText, nil, eventInfo.id)
	soulrendingRoarCount = soulrendingRoarCount + 1
	return {
		msg = barText,
		key = 1253788,
		cancelCallback = function()
			self:Message(1253788, "yellow", barText)
			self:PlaySound(1253788, "long")
		end
	}
end
