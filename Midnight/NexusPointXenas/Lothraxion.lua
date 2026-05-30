--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lothraxion", 2915, 2815)
if not mod then return end
mod:SetEncounterID(3333)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1255310, sound = "underyou", note = CL.debuffUnderYouNote}, -- Radiant Scar
	{1255335, sound = "alert", note = CL.debuffTankAfterCastNote:format(CL.extra:format(mod:SpellName(1255335), CL.tank_hit))}, -- Searing Rend
	--{1255503, sound = "none", note = CL.bomb}, -- Brilliant Dispersion (This is the post debuff, no pre debuff exists...)
})

--------------------------------------------------------------------------------
-- Locals
--

local searingRendCount = 1
local brilliantDispersionCount = 1
local flickerCount = 1
local divineGuileCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1253950] = {CL.tank_hit}, -- Searing Rend (Tank Hit)
	[1253855] = {CL.bombs, CL.you:format(CL.bomb), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1253855, CL.you:format(mod:SpellName(1253855))}}, -- Brilliant Dispersion (Bombs)
	[1255531] = {CL.charge}, -- Flicker (Charge)
	[1257595] = {CL.full_energy}, -- Divine Guile
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1253950, -- Searing Rend
		{1253855, "ME_ONLY_EMPHASIZE"}, -- Brilliant Dispersion
		1255531, -- Flicker
		1257595, -- Divine Guile
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	searingRendCount = 1
	brilliantDispersionCount = 1
	divineGuileCount = 1
	flickerCount = 1
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
	if duration == 2 or duration == 26 then -- Searing Rend
		barInfo = self:SearingRendTimeline(eventInfo)
	elseif duration == 11 or duration == 25 then -- Brilliant Dispersion
		barInfo = self:BrilliantDispersionTimeline(eventInfo)
	elseif duration == 24 or duration == 10 then -- Flicker
		barInfo = self:FlickerTimeline(eventInfo)
	elseif duration == 52 then -- Divine Guile
		barInfo = self:DivineGuileTimeline(eventInfo)
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

function mod:SearingRendTimeline(eventInfo) -- Tank Hit
	local barText = CL.count:format(self:GetRename(1253950), searingRendCount)
	self:CDBar(1253950, eventInfo.duration, barText, nil, eventInfo.id)
	searingRendCount = searingRendCount + 1
	return {
		msg = barText,
		key = 1253950,
		cancelCallback = function()
			searingRendCount = searingRendCount - 1
		end,
		callback = function()
			self:Message(1253950, "purple", barText)
			self:PlaySound(1253950, "alert")
		end
	}
end

do
	local function IfOnMe(self)
		self:PlaySound(1253855, "warning", nil, self:UnitName("player")) -- The PA sound wont currently work since it's no longer a PA
	end
	function mod:BrilliantDispersionTimeline(eventInfo) -- Bombs
		local barText = CL.count:format(self:GetRename(1253855), brilliantDispersionCount)
		self:CDBar(1253855, eventInfo.duration, barText, nil, eventInfo.id)
		brilliantDispersionCount = brilliantDispersionCount + 1
		return {
			msg = barText,
			key = 1253855,
			cancelCallback = function()
				brilliantDispersionCount = brilliantDispersionCount - 1
			end,
			callback = function()
				self:Message(1253855, "yellow", barText)
				self:PersonalMessageFromBlizzMessage(1253855, 1, false, self:GetRename(1253855, 2), nil, nil, IfOnMe)
				--self:PlaySound(1253855, "warning") -- PA sound
			end
		}
	end
end

function mod:FlickerTimeline(eventInfo) -- Charge
	local barText = CL.count:format(self:GetRename(1255531), flickerCount)
	self:CDBar(1255531, eventInfo.duration, barText, nil, eventInfo.id)
	flickerCount = flickerCount + 1
	return {
		msg = barText,
		key = 1255531,
		cancelCallback = function()
			flickerCount = flickerCount - 1
		end,
		callback = function()
			self:Message(1255531, "red", barText)
			self:PlaySound(1255531, "alarm")
		end
	}
end

function mod:DivineGuileTimeline(eventInfo) -- Full Energy
	local barText = CL.count:format(self:GetRename(1257595), divineGuileCount)
	self:CDBar(1257595, eventInfo.duration, barText, nil, eventInfo.id)
	divineGuileCount = divineGuileCount + 1
	return {
		msg = barText,
		key = 1257595,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1257595, "cyan", barText)
			for eventID, barInfo in next, activeBars do
				if barInfo.key ~= 1257595 then
					self:StopBar(barInfo.msg)
					-- Bars are cancelled by Blizz on cast end instead of cast start, and not all bars are cancelled, so we do it instead
					if not self:IsWiping() and barInfo.cancelCallback then
						barInfo.cancelCallback()
					end
					activeBars[eventID] = nil
				end
			end
			self:PlaySound(1257595, "long")
		end
	}
end
