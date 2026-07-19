--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mchimba the Embalmer", 1762, 2171)
if not mod then return end
mod:RegisterEnableMob(134993) -- Mchimba the Embalmer
mod:SetEncounterID(2142)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		267639, -- Burn Corruption
		267618, -- Drain Fluids
		267702, -- Entomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BurnCorruption", 267639)
	self:Log("SPELL_AURA_APPLIED", "DrainFluids", 267618)
	self:Log("SPELL_AURA_APPLIED", "EntombApplied", 267702)
	self:Log("SPELL_AURA_REMOVED", "EntombRemoved", 267702)
end

function mod:OnEngage()
	self:CDBar(267639, 11.1) -- Burn Corruption
	self:CDBar(267618, 17.9) -- Drain Fluids
	self:CDBar(267702, 29.5) -- Entomb
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local drainFluidsCount = 1
local burnCorruptionCount = 1
local awakeningSlamCount = 1
local entombCount = 1
local count30 = 1
local count32 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[267618] = {267618}, -- Drain Fluids
		[267639] = {267639}, -- Burn Corruption
		[1312146] = {1312146}, -- Awakening Slam
		[267702] = {267702}, -- Entomb
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			267618, -- Drain Fluids
			267639, -- Burn Corruption
			1312146, -- Awakening Slam
			267702, -- Entomb
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		drainFluidsCount = 1
		burnCorruptionCount = 1
		awakeningSlamCount = 1
		entombCount = 1
		count30 = 1
		count32 = 1
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
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration > 90 then -- filter placeholder bars (Awakening Slam, Entomb)
		return
	elseif duration == 30 and count30 % 3 == 0 then -- filter Burn Corruption -> canceled by Entomb
		count30 = count30 + 1
		return
	elseif duration == 32 and count32 % 2 == 0 then -- filter Drain Fluids -> canceled by Entomb
		count32 = count32 + 1
		return
	end
	if duration == 5 or duration == 32 then -- Drain Fluids
		barInfo = self:DrainFluidsTimeline(eventInfo)
	elseif duration == 20 or (duration == 30 and count30 % 3 == 2) then -- Burn Corruption
		barInfo = self:BurnCorruptionTimeline(eventInfo)
	elseif duration == 30 and count30 % 3 == 1 then -- Awakening Slam
		barInfo = self:AwakeningSlamTimeline(eventInfo)
	elseif duration == 60 then -- Entomb
		barInfo = self:EntombTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 30 then
		count30 = count30 + 1
	elseif duration == 32 then
		count32 = count32 + 1
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

function mod:DrainFluidsTimeline(eventInfo) -- Drain Fluids
	local barText = CL.count:format(self:GetRename(267618), drainFluidsCount)
	self:CDBar(267618, eventInfo.duration, barText, nil, eventInfo.id)
	drainFluidsCount = drainFluidsCount + 1
	return {
		msg = barText,
		key = 267618,
		callback = function()
			self:Message(267618, "red", barText)
			self:PlaySound(267618, "alert")
		end
	}
end

function mod:BurnCorruptionTimeline(eventInfo) -- Burn Corruption
	local barText = CL.count:format(self:GetRename(267639), burnCorruptionCount)
	self:CDBar(267639, eventInfo.duration, barText, nil, eventInfo.id)
	burnCorruptionCount = burnCorruptionCount + 1
	return {
		msg = barText,
		key = 267639,
		callback = function()
			self:Message(267639, "orange", barText)
			self:PlaySound(267639, "alarm")
		end
	}
end

function mod:AwakeningSlamTimeline(eventInfo) -- Awakening Slam
	local barText = CL.count:format(self:GetRename(1312146), awakeningSlamCount)
	self:CDBar(1312146, eventInfo.duration, barText, nil, eventInfo.id)
	awakeningSlamCount = awakeningSlamCount + 1
	return {
		msg = barText,
		key = 1312146,
		callback = function()
			self:Message(1312146, "cyan", barText)
			self:PlaySound(1312146, "info")
		end
	}
end

function mod:EntombTimeline(eventInfo) -- Entomb
	local barText = CL.count:format(self:GetRename(267702), entombCount)
	self:CDBar(267702, eventInfo.duration, barText, nil, eventInfo.id)
	entombCount = entombCount + 1
	return {
		msg = barText,
		key = 267702,
		callback = function()
			self:TargetMessageFromBlizzMessage(267702, 1, "yellow", false)
			self:PlaySound(267702, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurnCorruption(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 13) -- pull:11.1, 13.3, 23.9, 13.4, 19.5, 32.8
	self:PlaySound(args.spellId, "alarm")
end

function mod:DrainFluids(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 17) -- pull:17.9, 37.3, 17.0, 17.1
end

function mod:EntombApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "long", nil, args.destName)
	self:StopBar(267639) -- Burn Corruption
	self:StopBar(267618) -- Drain Fluids
	self:StopBar(267702) -- Entomb
end

function mod:EntombRemoved(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CDBar(267639, 10.4) -- Burn Corruption
	self:CDBar(267618, 17.3) -- Drain Fluids
	self:CDBar(args.spellId, 57.3) -- Entomb XXX Need longer logs
end
