--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taz'Rah", 2923, 2791)
if not mod then return end
mod:SetEncounterID(3285)
mod:SetRespawnTime(30)
mod:SetAuraData({
	{1222103, tip = "Taz'Rah has dashed towards you, get ready to move away from the raid."}, -- Nether Dash
	{1296967, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, tip = "You're standing in a Void Fissure, move out of it."}, -- Void Fissure
})

--------------------------------------------------------------------------------
-- Locals
--

local netherDashCount = 1
local umbralRuptureCount = 1
local voidBlastCount = 1
local darkBloomCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1222098] = {1222098, CL.you:format(mod:SpellName(1222098)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1222098, CL.you:format(mod:SpellName(1222098))}}, -- Nether Dash
	[1296963] = {1296963}, -- Umbral Rupture
	[1297017] = {1297017}, -- Void Blast
	[1300259] = {1300259}, -- Dark Bloom
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1222098, -- Nether Dash
		1296963, -- Umbral Rupture
		1297017, -- Void Blast
		1300259, -- Dark Bloom
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	netherDashCount = 1
	umbralRuptureCount = 1
	voidBlastCount = 1
	darkBloomCount = 1
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
	if duration == 6 then -- Nether Dash
		barInfo = self:NetherDashTimeline(eventInfo)
	elseif duration == 16 then -- Umbral Rupture
		barInfo = self:UmbralRuptureTimeline(eventInfo)
	elseif duration == 25 then -- Void Blast
		barInfo = self:VoidBlastTimeline(eventInfo)
	elseif duration == 31 then -- Dark Bloom
		barInfo = self:DarkBloomTimeline(eventInfo)
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

do
	local function IfOnMe(self)
		self:PlaySound(1222098, "alarm", nil, self:UnitName("player"))
	end

	function mod:NetherDashTimeline(eventInfo) -- Nether Dash
		local barText = CL.count:format(self:GetRename(1222098), netherDashCount)
		self:CDBar(1222098, eventInfo.duration, barText, nil, eventInfo.id)
		netherDashCount = netherDashCount + 1
		local timer = self:ScheduleTimer(function()
			self:StopBar(barText)
			self:PersonalMessageFromBlizzMessage(1222098, 4, false, self:GetRename(1222098, 2), nil, nil, IfOnMe)
			self:Message(1222098, "red", barText)
			self:PlaySound(1222098, "info")
		end, eventInfo.duration)
		return {
			msg = barText,
			key = 1222098,
			callback = function()
				self:Error("Nether Dash now has a callback")
			end,
			cancelCallback = function()
				if timer then
					self:CancelTimer(timer)
					timer = nil
				end
			end
		}
	end
end

function mod:UmbralRuptureTimeline(eventInfo) -- Umbral Rupture
	local barText = CL.count:format(self:GetRename(1296963), umbralRuptureCount)
	self:CDBar(1296963, eventInfo.duration, barText, nil, eventInfo.id)
	umbralRuptureCount = umbralRuptureCount + 1
	return {
		msg = barText,
		key = 1296963,
		callback = function()
			self:Message(1296963, "orange", barText)
			self:PlaySound(1296963, "alarm")
		end
	}
end

function mod:VoidBlastTimeline(eventInfo) -- Void Blast
	local barText = CL.count:format(self:GetRename(1297017), voidBlastCount)
	self:CDBar(1297017, eventInfo.duration, barText, nil, eventInfo.id)
	voidBlastCount = voidBlastCount + 1
	return {
		msg = barText,
		key = 1297017,
		callback = function()
			self:Message(1297017, "purple", barText)
			self:PlaySound(1297017, "alert")
		end
	}
end

function mod:DarkBloomTimeline(eventInfo) -- Dark Bloom
	local barText = CL.count:format(self:GetRename(1300259), darkBloomCount)
	self:CDBar(1300259, eventInfo.duration, barText, nil, eventInfo.id)
	darkBloomCount = darkBloomCount + 1
	return {
		msg = barText,
		key = 1300259,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1300259, "yellow", barText)
			self:PlaySound(1300259, "long")
		end
	}
end
