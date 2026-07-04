--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xathuux the Annihilator", 2813, 2681)
if not mod then return end
mod:SetEncounterID(3103)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{473898, sound = "alarm"}, -- Legion Strike
	{474234, sound = "underyou"}, -- Burning Steps
	{1214650, sound = "alert"}, -- Fel Light
})

--------------------------------------------------------------------------------
-- Locals
--

local legionStrikeCount = 1
local axeTossCount = 1
local infernalCrushCount = 1
local demonicRageCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[473898] = {473898},  -- Legion Strike
	[1214637] = {1214637, CL.you:format(mod:SpellName(1214637)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1214637, CL.you:format(mod:SpellName(1214637))}}, -- Axe Toss
	[1295453] = {1295453}, -- Infernal Crush
	[474197] = {474197},  -- Demonic Rage
})

--------------------------------------------------------------------------------
-- Initialization
--

if BigWigsLoader.isNext then
	function mod:GetOptions()
		return {
			473898, -- Legion Strike
			1214637, -- Axe Toss
			1295453, -- Infernal Crush
			474197, -- Demonic Rage
		}
	end
else -- XXX remove in 12.1
	function mod:GetOptions()
		return {
			473898, -- Legion Strike
			1214637, -- Axe Toss
			474197, -- Demonic Rage
		}
	end
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	legionStrikeCount = 1
	axeTossCount = 1
	infernalCrushCount = 1
	demonicRageCount = 1
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
	if duration < 1 or duration > 100 then return end -- filter placeholder bars
	if duration == 6 or duration == 27 then -- Legion Strike
		barInfo = self:LegionStrikesTimeline(eventInfo)
	elseif duration == 15 then -- Axe Toss
		barInfo = self:AxeTossTimeline(eventInfo)
	elseif BigWigsLoader.isNext and (not self:IsWiping() and duration == 30) then -- Infernal Crush (XXX remove check in 12.1)
		barInfo = self:InfernalCrushTimeline(eventInfo)
	elseif duration == 35 then -- Demonic Rage
		barInfo = self:DemonicRageTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
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
			-- paused bars are never resumed, cancel them now
			self:StopBar(barInfo.msg)
			if barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[eventID] = nil
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

function mod:LegionStrikesTimeline(eventInfo) -- Legion Strike
	local barText = CL.count:format(self:GetRename(473898), legionStrikeCount)
	self:CDBar(473898, eventInfo.duration, barText, nil, eventInfo.id)
	legionStrikeCount = legionStrikeCount + 1
	return {
		msg = barText,
		key = 473898,
		callback = function()
			self:Message(473898, "purple", barText)
			self:PlaySound(473898, "alert")
		end,
		cancelCallback = function()
			legionStrikeCount = legionStrikeCount - 1
		end
	}
end

function mod:AxeTossTimeline(eventInfo) -- Axe Toss
	local barText = CL.count:format(self:GetRename(1214637), axeTossCount)
	self:CDBar(1214637, eventInfo.duration, barText, nil, eventInfo.id)
	axeTossCount = axeTossCount + 1
	return {
		msg = barText,
		key = 1214637,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1214637, 1, false, self:GetRename(1214637, 2))
			self:Message(1214637, "red", barText)
			self:PlaySound(1214637, "alarm")
		end
	}
end

function mod:InfernalCrushTimeline(eventInfo) -- Infernal Crush
	local barText = CL.count:format(self:GetRename(1295453), infernalCrushCount)
	self:CDBar(1295453, eventInfo.duration, barText, nil, eventInfo.id)
	infernalCrushCount = infernalCrushCount + 1
	return {
		msg = barText,
		key = 1295453,
		callback = function()
			self:Message(1295453, "orange", barText)
			self:PlaySound(1295453, "alarm")
		end
	}
end

function mod:DemonicRageTimeline(eventInfo) -- Demonic Rage
	local barText = CL.count:format(self:GetRename(474197), demonicRageCount)
	self:CDBar(474197, eventInfo.duration, barText, nil, eventInfo.id)
	demonicRageCount = demonicRageCount + 1
	return {
		msg = barText,
		key = 474197,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(474197, "yellow", barText)
			self:PlaySound(474197, "long")
		end
	}
end
