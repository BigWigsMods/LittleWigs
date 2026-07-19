--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Atroxus", 2923, 2792)
if not mod then return end
mod:SetEncounterID(3286)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1222484, sound = "underyou"}, -- Poison Pool
	{1222642, sound = "none"}, -- Hulking Claw
	{1226031, sound = "none"}, -- Poison Splash
	{1263971, sound = "none"}, -- Lingering Poison
})

--------------------------------------------------------------------------------
-- Locals
--

local hulkingClawCount = 1
local poisonSplashCount = 1
local provokeCreeperCount = 1
local noxiousBreathCount = 1
local monstrousRoarCount = 1
local count20 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1222642] = {1222642}, -- Hulking Claw
	[1226120] = {1226120}, -- Poison Splash
	[1222371] = {1222371}, -- Provoke Creeper
	[1222721] = {1222721}, -- Noxious Breath
	[1262497] = {1262497}, -- Monstrous Roar
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1222642, -- Hulking Claw
		1226120, -- Poison Splash
		1222371, -- Provoke Creeper
		1222721, -- Noxious Breath
		1262497, -- Monstrous Roar
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	hulkingClawCount = 1
	poisonSplashCount = 1
	provokeCreeperCount = 1
	noxiousBreathCount = 1
	monstrousRoarCount = 1
	count20 = 1
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
	if duration > 100 or C_EncounterTimeline.GetEventState(eventInfo.id) == 1 then -- Paused
		-- filter very long bars or paused placeholders, they are always canceled
		-- XXX might not be needed anymore in 12.1
		return
	end
	if BigWigsLoader.isNext then -- 12.1
		if duration == 5 or (duration == 20 and count20 % 2 == 1) then -- Poison Splash
			barInfo = self:PoisonSplashTimeline(eventInfo)
		elseif duration == 10 or (duration == 20 and count20 % 2 == 0) then -- Hulking Claw
			barInfo = self:HulkingClawTimeline(eventInfo)
		elseif duration == 15 or duration == 30 then -- Noxious Breath
			barInfo = self:NoxiousBreathTimeline(eventInfo)
		elseif duration == 35 then -- Monstrous Roar / Provoke Creeper
			barInfo = self:MonstrousRoarTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
		end
		if duration == 20 then
			count20 = count20 + 1
		end
	else -- XXX remove in 12.1
		if duration == 7 or duration == 25 then -- Hulking Claw
			if duration == 25 and hulkingClawCount > (monstrousRoarCount - 1) * 2 then
				return -- always canceled by Monstrous Stomp
			end
			barInfo = self:HulkingClawTimeline(eventInfo)
		elseif duration == 13 or duration == 23 then -- Poison Splash
			if duration == 23 and poisonSplashCount > (monstrousRoarCount - 1) * 2 then
				return -- always canceled by Monstrous Stomp
			end
			barInfo = self:PoisonSplashTimeline(eventInfo)
		elseif duration == 17 then -- Provoke Creeper
			barInfo = self:ProvokeCreeperTimeline(eventInfo)
		elseif duration == 21 then -- Noxious Breath
			barInfo = self:NoxiousBreathTimeline(eventInfo)
		elseif duration == 42 then -- Monstrous Stomp
			barInfo = self:MonstrousRoarTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
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

function mod:HulkingClawTimeline(eventInfo) -- Hulking Claw
	local barText = CL.count:format(self:GetRename(1222642), hulkingClawCount)
	self:CDBar(1222642, eventInfo.duration, barText, nil, eventInfo.id)
	hulkingClawCount = hulkingClawCount + 1
	return {
		msg = barText,
		key = 1222642,
		callback = function()
			self:Message(1222642, "purple", barText)
			self:PlaySound(1222642, "alert")
		end
	}
end

function mod:PoisonSplashTimeline(eventInfo) -- Poison Splash
	local barText = CL.count:format(self:GetRename(1226120), poisonSplashCount)
	self:CDBar(1226120, eventInfo.duration, barText, nil, eventInfo.id)
	poisonSplashCount = poisonSplashCount + 1
	return {
		msg = barText,
		key = 1226120,
		callback = function()
			self:Message(1226120, "yellow", barText)
			self:PlaySound(1226120, "long")
		end
	}
end

function mod:ProvokeCreeperTimeline(eventInfo) -- Provoke Creeper
	local barText = CL.count:format(self:GetRename(1222371), provokeCreeperCount)
	self:CDBar(1222371, eventInfo.duration, barText, nil, eventInfo.id)
	provokeCreeperCount = provokeCreeperCount + 1
	return {
		msg = barText,
		key = 1222371,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1222371, "cyan", barText)
			self:PlaySound(1222371, "info")
		end
	}
end

function mod:NoxiousBreathTimeline(eventInfo) -- Noxious Breath
	local barText = CL.count:format(self:GetRename(1222721), noxiousBreathCount)
	self:CDBar(1222721, eventInfo.duration, barText, nil, eventInfo.id)
	noxiousBreathCount = noxiousBreathCount + 1
	return {
		msg = barText,
		key = 1222721,
		callback = function()
			self:Message(1222721, "red", barText)
			self:PlaySound(1222721, "alarm")
		end
	}
end

function mod:MonstrousRoarTimeline(eventInfo) -- Monstrous Roar
	local barText = CL.count:format(self:GetRename(1262497), monstrousRoarCount)
	self:CDBar(1262497, eventInfo.duration, barText, nil, eventInfo.id)
	monstrousRoarCount = monstrousRoarCount + 1
	if BigWigsLoader.isNext then -- XXX 12.1
		-- Provoke Creeper happens 3s after Monstrous Roar
		local provokeText = CL.count:format(self:GetRename(1222371), provokeCreeperCount)
		self:CDBar(1222371, eventInfo.duration + 3, provokeText) -- Provoke Creeper
		self:ScheduleTimer(function()
			self:StopBar(provokeText)
			self:StopBlizzMessages(1)
			self:Message(1222371, "cyan", provokeText) -- Provoke Creeper
			self:PlaySound(1222371, "info") -- Provoke Creeper
		end, eventInfo.duration + 3)
		provokeCreeperCount = provokeCreeperCount + 1
	end
	return {
		msg = barText,
		key = 1262497,
		callback = function()
			self:Message(1262497, "orange", barText)
			self:PlaySound(1262497, "alarm")
		end
	}
end
