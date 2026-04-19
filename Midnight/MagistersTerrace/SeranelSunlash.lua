--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Seranel Sunlash", 2811, 2661)
if not mod then return end
mod:SetEncounterID(3072)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1225015, sound = "info"}, -- Suppression Zone
	{1225205, sound = "warning"}, -- Wave of Silence
	{1225792, sound = "alert"}, -- Runic Mark
	{1246446, sound = "alarm"}, -- Null Reaction
})

--------------------------------------------------------------------------------
-- Locals
--

local runicMarkCount = 1
local lastRunicMarkDuration = 0
local suppressionZoneCount = 1
local hasteningWardCount = 1
local waveofSilenceCount = 1
local activeBars = {}
local activeBarBySpellId = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1225787, -- Runic Mark
		1224903, -- Suppression Zone
		1248689, -- Hastening Ward
		{1225193, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Wave of Silence
		{1225015, "PRIVATE"}, -- Suppression Zone
		{1225205, "PRIVATE"}, -- Wave of Silence
		--{1225792, "PRIVATE"}, -- Runic Mark
		{1246446, "PRIVATE"}, -- Null Reaction
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	runicMarkCount = 1
	lastRunicMarkDuration = 0
	suppressionZoneCount = 1
	hasteningWardCount = 1
	waveofSilenceCount = 1
	activeBars = {}
	activeBarBySpellId = {}
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
			if spellId == 1225787 then -- Runic Mark
				runicMarkCount = runicMarkCount - 1
			end
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration > 90 then return end -- filter placeholder bars
	if duration == 7 or duration == 29 then -- Runic Mark
		if duration == lastRunicMarkDuration then
			return -- it alternates, this ignores a second 29 which will be canceled by Wave of Silence
		end
		lastRunicMarkDuration = duration
		self:CancelBarForSpell(1225787)
		barInfo = self:RunicMarkTimeline(eventInfo)
	elseif duration == 17 then -- Suppression Zone
		barInfo = self:SuppressionZoneTimeline(eventInfo)
	elseif duration == 26 then -- Hastening Ward
		barInfo = self:HasteningWardTimeline(eventInfo)
	elseif duration == 51 then -- Wave of Silence
		barInfo = self:WaveOfSilenceTimeline(eventInfo)
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

function mod:RunicMarkTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1225787), runicMarkCount)
	self:CDBar(1225787, eventInfo.duration, barText, nil, eventInfo.id)
	runicMarkCount = runicMarkCount + 1
	return {
		msg = barText,
		key = 1225787,
		callback = function()
			self:Message(1225787, "yellow", barText)
			self:PlaySound(1225787, "alert")
		end
	}
end

function mod:SuppressionZoneTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1224903), suppressionZoneCount)
	self:CDBar(1224903, eventInfo.duration, barText, nil, eventInfo.id)
	suppressionZoneCount = suppressionZoneCount + 1
	return {
		msg = barText,
		key = 1224903,
		callback = function()
			self:Message(1224903, "orange", barText)
			self:PlaySound(1224903, "alarm")
		end
	}
end

function mod:HasteningWardTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1248689), hasteningWardCount)
	self:CDBar(1248689, eventInfo.duration, barText, nil, eventInfo.id)
	hasteningWardCount = hasteningWardCount + 1
	return {
		msg = barText,
		key = 1248689,
		callback = function()
			self:Message(1248689, "purple", barText)
			self:PlaySound(1248689, "info")
		end
	}
end

function mod:WaveOfSilenceTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1225193), waveofSilenceCount)
	self:CDBar(1225193, eventInfo.duration, barText, nil, eventInfo.id)
	waveofSilenceCount = waveofSilenceCount + 1
	return {
		msg = barText,
		key = 1225193,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1225193, "red", barText)
			self:CastBar(1225193, 5)
			self:PlaySound(1225193, "warning")
		end
	}
end
