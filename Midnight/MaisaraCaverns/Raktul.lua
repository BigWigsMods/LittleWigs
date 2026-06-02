--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rak'tul, Vessel of Souls", 2874, 2812)
if not mod then return end
mod:SetEncounterID(3214)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1252675, sound = "warning", note = CL.leap}, -- Crush Souls
	{1252777, sound = "none", note = CL.debuffAddsCast:format(mod:SpellName(-33914))}, -- Soulbind
	{1252816, sound = "underyou", note = CL.debuffUnderYouNote}, -- Chill of Death
	{1253779, sound = "underyou", note = CL.debuffUnderYouNote}, -- Spectral Decay
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
-- Renames
--

mod:SetRenames({
	[1251023] = {CL.tank_hit}, -- Spiritbreaker (Tank Hit)
	[1252676] = { -- Crush Souls (Totems / Leap)
		CL.totems, CL.incoming:format(CL.totems), CL.you:format(CL.leap),
		notes = {CL.timerNote, CL.messageCastStartNote, CL.messageOnYouNote},
		original = {1252676, CL.incoming:format(mod:SpellName(1252676)), CL.you:format(mod:SpellName(1252676))}
	},
	[1253788] = {CL.intermission}, -- Soulrending Roar (Intermission)
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1251023, -- Spiritbreaker
		{1252676, "ME_ONLY_EMPHASIZE"}, -- Crush Souls
		1253788, -- Soulrending Roar
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
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 1)
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

function mod:SpiritbreakerTimeline(eventInfo) -- Tank Hit
	local barText = CL.count:format(self:GetRename(1251023), spiritbreakerCount)
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

function mod:CrushSoulsTimeline(eventInfo) -- Totems / Leap
	local barText = CL.count:format(self:GetRename(1252676), crushSoulsCount)
	self:CDBar(1252676, eventInfo.duration, barText, nil, eventInfo.id)
	local msgText = CL.count:format(self:GetRename(1252676, 2), crushSoulsCount)
	crushSoulsCount = crushSoulsCount + 1
	return {
		msg = barText,
		key = 1252676,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1252676, 4.5, false, self:GetRename(1252676, 3))
			self:Message(1252676, "orange", msgText)
			self:PlaySound(1252676, "alarm")
		end
	}
end

function mod:SoulrendingRoarTimeline(eventInfo) -- Intermission
	local barText = CL.count:format(self:GetRename(1253788), soulrendingRoarCount)
	self:CDBar(1253788, eventInfo.duration, barText, nil, eventInfo.id)
	soulrendingRoarCount = soulrendingRoarCount + 1
	return {
		msg = barText,
		key = 1253788,
		cancelCallback = function()
			self:Message(1253788, "cyan", barText)
			self:PlaySound(1253788, "long")
		end
	}
end
